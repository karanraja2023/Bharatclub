import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/animation/animation_background.dart';
import 'package:mobileapp/app/routes_name.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/screens/login/controller/login_controller.dart';
import 'package:mobileapp/utils/app_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late final LoginScreenController controller;
  late AnimationController _masterController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _formAnimation;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      LoginScreenController(),
      tag: 'login_controller',
      permanent: true,
    );
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    _masterController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOutCubic),
      ),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _masterController,
            curve: const Interval(0.3, 0.8, curve: Curves.easeOutQuart),
          ),
        );
    _formAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.4, 1.0, curve: Curves.easeOutCubic),
      ),
    );
  }

  void _startAnimations() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_isDisposed && mounted) _masterController.forward();
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _masterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackgroundWidget(
        primaryColor: AppColors.secondaryGreen,
        secondaryColor: AppColors.tertiaryGreen,
        particleColor: AppColors.secondaryGreen,
        child: Form(
          key: controller.formKey,
          child: LayoutBuilder(
            builder: (context, constraints) {
              bool isWeb = constraints.maxWidth > 850;
              return Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: isWeb ? 40.w : 24.w,
                    vertical: 20.h,
                  ),
                  child: isWeb ? _buildWebLayout() : _buildMobileLayout(),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // --- LAYOUTS ---

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildLogoSection(isWeb: false),
        SizedBox(height: 30.h),
        _buildLoginForm(isWeb: false),
      ],
    );
  }

  Widget _buildWebLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Side: Logo & Branding
        Expanded(child: _buildLogoSection(isWeb: true)),

        // Right Side: Login Card
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450.w),
              child: _buildLoginForm(isWeb: true),
            ),
          ),
        ),
      ],
    );
  }

  // --- UI COMPONENTS ---

  Widget _buildLogoSection({required bool isWeb}) {
    return AnimatedBuilder(
      animation: _masterController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    padding: EdgeInsets.all(isWeb ? 35.r : 24.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Image.asset(
                      'assets/images/logo.png',
                      height: isWeb ? 130.h : 80.h,
                      fit: BoxFit.contain,
                      errorBuilder: (c, e, s) => Icon(
                        Icons.business,
                        size: 80.h,
                        color: AppColors.secondaryGreen,
                      ),
                    ),
                  ),
                ),
                if (isWeb) ...[
                  SizedBox(height: 25.h),
                  Text(
                    'Bharat Club',
                    style: getTextBold(
                      size: 15.sp,
                      colors: AppColors.secondaryGreen,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Manage everything efficiently',
                    textAlign: TextAlign.center,
                    style: getTextRegular(
                      size: 10.sp,
                      colors: AppColors.indiaOrange,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm({required bool isWeb}) {
    return AnimatedBuilder(
      animation: _masterController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value.dy * 30),
          child: Opacity(
            opacity: _formAnimation.value,
            child: Container(
              padding: EdgeInsets.all(isWeb ? 40.r : 32.r),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 30,
                    offset: const Offset(0, 15),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Registered Account Login',
                    style: getTextSemiBold(
                      colors: AppColors.textPrimary,
                      size: isWeb ? 8.sp : 18.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildTextField(
                    isWeb: isWeb,
                    controller: controller.mEmailController,
                    hintText: 'Email Id',
                    icon: Icons.email_outlined,
                    validator: controller.validateEmail,
                  ),
                  SizedBox(height: 18.h),
                  Obx(
                    () => _buildTextField(
                      isWeb: isWeb,
                      controller: controller.mPasswordController,
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      obscureText: controller.hidePassword.value,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.hidePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: isWeb ? 10.sp : 20.r,
                        ),
                        onPressed: controller.showPassword,
                        color: AppColors.secondaryGreen,
                      ),
                      validator: controller.validatePassword,
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed(AppRoutes.forgot),
                      child: Text(
                        'Forgot Password?',
                        style: getTextMedium(
                          colors: AppColors.secondaryGreen,
                          size: isWeb ? 6.sp : 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  _buildButton(
                    isWeb: isWeb,
                    text: 'Sign In',
                    isPrimary: true,
                    onTap: controller.handleLogin,
                  ),
                  SizedBox(height: 16.h),
                  _buildButton(
                    isWeb: isWeb,
                    text: 'Join Club',
                    isPrimary: false,
                    onTap: () => Get.toNamed(AppRoutes.agreeToTerms),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required bool isWeb,
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool? obscureText,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      style: getTextMedium(
        colors: AppColors.textPrimary,
        size: isWeb ? 7.sp : 16.sp,
      ),
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: getTextRegular(
          colors: AppColors.textSecondary,
          size: isWeb ? 7.sp : 16.sp,
        ),
        prefixIcon: Container(
          margin: EdgeInsets.only(
            left: isWeb ? 4.sp : 0,
            right: isWeb ? 2.sp : 0,
          ),
          child: Icon(
            icon,
            color: AppColors.secondaryGreen,
            size: isWeb ? 10.sp : 22.r,
          ),
        ),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: EdgeInsets.symmetric(
          vertical: isWeb ? 22.h : 18.h,
          horizontal: isWeb ? 19.w : 12.w,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.secondaryGreen, width: 2),
        ),
      ),
    );
  }

  Widget _buildButton({
    required bool isWeb,
    required String text,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return Obx(
      () => InkWell(
        onTap: controller.isLoading.value ? null : onTap,
        child: Container(
          width: double.infinity,
          height: isWeb ? 60.h : 56.h,
          decoration: BoxDecoration(
            color: isPrimary ? AppColors.secondaryGreen : Colors.transparent,
            borderRadius: BorderRadius.circular(16.r),
            border: isPrimary
                ? null
                : Border.all(color: AppColors.secondaryGreen, width: 2),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: AppColors.secondaryGreen.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: controller.isLoading.value && isPrimary
                ? SizedBox(
                    height: 20.r,
                    width: 20.r,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Text(
                    text,
                    style: getTextSemiBold(
                      colors: isPrimary
                          ? Colors.white
                          : AppColors.secondaryGreen,
                      size: isWeb ? 8.sp : 18.sp,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
