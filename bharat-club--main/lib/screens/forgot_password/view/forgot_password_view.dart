import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/animation/animation_background.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/screens/forgot_password/controller/forgot_password_controller.dart';
import 'package:mobileapp/utils/app_text.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen>
    with SingleTickerProviderStateMixin {
  late final ForgotPasswordScreenController controller;
  final _formKey = GlobalKey<FormState>();

  late AnimationController _masterController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _logoAnimation;
  late Animation<double> _formAnimation;

  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    controller = Get.put(ForgotPasswordScreenController());
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
        particleColor: AppColors.tertiaryGreen,
        child: Form(
          key: _formKey,
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
        _buildFormSection(isWeb: false),
      ],
    );
  }

  Widget _buildWebLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(child: _buildLogoSection(isWeb: true)),
        Expanded(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 450.w),
              child: _buildFormSection(isWeb: true),
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
                  tag: 'login_logo',
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
                        size: isWeb ? 60.h : 80.h,
                        color: AppColors.secondaryGreen,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 25.h),
                Text(
                  'Reset Password',
                  style: getTextBold(
                    colors: isWeb ? AppColors.secondaryGreen : AppColors.textPrimary,
                    size: isWeb ? 15.sp : 32.sp,
                  ),
                ),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isWeb ? 40.w : 0),
                  child: Text(
                    'Enter your email to receive a password reset link',
                    textAlign: TextAlign.center,
                    style: getTextRegular(
                      colors: isWeb ? AppColors.indiaOrange : AppColors.textSecondary,
                      size: isWeb ? 8.sp : 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormSection({required bool isWeb}) {
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
                border: Border.all(color: Colors.white.withOpacity(0.5)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryGreen.withOpacity(0.1),
                    blurRadius: 40,
                    offset: const Offset(0, 20),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTextField(isWeb: isWeb),
                  SizedBox(height: isWeb ? 20.h : 32.h),
                  _buildSubmitButton(isWeb: isWeb),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Registered Account Login',
                      style: getTextMedium(
                        colors: AppColors.secondaryGreen,
                        size: isWeb ? 6.sp : 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField({required bool isWeb}) {
    return Obx(
      () => Container(
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
          controller: controller.mEmailController,
          style: getTextMedium(
            colors: AppColors.textPrimary,
            size: isWeb ? 7.sp : 16.sp,
          ),
          cursorColor: AppColors.secondaryGreen,
          onChanged: (value) {
            if (controller.emailValidator.value) {
              controller.emailValidator.value = false;
            }
          },
          decoration: InputDecoration(
            hintText: 'Email ID',
            hintStyle: getTextRegular(
              colors: AppColors.textSecondary,
              size: isWeb ? 7.sp : 16.sp,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.only(left: isWeb?4.sp:0),
              child: Icon(
                Icons.email_outlined,
                color: AppColors.secondaryGreen,
                size: isWeb ? 10.sp : 22.r,
              ),
            ),
            filled: true,
            fillColor: AppColors.cardBackground,
            contentPadding: EdgeInsets.symmetric(
              vertical: isWeb ? 22.h : 18.h,
              horizontal: isWeb ?19.w:12.w,
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
              borderSide: BorderSide(
                color: AppColors.secondaryGreen,
                width: 2.5,
              ),
            ),
            errorText: controller.emailValidator.value
                ? controller.seEmailValidator.value
                : null,
            errorStyle: getTextMedium(
              colors: AppColors.error,
              size: isWeb ? 5.sp : 12.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton({required bool isWeb}) {
    return Container(
      width: double.infinity,
      height: isWeb ? 60.h : 56.h,
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
          onTap: _handleSubmit,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Submit',
                  style: getTextSemiBold(
                    colors: Colors.white,
                    size: isWeb ? 8.sp : 18.sp,
                  ),
                ),
                SizedBox(width: 8.w),
                Icon(
                  Icons.arrow_forward_rounded,
                  color: Colors.white,
                  size: isWeb ? 10.sp : 20.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleSubmit() {
    if (_isDisposed || !mounted) return;
    FocusScope.of(context).unfocus();
    controller.isCheck();
  }
}
