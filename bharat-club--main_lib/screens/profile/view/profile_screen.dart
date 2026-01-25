import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/constant/custom_image.dart';
import 'package:organization/common/constant/image_constants.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/lang/translation_service_key.dart';
import 'package:organization/utils/app_text.dart';
import '../controller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());

    return FocusDetector(
      onVisibilityGained: () {
        controller.getProfile();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(title: 'Profile'),
        body: profileView(),
      ),
    );
  }

  profileView() {
    return Obx(() {
      return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.r),
                  bottomRight: Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: () => controller.imagePic(),
                    child: Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.cAppColors.withOpacity(0.3),
                              width: 3,
                            ),
                          ),
                          child: ClipOval(
                            child: Container(
                              height: 110.w,
                              width: 110.w,
                              color: Colors.grey[100],
                              child: controller.attachmentPath.value.isNotEmpty
                                  ? Image.file(
                                      File(controller.attachmentPath.value),
                                      fit: BoxFit.cover,
                                    )
                                  : controller.photo.value.isEmpty
                                  ? Image.asset(
                                      ImageAssetsConstants.pic,
                                      fit: BoxFit.cover,
                                    )
                                  : cacheProfilePictureImage(
                                      controller.photo.value,
                                      ImageAssetsConstants.pic,
                                    ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            height: 36.w,
                            width: 36.w,
                            decoration: BoxDecoration(
                              color: AppColors.cAppColors,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.cAppColors.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    controller.userName.value,
                    style: getTextBold(size: 22.sp, colors: Colors.black87),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    controller.designation.value.isEmpty
                        ? "Member"
                        : controller.designation.value,
                    style: getTextSemiBold(
                      size: 14.sp,
                      colors: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 25.h),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  membershipType(),
                  SizedBox(height: 16.h),
                  basicDetails(),
                  SizedBox(height: 16.h),
                  personOfContact(),
                  SizedBox(height: 16.h),
                  profileInformation(),
                  SizedBox(height: 24.h),
                  deviceInformation(), // ADD THIS LINE
                  SizedBox(height: 24.h),
                  Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: AppColors.cAppColorsBlue.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () => Get.toNamed(AppRoutes.changePassword),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            color: AppColors.cAppColorsBlue,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Change Password',
                            style: getTextSemiBold(
                              colors: AppColors.cAppColorsBlue,
                              size: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Delete Profile Button
                  Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.red.withOpacity(0.3),
                        width: 1.5,
                      ),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      onPressed: () => controller.deleteProfile(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.delete_outline_rounded,
                            color: Colors.red,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            sDeleteProfile.tr,
                            style: getTextSemiBold(
                              colors: Colors.red,
                              size: 15.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 30.h),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget membershipType() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Membership Type",
                    style: getTextRegular(size: 20.sp, colors: Colors.black87),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, thickness: 1, color: Colors.grey[100]),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildInfoRow(
                  Icons.card_membership_outlined,
                  "Type",
                  controller.membershipType.value,
                ),
                _buildInfoRow(
                  Icons.badge_outlined,
                  "ID",
                  controller.membershipId.value,
                ),
                _buildInfoRow(
                  Icons.calendar_today_outlined,
                  "End Date",
                  controller.membershipEndDate.value.isEmpty
                      ? "--"
                      : controller.membershipEndDate.value,
                ),
                _buildInfoRow(
                  Icons.check_circle_outline,
                  "Status",
                  controller.membershipStatus.value ? "Active" : "Inactive",
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget basicDetails() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Member Details",
                    style: getTextRegular(size: 20.sp, colors: Colors.black87),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.editAccountScreen,
                        arguments: {
                          'userName': controller.userName.value,
                          'email': controller.emailId.value,
                          'phone': controller.phoneNumber.value,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cAppColors.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 16.sp,
                          color: AppColors.cAppColors,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Edit",
                          style: getTextMedium(
                            size: 13.sp,
                            colors: AppColors.cAppColors,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildInfoRow(
                  Icons.person_outline,
                  "User Name",
                  controller.userName.value,
                ),
                _buildInfoRow(
                  Icons.email_outlined,
                  "Email",
                  controller.emailId.value,
                ),
                _buildInfoRow(
                  Icons.phone_outlined,
                  "Phone",
                  "+${controller.phoneNumber.value}",
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget personOfContact() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Family Details",
                    style: getTextRegular(size: 20.sp, colors: Colors.black87),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.editPersonOfContactScreen,
                        arguments: {
                          'firstName': controller.pocFirstName.value,
                          'email': controller.pocEmailId.value,
                          'phone': controller.pocPhoneNumber.value,
                          'child1': controller.child1.value,
                          'child2': controller.child2.value,
                          'child3': controller.child3.value,
                          'child4': controller.child4.value,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cAppColors.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 16.sp,
                          color: AppColors.cAppColors,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Edit",
                          style: getTextMedium(
                            size: 13.sp,
                            colors: AppColors.cAppColors,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, thickness: 1, color: Colors.grey[100]),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildInfoRow(
                  Icons.person_outline,
                  "Name",
                  controller.pocFirstName.value,
                ),
                _buildInfoRow(
                  Icons.email_outlined,
                  "Email",
                  controller.pocEmailId.value,
                ),
                _buildInfoRow(
                  Icons.phone_outlined,
                  "Phone",
                  "+${controller.pocPhoneNumber.value}",
                ),
                if (controller.child1.value.isNotEmpty)
                  _buildInfoRow(
                    Icons.child_care_outlined,
                    "Child One",
                    controller.child1.value,
                  ),
                if (controller.child2.value.isNotEmpty)
                  _buildInfoRow(
                    Icons.child_care_outlined,
                    "Child Two",
                    controller.child2.value,
                  ),
                if (controller.child3.value.isNotEmpty)
                  _buildInfoRow(
                    Icons.child_care_outlined,
                    "Child Three",
                    controller.child3.value,
                  ),
                if (controller.child4.value.isNotEmpty)
                  _buildInfoRow(
                    Icons.child_care_outlined,
                    "Child Four",
                    controller.child4.value,
                    isLast: true,
                  )
                else
                  SizedBox(height: 0),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget profileInformation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Professional Details",
                    style: getTextRegular(size: 20.sp, colors: Colors.black87),
                  ),
                ),
                SizedBox(
                  height: 35.h,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.toNamed(
                        AppRoutes.editInformationScreen,
                        arguments: {
                          'companyName': controller.companyName.value,
                          'designation': controller.designation.value,
                          'location': controller.companyLocation.value,
                          'website': controller.companyWebSite.value,
                          'linkedin': controller.companyLinkedin.value,
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.cAppColors.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      elevation: 0,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.edit_outlined,
                          size: 16.sp,
                          color: AppColors.cAppColors,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Edit",
                          style: getTextMedium(
                            size: 13.sp,
                            colors: AppColors.cAppColors,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          Divider(height: 1, thickness: 1, color: Colors.grey[100]),

          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                _buildInfoRow(
                  Icons.business_outlined,
                  "Company",
                  controller.companyName.value,
                ),
                _buildInfoRow(
                  Icons.work_outline,
                  "Designation",
                  controller.designation.value,
                ),
                _buildInfoRow(
                  Icons.location_on_outlined,
                  "Location",
                  controller.companyLocation.value,
                ),
                _buildInfoRow(
                  Icons.language_outlined,
                  "Website",
                  controller.companyWebSite.value,
                ),
                _buildInfoRow(
                  Icons.link_outlined,
                  "LinkedIn",
                  controller.companyLinkedin.value,
                  isLast: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget deviceInformation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Icon(
                  Icons.smartphone_outlined,
                  color: AppColors.cAppColors,
                  size: 24.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    "Device Details",
                    style: getTextRegular(size: 20.sp, colors: Colors.black87),
                  ),
                ),
              ],
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[100]),
          Padding(
            padding: EdgeInsets.all(16.w),
            child: _buildInfoRow(
            Icons.adb,
              "Device ID",
              controller.deviceId.value.isEmpty
                  ? "Not Available"
                  : controller.deviceId.value,
              isLast: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    IconData icon,
    String label,
    String value, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.cAppColors.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, size: 20.sp, color: AppColors.cAppColors),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: getTextSemiBold(
                    size: 12.sp,
                    colors: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value.isEmpty ? "--" : value,
                  style: getTextSemiBold(size: 17.sp, colors: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
