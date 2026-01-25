import 'package:flutter/material.dart';

class AnimatedBackgroundWidget extends StatefulWidget {
  final Color primaryColor;

  final Color secondaryColor;

  final Color particleColor;

  final int particleCount;

  final Duration animationDuration;
  final Widget child;

  const AnimatedBackgroundWidget({
    super.key,
    required this.child,
    this.primaryColor = const Color(0xFF36B83C),
    this.secondaryColor = const Color(0xFF2E9E34),
    this.particleColor = const Color(0xFF36B83C),
    this.particleCount = 15,
    this.animationDuration = const Duration(milliseconds: 4000),
  });

  @override
  State<AnimatedBackgroundWidget> createState() =>
      _AnimatedBackgroundWidgetState();
}

class _AnimatedBackgroundWidgetState extends State<AnimatedBackgroundWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _particleController;
  late Animation<double> _particleAnimation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimation();
    _startAnimation();
  }

  void _initializeAnimation() {
    _particleController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.easeInOut),
    );
  }

  void _startAnimation() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed && mounted) {
        _particleController.repeat(reverse: true);
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _particleController.stop();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            widget.primaryColor.withOpacity(0.1),
            Colors.white,
            widget.secondaryColor.withOpacity(0.05),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Animated particles background
          AnimatedBuilder(
            animation: _particleAnimation,
            builder: (context, child) {
              return RepaintBoundary(
                child: CustomPaint(
                  painter: ParticlesPainter(
                    animationValue: _particleAnimation.value,
                    particleColor: widget.particleColor,
                    particleCount: widget.particleCount,
                  ),
                  size: Size.infinite,
                ),
              );
            },
          ),
          // Child widget
          widget.child,
        ],
      ),
    );
  }
}

/// Custom painter for drawing animated particles
class ParticlesPainter extends CustomPainter {
  final double animationValue;
  final Color particleColor;
  final int particleCount;

  ParticlesPainter({
    required this.animationValue,
    required this.particleColor,
    required this.particleCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    for (int i = 0; i < particleCount; i++) {
      final progress = (animationValue + i * 0.1) % 1.0;
      final opacity = (1.0 - progress) * 0.3;

      paint.color = particleColor.withOpacity(opacity);

      final x = (i * 47.3) % size.width;
      final y = size.height * progress;
      final radius = 2.0 + (progress * 3.0);

      canvas.drawCircle(Offset(x, y), radius, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlesPainter oldDelegate) {
    return animationValue != oldDelegate.animationValue ||
        particleColor != oldDelegate.particleColor ||
        particleCount != oldDelegate.particleCount;
  }
}
