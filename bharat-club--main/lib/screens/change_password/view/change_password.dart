import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/animation/animation_background.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/utils/app_text.dart';
import '../../../lang/translation_service_key.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen>
    with SingleTickerProviderStateMixin {
  final ChangePasswordScreenController controller = Get.put(
    ChangePasswordScreenController(),
  );

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
    Get.delete<ChangePasswordScreenController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBackgroundWidget(
        primaryColor: AppColors.secondaryGreen,
        secondaryColor: AppColors.tertiaryGreen,
        particleColor: AppColors.tertiaryGreen,
        child: SafeArea(
          child: Form(
            key: _formKey,
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
                            _buildFormSection(),
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
                  tag: 'login_logo',
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
                      ), // 🔥 Rounded image
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
                Column(
                  children: [
                    Text(
                      'Change Password',
                      style: getTextBold(
                        colors: AppColors.textPrimary,
                        size: 32.sp,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Enter your old and new password to update',
                      textAlign: TextAlign.center,
                      style: getTextRegular(
                        colors: AppColors.textSecondary,
                        size: 16.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFormSection() {
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
                  _buildOldPasswordField(),
                  SizedBox(height: 20.h),
                  _buildNewPasswordField(),
                  SizedBox(height: 32.h),
                  _buildSubmitButton(),
                  SizedBox(height: 16.h),
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text(
                      'Back',
                      style: getTextMedium(
                        colors: AppColors.secondaryGreen,
                        size: 14.sp,
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

  Widget _buildOldPasswordField() {
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
          obscureText: controller.hidePassword.value,
          style: getTextMedium(colors: AppColors.textPrimary, size: 16.sp),
          cursorColor: AppColors.secondaryGreen,
          onChanged: (value) {
            if (controller.emailValidator.value) {
              controller.emailValidator.value = false;
            }
          },
          decoration: InputDecoration(
            hintText: sOldPasswordHint.tr,
            hintStyle: getTextRegular(
              colors: AppColors.textSecondary,
              size: 16.sp,
            ),
            labelText: sOldPassword.tr,
            labelStyle: getTextMedium(
              colors: AppColors.textSecondary,
              size: 14.sp,
            ),
            floatingLabelStyle: getTextMedium(
              colors: AppColors.secondaryGreen,
              size: 14.sp,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.only(left: 16.w, right: 12.w),
              child: Icon(
                Icons.lock_outline,
                color: AppColors.secondaryGreen,
                size: 22.r,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                controller.hidePassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.secondaryGreen,
                size: 22.r,
              ),
              onPressed: () {
                controller.showPassword();
              },
            ),
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
            errorText: controller.emailValidator.value
                ? controller.seEmailValidator.value
                : null,
            errorStyle: getTextMedium(colors: AppColors.error, size: 12.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildNewPasswordField() {
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
          controller: controller.mPasswordController,
          obscureText: controller.hidePassword.value,
          style: getTextMedium(colors: AppColors.textPrimary, size: 16.sp),
          cursorColor: AppColors.secondaryGreen,
          onChanged: (value) {
            if (controller.passwordValidator.value) {
              controller.passwordValidator.value = false;
            }
          },
          decoration: InputDecoration(
            hintText: sNewPasswordHint.tr,
            hintStyle: getTextRegular(
              colors: AppColors.textSecondary,
              size: 16.sp,
            ),
            labelText: sNewPassword.tr,
            labelStyle: getTextMedium(
              colors: AppColors.textSecondary,
              size: 14.sp,
            ),
            floatingLabelStyle: getTextMedium(
              colors: AppColors.secondaryGreen,
              size: 14.sp,
            ),
            prefixIcon: Container(
              margin: EdgeInsets.only(left: 16.w, right: 12.w),
              child: Icon(
                Icons.lock_outline,
                color: AppColors.secondaryGreen,
                size: 22.r,
              ),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                controller.hidePassword.value
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: AppColors.secondaryGreen,
                size: 22.r,
              ),
              onPressed: () {
                controller.showPassword();
              },
            ),
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
            errorText: controller.passwordValidator.value
                ? controller.sePasswordValidator.value
                : null,
            errorStyle: getTextMedium(colors: AppColors.error, size: 12.sp),
          ),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
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
          onTap: _handleSubmit,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Change Password',
                  style: getTextSemiBold(colors: Colors.white, size: 18.sp),
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
    );
  }

  void _handleSubmit() {
    if (_isDisposed || !mounted) return;

    FocusScope.of(context).unfocus();
    controller.isCheck();
  }
}
