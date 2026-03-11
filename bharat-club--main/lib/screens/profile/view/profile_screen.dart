import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/routes_name.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/constant/custom_image.dart';
import 'package:mobileapp/common/constant/image_constants.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/lang/translation_service_key.dart';
import 'package:mobileapp/utils/app_text.dart';
import '../controller/profile_controller.dart';

// class ProfileScreen extends GetView<ProfileController> {
//   ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.put(ProfileController());
//
//     return FocusDetector(
//       onVisibilityGained: () {
//         controller.getProfile();
//       },
//       child: Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: CustomAppBar(title: 'Profile'),
//         body: profileView(),
//       ),
//     );
//   }
//
//   profileView() {
//     return Obx(() {
//       return SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(30.r),
//                   bottomRight: Radius.circular(30.r),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.05),
//                     blurRadius: 10,
//                     offset: Offset(0, 5),
//                   ),
//                 ],
//               ),
//               child: Column(
//                 children: [
//                   SizedBox(height: 30.h),
//                   GestureDetector(
//                     onTap: () => controller.imagePic(),
//                     child: Stack(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             border: Border.all(
//                               color: AppColors.cAppColors.withOpacity(0.3),
//                               width: 3,
//                             ),
//                           ),
//                           child: ClipOval(
//                             child: Container(
//                               height: 110.w,
//                               width: 110.w,
//                               color: Colors.grey[100],
//                               child: controller.attachmentPath.value.isNotEmpty
//                                   ? Image.file(
//                                       File(controller.attachmentPath.value),
//                                       fit: BoxFit.cover,
//                                     )
//                                   : controller.photo.value.isEmpty
//                                   ? Image.asset(
//                                       ImageAssetsConstants.pic,
//                                       fit: BoxFit.cover,
//                                     )
//                                   : cacheProfilePictureImage(
//                                       controller.photo.value,
//                                       ImageAssetsConstants.pic,
//                                     ),
//                             ),
//                           ),
//                         ),
//                         Positioned(
//                           bottom: 0,
//                           right: 0,
//                           child: Container(
//                             height: 36.w,
//                             width: 36.w,
//                             decoration: BoxDecoration(
//                               color: AppColors.cAppColors,
//                               shape: BoxShape.circle,
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: AppColors.cAppColors.withOpacity(0.3),
//                                   blurRadius: 8,
//                                   offset: Offset(0, 2),
//                                 ),
//                               ],
//                             ),
//                             child: Icon(
//                               Icons.camera_alt_rounded,
//                               color: Colors.white,
//                               size: 18.sp,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   SizedBox(height: 16.h),
//                   Text(
//                     controller.userName.value,
//                     style: getTextBold(size: 22.sp, colors: Colors.black87),
//                   ),
//                   SizedBox(height: 4.h),
//                   Text(
//                     controller.designation.value.isEmpty
//                         ? "Member"
//                         : controller.designation.value,
//                     style: getTextSemiBold(
//                       size: 14.sp,
//                       colors: AppColors.textPrimary,
//                     ),
//                   ),
//                   SizedBox(height: 25.h),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               child: Column(
//                 children: [
//                   membershipType(),
//                   SizedBox(height: 16.h),
//                   basicDetails(),
//                   SizedBox(height: 16.h),
//                   personOfContact(),
//                   SizedBox(height: 16.h),
//                   profileInformation(),
//                   SizedBox(height: 24.h),
//                   deviceInformation(), // ADD THIS LINE
//                   SizedBox(height: 24.h),
//                   Container(
//                     width: double.infinity,
//                     height: 50.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.r),
//                       border: Border.all(
//                         color: AppColors.cAppColorsBlue.withOpacity(0.3),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                       onPressed: () => Get.toNamed(AppRoutes.changePassword),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.lock_outline_rounded,
//                             color: AppColors.cAppColorsBlue,
//                             size: 20.sp,
//                           ),
//                           SizedBox(width: 8.w),
//                           Text(
//                             'Change Password',
//                             style: getTextSemiBold(
//                               colors: AppColors.cAppColorsBlue,
//                               size: 15.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 16.h),
//
//                   // Delete Profile Button
//                   Container(
//                     width: double.infinity,
//                     height: 50.h,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12.r),
//                       border: Border.all(
//                         color: Colors.red.withOpacity(0.3),
//                         width: 1.5,
//                       ),
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shadowColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12.r),
//                         ),
//                       ),
//                       onPressed: () => controller.deleteProfile(),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Icon(
//                             Icons.delete_outline_rounded,
//                             color: Colors.red,
//                             size: 20.sp,
//                           ),
//                           SizedBox(width: 8.w),
//                           Text(
//                             sDeleteProfile.tr,
//                             style: getTextSemiBold(
//                               colors: Colors.red,
//                               size: 15.sp,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: 30.h),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget membershipType() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Membership Type",
//                     style: getTextRegular(size: 20.sp, colors: Colors.black87),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           Divider(height: 1, thickness: 1, color: Colors.grey[100]),
//
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               children: [
//                 _buildInfoRow(
//                   Icons.card_membership_outlined,
//                   "Type",
//                   controller.membershipType.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.badge_outlined,
//                   "ID",
//                   controller.membershipId.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.calendar_today_outlined,
//                   "End Date",
//                   controller.membershipEndDate.value.isEmpty
//                       ? "--"
//                       : controller.membershipEndDate.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.check_circle_outline,
//                   "Status",
//                   controller.membershipStatus.value ? "Active" : "Inactive",
//                   isLast: true,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget basicDetails() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Member Details",
//                     style: getTextRegular(size: 20.sp, colors: Colors.black87),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35.h,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Get.toNamed(
//                         AppRoutes.editAccountScreen,
//                         arguments: {
//                           'userName': controller.userName.value,
//                           'email': controller.emailId.value,
//                           'phone': controller.phoneNumber.value,
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.cAppColors.withOpacity(0.1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       elevation: 0,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 6.h,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.edit_outlined,
//                           size: 16.sp,
//                           color: AppColors.cAppColors,
//                         ),
//                         SizedBox(width: 4.w),
//                         Text(
//                           "Edit",
//                           style: getTextMedium(
//                             size: 13.sp,
//                             colors: AppColors.cAppColors,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(height: 1, thickness: 1, color: Colors.grey[100]),
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               children: [
//                 _buildInfoRow(
//                   Icons.person_outline,
//                   "User Name",
//                   controller.userName.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.email_outlined,
//                   "Email",
//                   controller.emailId.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.phone_outlined,
//                   "Phone",
//                   "+${controller.phoneNumber.value}",
//                   isLast: true,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget personOfContact() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Family Details",
//                     style: getTextRegular(size: 20.sp, colors: Colors.black87),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35.h,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Get.toNamed(
//                         AppRoutes.editPersonOfContactScreen,
//                         arguments: {
//                           'firstName': controller.pocFirstName.value,
//                           'email': controller.pocEmailId.value,
//                           'phone': controller.pocPhoneNumber.value,
//                           'child1': controller.child1.value,
//                           'child2': controller.child2.value,
//                           'child3': controller.child3.value,
//                           'child4': controller.child4.value,
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.cAppColors.withOpacity(0.1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       elevation: 0,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 6.h,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.edit_outlined,
//                           size: 16.sp,
//                           color: AppColors.cAppColors,
//                         ),
//                         SizedBox(width: 4.w),
//                         Text(
//                           "Edit",
//                           style: getTextMedium(
//                             size: 13.sp,
//                             colors: AppColors.cAppColors,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           Divider(height: 1, thickness: 1, color: Colors.grey[100]),
//
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               children: [
//                 _buildInfoRow(
//                   Icons.person_outline,
//                   "Name",
//                   controller.pocFirstName.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.email_outlined,
//                   "Email",
//                   controller.pocEmailId.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.phone_outlined,
//                   "Phone",
//                   "+${controller.pocPhoneNumber.value}",
//                 ),
//                 if (controller.child1.value.isNotEmpty)
//                   _buildInfoRow(
//                     Icons.child_care_outlined,
//                     "Child One",
//                     controller.child1.value,
//                   ),
//                 if (controller.child2.value.isNotEmpty)
//                   _buildInfoRow(
//                     Icons.child_care_outlined,
//                     "Child Two",
//                     controller.child2.value,
//                   ),
//                 if (controller.child3.value.isNotEmpty)
//                   _buildInfoRow(
//                     Icons.child_care_outlined,
//                     "Child Three",
//                     controller.child3.value,
//                   ),
//                 if (controller.child4.value.isNotEmpty)
//                   _buildInfoRow(
//                     Icons.child_care_outlined,
//                     "Child Four",
//                     controller.child4.value,
//                     isLast: true,
//                   )
//                 else
//                   SizedBox(height: 0),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget profileInformation() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Text(
//                     "Professional Details",
//                     style: getTextRegular(size: 20.sp, colors: Colors.black87),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 35.h,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Get.toNamed(
//                         AppRoutes.editInformationScreen,
//                         arguments: {
//                           'companyName': controller.companyName.value,
//                           'designation': controller.designation.value,
//                           'location': controller.companyLocation.value,
//                           'website': controller.companyWebSite.value,
//                           'linkedin': controller.companyLinkedin.value,
//                         },
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: AppColors.cAppColors.withOpacity(0.1),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8.r),
//                       ),
//                       elevation: 0,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 12.w,
//                         vertical: 6.h,
//                       ),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Icon(
//                           Icons.edit_outlined,
//                           size: 16.sp,
//                           color: AppColors.cAppColors,
//                         ),
//                         SizedBox(width: 4.w),
//                         Text(
//                           "Edit",
//                           style: getTextMedium(
//                             size: 13.sp,
//                             colors: AppColors.cAppColors,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           Divider(height: 1, thickness: 1, color: Colors.grey[100]),
//
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Column(
//               children: [
//                 _buildInfoRow(
//                   Icons.business_outlined,
//                   "Company",
//                   controller.companyName.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.work_outline,
//                   "Designation",
//                   controller.designation.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.location_on_outlined,
//                   "Location",
//                   controller.companyLocation.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.language_outlined,
//                   "Website",
//                   controller.companyWebSite.value,
//                 ),
//                 _buildInfoRow(
//                   Icons.link_outlined,
//                   "LinkedIn",
//                   controller.companyLinkedin.value,
//                   isLast: true,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget deviceInformation() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16.r),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 10,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               children: [
//                 Icon(
//                   Icons.smartphone_outlined,
//                   color: AppColors.cAppColors,
//                   size: 24.sp,
//                 ),
//                 SizedBox(width: 12.w),
//                 Expanded(
//                   child: Text(
//                     "Device Details",
//                     style: getTextRegular(size: 20.sp, colors: Colors.black87),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(height: 1, thickness: 1, color: Colors.grey[100]),
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: _buildInfoRow(
//             Icons.adb,
//               "Device ID",
//               controller.deviceId.value.isEmpty
//                   ? "Not Available"
//                   : controller.deviceId.value,
//               isLast: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInfoRow(
//     IconData icon,
//     String label,
//     String value, {
//     bool isLast = false,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: isLast ? 0 : 16.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             padding: EdgeInsets.all(8.w),
//             decoration: BoxDecoration(
//               color: AppColors.cAppColors.withOpacity(0.08),
//               borderRadius: BorderRadius.circular(10.r),
//             ),
//             child: Icon(icon, size: 20.sp, color: AppColors.cAppColors),
//           ),
//           SizedBox(width: 12.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   label,
//                   style: getTextSemiBold(
//                     size: 12.sp,
//                     colors: AppColors.textPrimary,
//                   ),
//                 ),
//                 SizedBox(height: 4.h),
//                 Text(
//                   value.isEmpty ? "--" : value,
//                   style: getTextSemiBold(size: 17.sp, colors: Colors.black87),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



class ProfileScreen extends GetView<ProfileController> {
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 800) {
          return Scaffold(
            // Add a scaffold background for the "letterbox" effect
            backgroundColor: Colors.grey[200],
            // Darker background for the web margins
            body: Center(
              child: Container(
                width: 500,
                // Standard mobile width feels better on web than 800
                height: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ClipRect(
                  // Keeps the UI inside the 500px bounds
                  child: profileView(true),
                ),
              ),
            ),
          );
        } else {
          return profileView(false);
        }
      },
    );
  }

  Widget profileView(bool isWeb) {
    return FocusDetector(
      onVisibilityGained: () {
        controller.getProfile();
      },
      child: Scaffold(
        // On Web, use a light grey background for the margins
        backgroundColor: isWeb ? Colors.grey[200] : AppColors.background,
        appBar: CustomAppBar(
          title: 'Profile',
          showBack: true,
          isWeb: isWeb, // Passing isWeb to our responsive AppBar
        ),
        body: Obx(() {
          return SingleChildScrollView(
            child: Column(
              children: [
                // Top Header Section
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(isWeb ? 30 : 30.r),
                      bottomRight: Radius.circular(isWeb ? 30 : 30.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: isWeb ? 10 : 10.r,
                        offset: Offset(0, isWeb ? 5 : 5.h),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: isWeb ? 30 : 30.h),
                      _buildProfileImage(isWeb),
                      SizedBox(height: isWeb ? 16 : 16.h),
                      Text(
                        controller.userName.value,
                        style: getTextBold(
                          size: isWeb ? 22 : 22.sp,
                          colors: Colors.black87,
                        ),
                      ),
                      SizedBox(height: isWeb ? 4 : 4.h),
                      Text(
                        controller.designation.value.isEmpty
                            ? "Member"
                            : controller.designation.value,
                        style: getTextSemiBold(
                          size: isWeb ? 14 : 14.sp,
                          colors: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: isWeb ? 25 : 25.h),
                    ],
                  ),
                ),

                SizedBox(height: isWeb ? 20 : 20.h),

                // Details Cards
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isWeb ? 16 : 16.w),
                  child: Column(
                    children: [
                      _buildCardWrapper(
                        isWeb,
                        "Membership Type",
                        membershipContent(isWeb),
                      ),
                      SizedBox(height: isWeb ? 16 : 16.h),
                      _buildCardWrapper(
                        isWeb,
                        "Member Details",
                        basicDetailsContent(isWeb),
                        showEdit: true,
                        onEdit: () {
                          Get.toNamed(
                            AppRoutes.editAccountScreen,
                            arguments: {
                              'userName': controller.userName.value,
                              'email': controller.emailId.value,
                              'phone': controller.phoneNumber.value,
                            },
                          );
                        },
                      ),
                      SizedBox(height: isWeb ? 16 : 16.h),
                      _buildCardWrapper(
                        isWeb,
                        "Family Details",
                        familyDetailsContent(isWeb),
                        showEdit: true,
                        onEdit: () {
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
                      ),
                      SizedBox(height: isWeb ? 16 : 16.h),
                      _buildCardWrapper(
                        isWeb,
                        "Professional Details",
                        professionalContent(isWeb),
                        showEdit: true,
                        onEdit: () {
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
                      ),
                      SizedBox(height: isWeb ? 24 : 24.h),
                      _buildDeviceCard(isWeb),
                      SizedBox(height: isWeb ? 24 : 24.h),

                      // Buttons
                      _buildActionButton(
                        isWeb,
                        "Change Password",
                        Icons.lock_outline_rounded,
                        AppColors.cAppColorsBlue,
                        () => Get.toNamed(AppRoutes.changePassword),
                      ),
                      SizedBox(height: isWeb ? 16 : 16.h),
                      _buildActionButton(
                        isWeb,
                        sDeleteProfile.tr,
                        Icons.delete_outline_rounded,
                        Colors.red,
                        () => controller.deleteProfile(isWeb),
                      ),

                      SizedBox(height: isWeb ? 30 : 30.h),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  // --- Helper Widgets to Clean up the Code ---

  Widget _buildProfileImage(bool isWeb) {
    return GestureDetector(
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
                height: isWeb ? 110 : 110.w,
                width: isWeb ? 110 : 110.w,
                color: Colors.grey[100],
                child: controller.attachmentPath.value.isNotEmpty
                    ? Image.file(
                        File(controller.attachmentPath.value),
                        fit: BoxFit.cover,
                      )
                    : controller.photo.value.isEmpty
                    ? Image.asset(ImageAssetsConstants.pic, fit: BoxFit.cover)
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
              height: isWeb ? 36 : 36.w,
              width: isWeb ? 36 : 36.w,
              decoration: BoxDecoration(
                color: AppColors.cAppColors,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: isWeb ? 18 : 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWrapper(
    bool isWeb,
    String title,
    Widget content, {
    bool showEdit = false,
    VoidCallback? onEdit,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(isWeb ? 16 : 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: getTextRegular(
                      size: isWeb ? 18 : 20.sp,
                      colors: Colors.black87,
                    ),
                  ),
                ),
                if (showEdit)
                  SizedBox(
                    height: isWeb ? 35 : 35.h,
                    child: ElevatedButton(
                      onPressed: onEdit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.cAppColors.withOpacity(0.1),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Edit",
                        style: getTextMedium(
                          size: isWeb ? 13 : 13.sp,
                          colors: AppColors.cAppColors,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Divider(height: 1, color: Colors.grey[100]),
          Padding(padding: EdgeInsets.all(isWeb ? 16 : 16.w), child: content),
        ],
      ),
    );
  }

  // Content Extractors
  Widget membershipContent(bool isWeb) => Column(
    children: [
      _buildInfoRow(
        isWeb,
        Icons.card_membership_outlined,
        "Type",
        controller.membershipType.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.badge_outlined,
        "ID",
        controller.membershipId.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.calendar_today_outlined,
        "End Date",
        controller.membershipEndDate.value.isEmpty
            ? "--"
            : controller.membershipEndDate.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.check_circle_outline,
        "Status",
        controller.membershipStatus.value ? "Active" : "Inactive",
        isLast: true,
      ),
    ],
  );

  Widget basicDetailsContent(bool isWeb) => Column(
    children: [
      _buildInfoRow(
        isWeb,
        Icons.person_outline,
        "User Name",
        controller.userName.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.email_outlined,
        "Email",
        controller.emailId.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.phone_outlined,
        "Phone",
        "+${controller.phoneNumber.value}",
        isLast: true,
      ),
    ],
  );

  Widget familyDetailsContent(bool isWeb) => Column(
    children: [
      _buildInfoRow(
        isWeb,
        Icons.person_outline,
        "Name",
        controller.pocFirstName.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.email_outlined,
        "Email",
        controller.pocEmailId.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.phone_outlined,
        "Phone",
        "+${controller.pocPhoneNumber.value}",
      ),
      if (controller.child1.value.isNotEmpty)
        _buildInfoRow(
          isWeb,
          Icons.child_care_outlined,
          "Child One",
          controller.child1.value,
        ),
      if (controller.child2.value.isNotEmpty)
        _buildInfoRow(
          isWeb,
          Icons.child_care_outlined,
          "Child Two",
          controller.child2.value,
          isLast: true,
        ),
    ],
  );

  Widget professionalContent(bool isWeb) => Column(
    children: [
      _buildInfoRow(
        isWeb,
        Icons.business_outlined,
        "Company",
        controller.companyName.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.work_outline,
        "Designation",
        controller.designation.value,
      ),
      _buildInfoRow(
        isWeb,
        Icons.location_on_outlined,
        "Location",
        controller.companyLocation.value,
        isLast: true,
      ),
    ],
  );

  Widget _buildDeviceCard(bool isWeb) {
    return _buildCardWrapper(
      isWeb,
      "Device Details",
      _buildInfoRow(
        isWeb,
        Icons.adb,
        "Device ID",
        controller.deviceId.value.isEmpty
            ? "Not Available"
            : controller.deviceId.value,
        isLast: true,
      ),
    );
  }

  Widget _buildActionButton(
    bool isWeb,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Container(
      width: double.infinity,
      height: isWeb ? 50 : 50.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1.5),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: isWeb ? 20 : 20.sp),
            SizedBox(width: 8),
            Text(
              label,
              style: getTextSemiBold(colors: color, size: isWeb ? 15 : 15.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    bool isWeb,
    IconData icon,
    String label,
    String value, {
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : (isWeb ? 16 : 16.h)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(isWeb ? 8 : 8.w),
            decoration: BoxDecoration(
              color: AppColors.cAppColors.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: isWeb ? 20 : 20.sp,
              color: AppColors.cAppColors,
            ),
          ),
          SizedBox(width: isWeb ? 12 : 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: getTextSemiBold(
                    size: isWeb ? 12 : 12.sp,
                    colors: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: isWeb ? 4 : 4.h),
                Text(
                  value.isEmpty ? "--" : value,
                  style: getTextSemiBold(
                    size: isWeb ? 17 : 17.sp,
                    colors: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
