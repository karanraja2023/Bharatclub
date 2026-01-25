import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organization/animation/animation_background.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/constant/image_constants.dart';
import 'package:organization/screens/splash_screen/controller/splash_screen_contoller.dart';
import 'package:organization/utils/app_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
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
    _scaleAnimation = CurvedAnimation(
      parent: _scaleController,
      curve: Curves.elasticOut,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeIn,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: _scaleAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildLogoCard(),
                ),
              ),
              SizedBox(height: 40.h),
              SlideTransition(
                position: _slideAnimation,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: _buildAppNameText(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.r),
        ),
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
              borderRadius: BorderRadius.circular(
                12.r,
              ), // 🔥 Rounded corners for image
              child: Image.asset(
                ImageAssetsConstants.goParkingLogoJpg,
                height: 100.h,
                fit: BoxFit
                    .cover, // Optional, but helps image fill with rounded corners
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 100.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.cAppColors.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Icon(
                      Icons.business,
                      size: 80.sp,
                      color: AppColors.cAppColors,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppNameText() {
    return Column(
      children: [
        Text(
          'Welcome to',
          style: getTextBold(size: 16.sp, colors: Colors.grey),
        ),
        SizedBox(height: 8.h),
        Text(
          'Bharat Club',
          style: getTextBold(size: 28.sp, colors: AppColors.cAppColors),
        ),
        SizedBox(height: 4.h),
        Text(
          'Manage everything efficiently',
          style: getTextRegular(size: 13.sp, colors: Colors.grey),
        ),
      ],
    );
  }
}
