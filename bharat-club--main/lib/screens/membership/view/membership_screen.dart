import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/constant/custom_image.dart';
import 'package:mobileapp/common/constant/image_constants.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/screens/membership/controller/membership_controller.dart';
import 'package:mobileapp/utils/app_text.dart';

import 'membership_details_web.dart';

// Import font helpers

class MembershipDetailsScreen extends GetView<MembershipDetailsController> {
  const MembershipDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MembershipDetailsController());

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
                  child: membershipDetailsMobile(true),
                ),
              ),
            ),
          );
        } else {
          return membershipDetailsMobile(false);
        }
      },
    );
  }

  Widget membershipDetailsMobile(bool isWeb) {
    return FocusDetector(
      onVisibilityGained: () {
        controller.getProfile();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Membership Details',
          showBack: true,
          isWeb: isWeb,
        ),
        body: Obx(
          () => SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Use fixed height for web, scaled for mobile
                SizedBox(height: isWeb ? 40 : 32.h),
                _buildProfileSection(isWeb),
                SizedBox(height: isWeb ? 30 : 24.h),
                _membershipTypeUI(isWeb),
                SizedBox(height: isWeb ? 20 : 16.h),
                _membershipDetailsUI(isWeb),
                SizedBox(height: isWeb ? 40 : 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(bool isWeb) {
    return Center(
      child: Container(
        // Lock size on web so the avatar doesn't become huge
        width: isWeb ? 160 : 150.w,
        height: isWeb ? 160 : 150.h,
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
              blurRadius: isWeb ? 20 : 20.r,
              offset: Offset(0, isWeb ? 8 : 8.h),
            ),
          ],
        ),
        padding: EdgeInsets.all(isWeb ? 4 : 4.r),
        child: Container(
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          padding: EdgeInsets.all(isWeb ? 8 : 8.r),
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

  Widget _membershipTypeUI(bool isWeb) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isWeb ? 24 : 16.w,
        vertical: isWeb ? 15 : 12.h,
      ),
      padding: EdgeInsets.all(isWeb ? 24 : 20.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
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
              style: getTextBold(
                colors: AppColors.primaryGreen,
                size: isWeb ? 22 : 20.sp, // Fixed size for web
              ),
            ),
          ),
          SizedBox(height: isWeb ? 25 : 20.h),
          _infoRow(
            Icons.card_membership,
            "Membership Id",
            controller.membershipId.value.isEmpty
                ? "--"
                : controller.membershipId.value,
            isWeb,
          ),
          Divider(
            height: isWeb ? 30 : 24.h,
            thickness: 1,
            color: Colors.black26,
          ),
          _infoRow(
            Icons.stars,
            "Membership Type",
            controller.membershipType.value,
            isWeb,
          ),
          Divider(
            height: isWeb ? 30 : 24.h,
            thickness: 1,
            color: Colors.black26,
          ),
          _infoRow(
            Icons.verified,
            "Status",
            controller.membershipStatus.value ? "Active" : "Inactive",
            isWeb,
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
    String value,
    bool isWeb, {
    Color valueColor = AppColors.indiaOrange,
    bool showStatusContainer = false,
  }) {
    return Row(
      children: [
        Icon(icon, color: AppColors.indiaOrange, size: isWeb ? 22 : 22.sp),
        SizedBox(width: isWeb ? 15 : 12.w),
        Expanded(
          child: Text(
            label,
            style: getTextMedium(
              colors: AppColors.secondaryGreen,
              size: isWeb ? 16 : 16.sp,
            ),
          ),
        ),
        showStatusContainer
            ? Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isWeb ? 12 : 10.w,
                  vertical: isWeb ? 6 : 4.h,
                ),
                decoration: BoxDecoration(
                  color: valueColor.withOpacity(0.2),
                  border: Border.all(color: valueColor),
                  borderRadius: BorderRadius.circular(isWeb ? 20 : 20.r),
                ),
                child: Text(
                  value,
                  style: getTextBold(
                    colors: valueColor,
                    size: isWeb ? 14 : 14.sp,
                  ),
                ),
              )
            : Text(
                value,
                style: getTextBold(
                  colors: valueColor,
                  size: isWeb ? 16 : 16.sp,
                ),
              ),
      ],
    );
  }

  Widget _membershipDetailsUI(bool isWeb) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: isWeb ? 30 : 20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isWeb ? 20 : 20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: isWeb ? 15 : 15.r,
            offset: Offset(0, isWeb ? 5 : 5.h),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(isWeb ? 20 : 20.r),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.cAppColors, AppColors.white],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isWeb ? 20 : 20.r),
                topRight: Radius.circular(isWeb ? 20 : 20.r),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.card_giftcard,
                  color: Colors.white,
                  size: isWeb ? 24 : 24.sp,
                ),
                SizedBox(width: isWeb ? 15 : 12.w),
                Text(
                  "Member Benefits & Offers",
                  style: getTextBold(
                    colors: Colors.white,
                    size: isWeb ? 18 : 18.sp,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(isWeb ? 24 : 24.r),
            child: HtmlWidget(
              _resolvedMembershipHtmlContent(),
              textStyle: getTextRegular(
                colors: const Color(0xFF2C3E50),
                size: isWeb ? 15 : 15.sp, // Fixed for web
                heights: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _resolvedMembershipHtmlContent() {
    final rawHtml = controller.membershipHtmlContent.value.trim();

    if (rawHtml.isEmpty) {
      return _benefitsHtmlContent();
    }

    final sanitizedHtml = _sanitizeMembershipHtmlContent(rawHtml);
    return sanitizedHtml.isNotEmpty ? sanitizedHtml : _benefitsHtmlContent();
  }

  String _sanitizeMembershipHtmlContent(String html) {
    return html
        .replaceAll(RegExp(r'<font[^>]*>', caseSensitive: false), '')
        .replaceAll(RegExp(r'</font>', caseSensitive: false), '')
        .replaceAll(RegExp(r'<table[^>]*>', caseSensitive: false), '<div>')
        .replaceAll(RegExp(r'</table>', caseSensitive: false), '</div>')
        .replaceAll(RegExp(r'<tr[^>]*>', caseSensitive: false), '<div>')
        .replaceAll(RegExp(r'</tr>', caseSensitive: false), '</div>')
        .replaceAll(RegExp(r'<td[^>]*>', caseSensitive: false), '<div>')
        .replaceAll(RegExp(r'</td>', caseSensitive: false), '</div>')
        .replaceAll('2026}.', '2026.')
        .trim();
  }

  String _benefitsHtmlContent() => '''
<div style="line-height: 1.8;">
<p style="margin-bottom: 16px; color: #2C3E50; font-weight: 600;">Dear Bharat Club Members,</p>

<p style="margin-bottom: 20px; color: #34495E;">We are pleased to announce an updated list of restaurants offering exclusive discounts to Bharat Club registered members in ${DateTime.now().year}.</p>

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

<p style="margin-bottom: 16px; color: #34495E; background: #E8F5E9; padding: 12px; border-radius: 8px;">MOBILE <strong>E-Membership Card:</strong> Available to all ${DateTime.now().year} registered members. Check your messages!</p>

<p style="margin-bottom: 12px; color: #27AE60; font-weight: 600;">Thanks for being part of Bharat Club Kuala Lumpur.</p>

<p style="margin-top: 20px; margin-bottom: 4px; color: #7F8C8D;">Best regards,</p>
<p style="margin: 0; color: #2C3E50; font-weight: 600;">Bharat Club Management Committee</p>
</div>
''';
}
