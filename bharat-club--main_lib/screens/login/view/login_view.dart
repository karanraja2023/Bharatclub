import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organization/animation/animation_background.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/screens/login/controller/login_controller.dart';
import 'package:organization/utils/app_text.dart';

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
      if (!_isDisposed && mounted) {
        _masterController.forward();
      }
    });
  }

  @override
  void dispose() {
    _isDisposed = true;
    _masterController.stop();
    _masterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBackgroundWidget(
            primaryColor: AppColors.secondaryGreen,
            secondaryColor: AppColors.tertiaryGreen,
            particleColor: AppColors.secondaryGreen,
            child: Form(
              key: controller.formKey,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(flex: 1, child: SizedBox(height: 20.h)),
                              _buildLogoSection(),
                              SizedBox(height: 30.h),
                              _buildLoginForm(),
                              Flexible(flex: 1, child: SizedBox(height: 20.h)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _masterController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoAnimation.value,
          child: Opacity(
            opacity: _fadeAnimation.value,
            child: Column(
              children: [
                Hero(
                  tag: 'app_logo',
                  child: Container(
                    padding: EdgeInsets.all(24.r),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Colors.white.withOpacity(0.3),
                          Colors.white.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondaryGreen.withOpacity(0.1),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                        12.r,
                      ), // <-- round the image
                      child: Image.asset(
                        'assets/images/logo.png',
                        height: 80.h,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.high,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.business,
                            size: 80.h,
                            color: AppColors.secondaryGreen,
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 32.h),
                // Text(
                //   'Welcome Back',
                //   style: getTextBold(
                //     colors: AppColors.textPrimary,
                //     size: 32.sp,
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoginForm() {
    return AnimatedBuilder(
      animation: _masterController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            _slideAnimation.value.dx * MediaQuery.of(context).size.width,
            _slideAnimation.value.dy * MediaQuery.of(context).size.height,
          ),
          child: Opacity(
            opacity: _formAnimation.value,
            child: Container(
              padding: EdgeInsets.all(32.r),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.cardBackground,
                    AppColors.cardBackground.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: Colors.white.withOpacity(0.5),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryGreen.withOpacity(0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                  BoxShadow(
                    color: AppColors.shadow.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Registered Account Login',
                    style: getTextSemiBold(
                      colors: AppColors.textPrimary,
                      size: 18.sp,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  _buildTextField(
                    controller: controller.mEmailController,
                    hintText: 'Email Id',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    validator: controller.validateEmail,
                  ),
                  SizedBox(height: 24.h),
                  Obx(
                    () => _buildTextField(
                      controller: controller.mPasswordController,
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      obscureText: controller.hidePassword.value,
                      keyboardType: TextInputType.visiblePassword,
                      textInputAction: TextInputAction.done,
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.hidePassword.value
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: AppColors.secondaryGreen,
                          size: 22.r,
                        ),
                        onPressed: controller.showPassword,
                      ),
                      validator: controller.validatePassword,
                      onFieldSubmitted: (_) => _handleLogin(),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.forgot);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: getTextMedium(
                          colors: AppColors.secondaryGreen,
                          size: 14.sp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  _buildLoginButton(),
                  SizedBox(height: 16.h),
                  _buildJoinClubButton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool isPassword = false,
    bool? obscureText,
    Widget? suffixIcon,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String? Function(String?)? validator,
    Function(String)? onFieldSubmitted,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText ?? false,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        onFieldSubmitted: onFieldSubmitted,
        style: getTextMedium(colors: AppColors.textPrimary, size: 16.sp),
        cursorColor: AppColors.secondaryGreen,
        validator: validator,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: getTextRegular(
            colors: AppColors.textSecondary,
            size: 16.sp,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.only(left: 16.w, right: 12.w),
            child: Icon(icon, color: AppColors.secondaryGreen, size: 22.r),
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: AppColors.cardBackground,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 18.h,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: Colors.grey.shade200, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.secondaryGreen, width: 2.5),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.error, width: 1.5),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(color: AppColors.error, width: 2.5),
          ),
          errorStyle: getTextMedium(colors: AppColors.error, size: 12.sp),
          errorMaxLines: 2,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 56.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.secondaryGreen, AppColors.secondaryGreen],
          ),
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.secondaryGreen.withOpacity(0.4),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16.r),
            onTap: controller.isLoading.value ? null : _handleLogin,
            child: Center(
              child: controller.isLoading.value
                  ? SizedBox(
                      width: 24.r,
                      height: 24.r,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Sign In',
                          style: getTextSemiBold(
                            colors: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20.r,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildJoinClubButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryGreen, width: 2),
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.cardBackground,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Get.toNamed(AppRoutes.agreeToTerms);
          },
          child: Center(
            child: Text(
              'Join Club',
              style: getTextSemiBold(
                colors: AppColors.secondaryGreen,
                size: 18.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleLogin() {
    if (_isDisposed || !mounted) return;

    FocusScope.of(context).unfocus();

    // Call controller's handleLogin method which manages validation
    controller.handleLogin();
  }
}
