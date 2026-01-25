import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/common/widgets/profile_banner.dart';
import 'package:mobileapp/common/widgets/text_input.dart';
import 'package:mobileapp/utils/app_text.dart';
import 'package:mobileapp/utils/app_util.dart';
import '../controller/profile_controller.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';

// class EditProfileInformationScreen extends StatelessWidget {
//   final ProfileController controller = Get.find();
//
//   EditProfileInformationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     _initializeControllers();
//     return Scaffold(body: _fullView());
//   }
//
//   void _initializeControllers() {
//     controller.profileInformationDetails();
//   }
//
//   Widget _fullView() {
//     return GestureDetector(
//       onTap: () => AppUtils.hideKeyboard(Get.context!),
//       child: Container(
//         height: 1.sh,
//         width: 1.sw,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: <Color>[
//               AppColors.cAppColors,
//               Colors.grey.shade100,
//               Colors.grey.shade100,
//               AppColors.cAppColors,
//             ],
//           ),
//         ),
//         child: Column(
//           children: [
//             const CustomAppBar(title: 'Edit Professional Information'),
//             SizedBox(height: 20.h),
//             _buildProfileHeader(),
//             SizedBox(height: 20.h),
//             Expanded(child: _profileFormView()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileHeader() {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 100.w),
//       child: CompactBannerCard(
//         bannerUrl: '',
//         height: 90,
//         borderRadius: 16,
//         imagePadding: 4,
//         imageHeightRatio: 1.7,
//         showDecorationCircles: true, // Circles will stay inside border
//       ),
//     );
//   }
//
//   Widget _profileFormView() {
//     return Obx(() {
//       return Container(
//         margin: EdgeInsets.symmetric(horizontal: 15.w),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16.r),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.05),
//               blurRadius: 10,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: SingleChildScrollView(
//           padding: EdgeInsets.all(20.w),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildSectionTitle('Professional Details'),
//               SizedBox(height: 16.h),
//
//               /// Company Name
//               _buildInputField(
//                 label: 'Company Name',
//                 controller: controller.mUserNameController.value,
//                 // Only show error if user has attempted to submit
//                 errorText:
//                     controller.hasAttemptedSubmit.value &&
//                         controller.userNameValidator.isTrue
//                     ? "Please enter the Company Name"
//                     : null,
//                 icon: Icons.business_outlined,
//                 hint: "Enter the Company Name",
//                 keyboardType: TextInputType.name,
//               ),
//               SizedBox(height: 20.h),
//
//               /// Designation
//               _buildInputField(
//                 label: 'Designation',
//                 controller: controller.mDesignationController.value,
//                 // Only show error if user has attempted to submit
//                 errorText:
//                     controller.hasAttemptedSubmit.value &&
//                         controller.designationValidator.isTrue
//                     ? "Please enter your designation"
//                     : null,
//                 icon: Icons.work_outline,
//                 hint: "Enter your designation",
//                 keyboardType: TextInputType.name,
//               ),
//               SizedBox(height: 20.h),
//
//               /// Location
//               _buildInputField(
//                 label: 'Location',
//                 controller: controller.mEmailController.value,
//                 // Only show error if user has attempted to submit
//                 errorText:
//                     controller.hasAttemptedSubmit.value &&
//                         controller.emailValidator.isTrue
//                     ? "Please enter the location"
//                     : null,
//                 icon: Icons.location_on_outlined,
//                 hint: "Enter the location",
//                 keyboardType: TextInputType.text,
//               ),
//               SizedBox(height: 32.h),
//
//               _buildSectionTitle('Online Presence'),
//               SizedBox(height: 16.h),
//
//               /// Company Website
//               _buildInputField(
//                 label: 'Company Website',
//                 controller: controller.mPhoneNoController.value,
//                 // Only show error if user has attempted to submit
//                 errorText:
//                     controller.hasAttemptedSubmit.value &&
//                         controller.phoneNumberValidator.isTrue
//                     ? "Please enter the Company Website"
//                     : null,
//                 icon: Icons.language,
//                 hint: "Enter the Company Website",
//                 keyboardType: TextInputType.url,
//               ),
//               SizedBox(height: 20.h),
//
//               /// LinkedIn URL
//               _buildInputField(
//                 label: 'LinkedIn URL',
//                 controller: controller.mLinkedinController.value,
//                 errorText: null, // No validation for LinkedIn (optional field)
//                 icon: Icons.link,
//                 hint: "Enter the LinkedIn URL",
//                 keyboardType: TextInputType.url,
//               ),
//               SizedBox(height: 32.h),
//
//               /// Update Profile Button
//               SizedBox(
//                 width: double.infinity,
//                 height: 56.h,
//                 child: ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: AppColors.cAppColors,
//                     elevation: 2,
//                     shadowColor: AppColors.cAppColors.withOpacity(0.4),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12.r),
//                     ),
//                   ),
//                   onPressed: () {
//                     controller.isProfileInformationCheck();
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Icon(
//                         Icons.check_circle_outline,
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 8.w),
//                       Text(
//                         "Update Profile",
//                         style: getTextSemiBold(
//                           colors: Colors.white,
//                           size: 16.sp,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20.h),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _buildSectionTitle(String title) {
//     return Row(
//       children: [
//         Container(
//           width: 4.w,
//           height: 20.h,
//           decoration: BoxDecoration(
//             color: AppColors.cAppColors,
//             borderRadius: BorderRadius.circular(2.r),
//           ),
//         ),
//         SizedBox(width: 8.w),
//         Text(
//           title,
//           style: getTextSemiBold(size: 16.sp, colors: Colors.grey.shade800),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildInputField({
//     required String label,
//     required TextEditingController controller,
//     required IconData icon,
//     required String hint,
//     required TextInputType keyboardType,
//     String? errorText,
//   }) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Using your TextInputWidget with proper contentPadding to prevent cutting
//         Container(
//           decoration: BoxDecoration(
//             color: Colors.grey.shade50,
//             borderRadius: BorderRadius.circular(12.r),
//           ),
//           child: TextInputWidget(
//             placeHolder: label,
//             controller: controller,
//             errorText: null, // We'll show error outside to keep border clean
//             textInputType: keyboardType,
//             hintText: hint,
//             showFloatingLabel: true, // Keep floating label
//             prefixIcon: icon,
//             borderColor: errorText != null
//                 ? Colors.red.withValues(alpha: 0.5)
//                 : Colors.grey.shade300,
//           ),
//         ),
//
//         // Error Message Below
//         if (errorText != null) ...[
//           SizedBox(height: 6.h),
//           Padding(
//             padding: EdgeInsets.only(left: 4.w),
//             child: Row(
//               children: [
//                 Icon(Icons.error_outline, size: 14.sp, color: Colors.red),
//                 SizedBox(width: 4.w),
//                 Expanded(
//                   child: Text(
//                     errorText,
//                     style: getTextMedium(size: 12.sp, colors: Colors.red),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ],
//     );
//   }
// }

class EditProfileInformationScreen extends StatelessWidget {
  final ProfileController controller = Get.find();

  EditProfileInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _initializeControllers();

    return LayoutBuilder(
      builder: (context, constraints) {
        bool isWeb = constraints.maxWidth >= 800;

        return Scaffold(
          backgroundColor: isWeb ? Colors.grey[200] : AppColors.background,
          body: isWeb
              ? Center(
            child: Container(
              width: 500, // Fixed width for Web forms
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.background,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                  )
                ],
              ),
              child: _fullView(isWeb),
            ),
          )
              : _fullView(isWeb),
        );
      },
    );
  }

  void _initializeControllers() {
    controller.profileInformationDetails();
  }

  Widget _fullView(bool isWeb) {
    return GestureDetector(
      onTap: () => AppUtils.hideKeyboard(Get.context!),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              AppColors.cAppColors.withOpacity(0.1), // Adjusted for cleaner web look
              Colors.grey.shade100,
              Colors.grey.shade100,
              AppColors.cAppColors.withOpacity(0.1),
            ],
          ),
        ),
        child: Column(
          children: [
            CustomAppBar(
              title: 'Edit Professional Info',
              isWeb: isWeb, // Pass responsive flag
            ),
            SizedBox(height: isWeb ? 20 : 20.h),
            _buildProfileHeader(isWeb),
            SizedBox(height: isWeb ? 20 : 20.h),
            Expanded(child: _profileFormView(isWeb)),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isWeb) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isWeb ? 40 : 100.w),
      child: CompactBannerCard(
        bannerUrl: '',
        height: 90,
        borderRadius: 16,
        imagePadding: 4,
        imageHeightRatio: 1.7,
        showDecorationCircles: true,
      ),
    );
  }

  Widget _profileFormView(bool isWeb) {
    return Obx(() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: isWeb ? 15 : 15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isWeb ? 16 : 16.r),
            topRight: Radius.circular(isWeb ? 16 : 16.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isWeb ? 20 : 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle(isWeb, 'Professional Details'),
              SizedBox(height: isWeb ? 16 : 16.h),

              _buildInputField(
                isWeb: isWeb,
                label: 'Company Name',
                controller: controller.mUserNameController.value,
                errorText: controller.hasAttemptedSubmit.value && controller.userNameValidator.isTrue
                    ? "Please enter the Company Name" : null,
                icon: Icons.business_outlined,
                hint: "Enter the Company Name",
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: isWeb ? 20 : 20.h),

              _buildInputField(
                isWeb: isWeb,
                label: 'Designation',
                controller: controller.mDesignationController.value,
                errorText: controller.hasAttemptedSubmit.value && controller.designationValidator.isTrue
                    ? "Please enter your designation" : null,
                icon: Icons.work_outline,
                hint: "Enter your designation",
                keyboardType: TextInputType.name,
              ),
              SizedBox(height: isWeb ? 20 : 20.h),

              _buildInputField(
                isWeb: isWeb,
                label: 'Location',
                controller: controller.mEmailController.value,
                errorText: controller.hasAttemptedSubmit.value && controller.emailValidator.isTrue
                    ? "Please enter the location" : null,
                icon: Icons.location_on_outlined,
                hint: "Enter the location",
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: isWeb ? 32 : 32.h),

              _buildSectionTitle(isWeb, 'Online Presence'),
              SizedBox(height: isWeb ? 16 : 16.h),

              _buildInputField(
                isWeb: isWeb,
                label: 'Company Website',
                controller: controller.mPhoneNoController.value,
                errorText: controller.hasAttemptedSubmit.value && controller.phoneNumberValidator.isTrue
                    ? "Please enter the Company Website" : null,
                icon: Icons.language,
                hint: "Enter the Company Website",
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: isWeb ? 20 : 20.h),

              _buildInputField(
                isWeb: isWeb,
                label: 'LinkedIn URL',
                controller: controller.mLinkedinController.value,
                errorText: null,
                icon: Icons.link,
                hint: "Enter the LinkedIn URL",
                keyboardType: TextInputType.url,
              ),
              SizedBox(height: isWeb ? 32 : 32.h),

              /// Update Profile Button
              SizedBox(
                width: double.infinity,
                height: isWeb ? 56 : 56.h,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.cAppColors,
                    elevation: 2,
                    shadowColor: AppColors.cAppColors.withOpacity(0.4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(isWeb ? 12 : 12.r),
                    ),
                  ),
                  onPressed: () => controller.isProfileInformationCheck(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.check_circle_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "Update Profile",
                        style: getTextSemiBold(
                          colors: Colors.white,
                          size: isWeb ? 16 : 16.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: isWeb ? 20 : 20.h),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildSectionTitle(bool isWeb, String title) {
    return Row(
      children: [
        Container(
          width: isWeb ? 4 : 4.w,
          height: isWeb ? 20 : 20.h,
          decoration: BoxDecoration(
            color: AppColors.cAppColors,
            borderRadius: BorderRadius.circular(isWeb ? 2 : 2.r),
          ),
        ),
        SizedBox(width: 8),
        Text(
          title,
          style: getTextSemiBold(size: isWeb ? 16 : 16.sp, colors: Colors.grey.shade800),
        ),
      ],
    );
  }

  Widget _buildInputField({
    required bool isWeb,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(isWeb ? 12 : 12.r),
          ),
          child: TextInputWidget(
            placeHolder: label,
            controller: controller,
            errorText: null,
            textInputType: keyboardType,
            hintText: hint,
            showFloatingLabel: true,
            prefixIcon: icon,
            borderColor: errorText != null
                ? Colors.red.withOpacity(0.5)
                : Colors.grey.shade300,
          ),
        ),

        if (errorText != null) ...[
          SizedBox(height: isWeb ? 6 : 6.h),
          Padding(
            padding: EdgeInsets.only(left: 4),
            child: Row(
              children: [
                Icon(Icons.error_outline, size: isWeb ? 14 : 14.sp, color: Colors.red),
                SizedBox(width: 4),
                Expanded(
                  child: Text(
                    errorText,
                    style: getTextMedium(size: isWeb ? 12 : 12.sp, colors: Colors.red),
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