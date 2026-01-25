import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/common/widgets/profile_banner.dart';
import 'package:organization/common/widgets/text_input.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/app_util.dart';
import '../controller/profile_controller.dart';
import 'package:organization/app_theme/theme/app_theme.dart';

class EditProfileInformationScreen extends StatelessWidget {
  final ProfileController controller = Get.find();

  EditProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeControllers();
    return Scaffold(body: _fullView());
  }

  void _initializeControllers() {
    controller.profileInformationDetails();
  }

  Widget _fullView() {
    return GestureDetector(
      onTap: () => AppUtils.hideKeyboard(Get.context!),
      child: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              AppColors.cAppColors,
              Colors.grey.shade100,
              Colors.grey.shade100,
              AppColors.cAppColors,
            ],
          ),
        ),
        child: Column(
          children: [
            const CustomAppBar(title: 'Edit Professional Information'),
            SizedBox(height: 20.h),
            _buildProfileHeader(),
            SizedBox(height: 20.h),
            Expanded(child: _profileFormView()),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 100.w),
      child: CompactBannerCard(
        bannerUrl: '',
        height: 90,
        borderRadius: 16,
        imagePadding: 4,
        imageHeightRatio: 1.7,
        showDecorationCircles: true, // Circles will stay inside border
      ),
    );
  }

  Widget _profileFormView() {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Professional Details'),
              SizedBox(height: 16.h),

              /// Company Name
              _buildInputField(
                label: 'Company Name',
                controller: controller.mUserNameController.value,
                // Only show error if user has attempted to submit
                errorText:
                    controller.hasAttemptedSubmit.value &&
                        controller.userNameValidator.isTrue
                    ? "Please enter the Company Name"
                    : null,
                icon: Icons.business_outlined,
                hint: "Enter the Company Name",
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20.h),

              /// Designation
              _buildInputField(
                label: 'Designation',
                controller: controller.mDesignationController.value,
                // Only show error if user has attempted to submit
                errorText:
                    controller.hasAttemptedSubmit.value &&
                        controller.designationValidator.isTrue
                    ? "Please enter your designation"
                    : null,
                icon: Icons.work_outline,
                hint: "Enter your designation",
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: 20.h),

              /// Location
              _buildInputField(
                label: 'Location',
                controller: controller.mEmailController.value,
                // Only show error if user has attempted to submit
                errorText:
                    controller.hasAttemptedSubmit.value &&
                        controller.emailValidator.isTrue
                    ? "Please enter the location"
                    : null,
                icon: Icons.location_on_outlined,
                hint: "Enter the location",
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 32.h),

              _buildSectionTitle('Online Presence'),
              SizedBox(height: 16.h),

              /// Company Website
              _buildInputField(
                label: 'Company Website',
                controller: controller.mPhoneNoController.value,
                // Only show error if user has attempted to submit
                errorText:
                    controller.hasAttemptedSubmit.value &&
                        controller.phoneNumberValidator.isTrue
                    ? "Please enter the Company Website"
                    : null,
                icon: Icons.language,
                hint: "Enter the Company Website",
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 20.h),

              /// LinkedIn URL
              _buildInputField(
                label: 'LinkedIn URL',
                controller: controller.mLinkedinController.value,
                errorText: null, // No validation for LinkedIn (optional field)
                icon: Icons.link,
                hint: "Enter the LinkedIn URL",
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: 32.h),

              /// Update Profile Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cAppColors,
                    elevation: 2,
                    shadowColor: AppColors.cAppColors.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () {
                    controller.isProfileInformationCheck();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.check_circle_outline,
                        color: Colors.white,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Update Profile",
                        style: getTextSemiBold(
                          colors: Colors.white,
                          size: 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: AppColors.cAppColors,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: getTextSemiBold(size: 16.sp, colors: Colors.grey.shade800),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    required String hint,
    required TextInputType keyboardType,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Using your TextInputWidget with proper contentPadding to prevent cutting
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextInputWidget(
            placeHolder: label,
            controller: controller,
            errorText: null, // We'll show error outside to keep border clean
            textInputType: keyboardType,
            hintText: hint,
            showFloatingLabel: true, // Keep floating label
            prefixIcon: icon,
            borderColor: errorText != null
                ? Colors.red.withValues(alpha: 0.5)
                : Colors.grey.shade300,
          ),
        ),

        // Error Message Below
        if (errorText != null) ...[
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.only(left: 4.w),
            child: Row(
              children: [
                Icon(Icons.error_outline, size: 14.sp, color: Colors.red),
                SizedBox(width: 4.w),
                Expanded(
                  child: Text(
                    errorText,
                    style: getTextMedium(size: 12.sp, colors: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}
