import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/constant/custom_image.dart';
import 'package:organization/common/constant/image_constants.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/screens/membership/controller/membership_controller.dart';
import 'package:organization/utils/app_text.dart';

// Import font helpers

class MembershipDetailsScreen extends GetView<MembershipDetailsController> {
  const MembershipDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MembershipDetailsController());

    return FocusDetector(
      onVisibilityGained: () {
        controller.getProfile();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(title: 'Membership Details'),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 32.h),
                _buildProfileSection(),
                SizedBox(height: 24.h),
                _membershipTypeUI(),
                SizedBox(height: 16.h),
                _membershipDetailsUI(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Container(
        width: 150.w,
        height: 150.h,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            colors: [AppColors.indiaOrange, AppColors.tertiaryGreen],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 20.r,
              offset: Offset(0, 8.h),
            ),
          ],
        ),
        padding: EdgeInsets.all(4.r),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(8.r),
          child: ClipOval(child: _getProfileImage()),
        ),
      ),
    );
  }

  Widget _getProfileImage() {
    if (controller.attachmentPath.value.isNotEmpty) {
      return Image.file(
        File(controller.attachmentPath.value),
        fit: BoxFit.cover,
      );
    } else if (controller.photo.value.isEmpty) {
      return Image.asset(ImageAssetsConstants.pic, fit: BoxFit.cover);
    } else {
      return cacheProfilePictureImage(
        controller.photo.value,
        ImageAssetsConstants.pic,
      );
    }
  }

  Widget _membershipTypeUI() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: const LinearGradient(
          colors: [
            AppColors.indiaOrange,
            AppColors.white,
            AppColors.secondaryGreen,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6,
            spreadRadius: 2,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              "Membership Details",
              style: getTextBold(colors: AppColors.primaryGreen, size: 20.sp),
            ),
          ),
          SizedBox(height: 20.h),
          _infoRow(
            Icons.card_membership,
            "Membership Id",
            controller.membershipId.value.isEmpty
                ? "--"
                : controller.membershipId.value,
          ),
          Divider(height: 24.h, thickness: 1, color: Colors.black26),
          _infoRow(
            Icons.stars,
            "Membership Type",
            controller.membershipType.value,
          ),
          Divider(height: 24.h, thickness: 1, color: Colors.black26),
          _infoRow(
            Icons.verified,
            "Status",
            controller.membershipStatus.value ? "Active" : "Inactive",
            valueColor: controller.membershipStatus.value
                ? AppColors.primaryGreen
                : AppColors.error,
            showStatusContainer: true,
          ),
        ],
      ),
    );
  }

  Widget _infoRow(
    IconData icon,
    String label,
    String value, {
    Color valueColor = AppColors.indiaOrange,
    bool showStatusContainer = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.indiaOrange, size: 22.sp),
        SizedBox(width: 12.w),
        Expanded(
          child: Text(
            label,
            style: getTextMedium(colors: AppColors.secondaryGreen, size: 16.sp),
          ),
        ),
        showStatusContainer
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: valueColor.withOpacity(0.2),
                  border: Border.all(color: valueColor),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  value,
                  style: getTextBold(colors: valueColor, size: 14.sp),
                ),
              )
            : Text(
                value,
                style: getTextBold(colors: valueColor, size: 16.sp),
              ),
      ],
    );
  }

  Widget _membershipDetailsUI() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15.r,
            offset: Offset(0, 5.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.cAppColors, AppColors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.card_giftcard, color: Colors.white, size: 24.sp),
                SizedBox(width: 12.w),
                Text(
                  "Member Benefits & Offers",
                  style: getTextBold(colors: Colors.white, size: 18.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(24.r),
            child: HtmlWidget(
              '''
<div style="line-height: 1.8;">
<p style="margin-bottom: 16px; color: #2C3E50; font-weight: 600;">Dear Bharat Club Members,</p>

<p style="margin-bottom: 16px; color: #E74C3C; font-weight: 700; font-size: 16px;">Countdown to 50th Anniversary</p>

<p style="margin-bottom: 20px; color: #34495E;">We are pleased to announce an updated list of restaurants offering exclusive discounts to Bharat Club registered members in 2024.</p>

<div style="background: linear-gradient(135deg, #FFF8F0 0%, #F0FFF4 100%); padding: 20px; border-radius: 12px; margin-bottom: 20px; border-left: 4px solid #ED9F54;">

<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>Bombay Palace:</strong> 15%</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>Delhi Royale:</strong> 10%</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>Musca:</strong> 10%</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>WTF Restaurant:</strong> 10%</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>Cholas by WTF:</strong> 10%</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>Sagar Restaurant:</strong> 10%</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>Frangipani:</strong> 15%</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #ED9F54;">STAR</strong> <strong>Spice Garden (all branches):</strong> 10% + Complimentary dessert</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #4EAB5F;">STAR</strong> <strong>Sunway Medical Center:</strong> 15% on selected Medical Checkups</p>
<p style="margin: 8px 0; color: #2C3E50;"><strong style="color: #4EAB5F;">STAR</strong> <strong>Olive Tree Group:</strong> 15% off F&B (dine-in only)</p>

</div>

<p style="margin-bottom: 16px; color: #34495E; background: #E8F5E9; padding: 12px; border-radius: 8px;">MOBILE <strong>E-Membership Card:</strong> Available to all 2024 registered members. Check your messages!</p>

<p style="margin-bottom: 12px; color: #27AE60; font-weight: 600;">Thanks for being part of Bharat Club Kuala Lumpur.</p>

<p style="margin-top: 20px; margin-bottom: 4px; color: #7F8C8D;">Best regards,</p>
<p style="margin: 0; color: #2C3E50; font-weight: 600;">Bharat Club Management Committee</p>
</div>
''',
              textStyle: getTextRegular(
                colors: const Color(0xFF2C3E50),
                size: 15.sp,
                heights: 1.6,
              ),
              customStylesBuilder: (element) {
                if (element.localName == 'strong') {
                  return {'font-weight': 'bold'};
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }
}
