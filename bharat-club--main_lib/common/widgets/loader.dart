import 'package:flutter/material.dart';
import 'package:organization/app_theme/theme/app_theme.dart';

class CustomLoader extends StatelessWidget {
  final double size;
  final Color color;

  const CustomLoader({
    super.key,
    this.size = 50, 
    this.color = AppColors.secondaryGreen,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: CircularProgressIndicator(
          strokeWidth: 4,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}