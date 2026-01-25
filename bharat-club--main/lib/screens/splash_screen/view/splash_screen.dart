import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/animation/animation_background.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/constant/image_constants.dart';
import 'package:mobileapp/screens/splash_screen/controller/splash_screen_contoller.dart';
import 'package:mobileapp/utils/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late final SplashController controller;
  late AnimationController _scaleController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    controller = Get.put(SplashController());
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut);

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) {
        _scaleController.forward();
        _fadeController.forward();
      }
    });

    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) {
        _slideController.forward();
      }
    });
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackgroundWidget(
        primaryColor: AppColors.cAppColors,
        secondaryColor: AppColors.cAppColors,
        particleColor: AppColors.cAppColors,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Check if screen width is greater than 600 (Web/Tablet)
            if (constraints.maxWidth > 600) {
              return _buildWebView();
            } else {
              return _buildMobileView();
            }
          },
        ),
      ),
    );
  }

  // --- RESPONSIVE VIEWS ---

  Widget _buildMobileView() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _animatedLogo(),
          SizedBox(height: 40.h),
          _animatedText(),
        ],
      ),
    );
  }

  Widget _buildWebView() {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _animatedLogo(),
          SizedBox(width: 60.w), // Horizontal spacing for web
          _animatedText(isWeb: true),
        ],
      ),
    );
  }

  // --- REUSABLE ANIMATED COMPONENTS ---

  Widget _animatedLogo() {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildLogoCard(),
      ),
    );
  }

  Widget _animatedText({bool isWeb = false}) {
    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildAppNameText(isWeb: isWeb),
      ),
    );
  }

  // --- UI ATOMS ---

  Widget _buildLogoCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.cAppColors.withOpacity(0.2),
            blurRadius: 30.r,
            offset: Offset(0, 10.h),
            spreadRadius: 5.r,
          ),
        ],
      ),
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.all(30.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.r),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, AppColors.cAppColors.withOpacity(0.02)],
            ),
          ),
          child: Hero(
            tag: 'app_logo',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.r),
              child: Image.asset(
                ImageAssetsConstants.goParkingLogoJpg,
                height: 120.h, // Slightly larger logo for web/mobile
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => _buildErrorIcon(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppNameText({bool isWeb = false}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: isWeb ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        Text(
          'Welcome to',
          style: getTextBold(size: isWeb ? 10.sp : 16.sp, colors: Colors.grey),
        ),
        SizedBox(height: 8.h),
        Text(
          'Bharat Club',
          style: getTextBold(size: isWeb ? 18.sp : 28.sp, colors: AppColors.cAppColors),
        ),
        SizedBox(height: 4.h),
        Text(
          'Manage everything efficiently',
          style: getTextRegular(size: isWeb ? 8.sp : 13.sp, colors: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildErrorIcon() {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
        color: AppColors.cAppColors.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Icon(Icons.business, size: 80.sp, color: AppColors.cAppColors),
    );
  }
}