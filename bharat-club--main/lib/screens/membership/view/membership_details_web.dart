import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/constant/custom_image.dart';
import 'package:mobileapp/common/constant/image_constants.dart';
import 'package:mobileapp/screens/membership/controller/membership_controller.dart';
import 'package:mobileapp/utils/app_text.dart';

class MembershipDetailsWeb extends GetView<MembershipDetailsController> {
  const MembershipDetailsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    // Ensuring the controller is available
    if (!Get.isRegistered<MembershipDetailsController>()) {
      Get.lazyPut(() => MembershipDetailsController());
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: Obx(
        () => SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 60.w, vertical: 40.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Membership Dashboard",
                style: getTextBold(colors: AppColors.cAppColors, size: 28.sp),
              ),
              SizedBox(height: 30.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Left Side: Profile Summary Card
                  Expanded(flex: 1, child: _buildWebProfileCard()),
                  SizedBox(width: 30.w),
                  // Right Side: Details & Benefits
                  Expanded(
                    flex: 2,
                    child: Column(
                      children: [
                        _buildWebMembershipStatusRow(),
                        SizedBox(height: 30.h),
                        _buildWebBenefitsCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWebProfileCard() {
    return Container(
      padding: EdgeInsets.all(30.r),
      decoration: _webCardDecoration(),
      child: Column(
        children: [
          _buildWebProfileImage(),
          SizedBox(height: 20.h),
          Text(
            controller.membershipId.value.isEmpty ? "Guest User" : "Member",
            style: getTextBold(colors: Colors.black, size: 20.sp),
          ),
          SizedBox(height: 10.h),
          Text(
            controller.membershipId.value,
            style: getTextMedium(colors: Colors.grey, size: 16.sp),
          ),
          SizedBox(height: 25.h),
          const Divider(),
          SizedBox(height: 20.h),
          _webInfoTile(
            Icons.email_outlined,
            "Contact Support",
            "admin@bharatclub.com",
          ),
        ],
      ),
    );
  }

  Widget _buildWebProfileImage() {
    return Container(
      width: 180.w,
      height: 180.h,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          colors: [AppColors.indiaOrange, AppColors.tertiaryGreen],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 15.r,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: EdgeInsets.all(5.r),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(10.r),
        child: ClipOval(
          child: controller.attachmentPath.value.isNotEmpty
              ? Image.file(
                  File(controller.attachmentPath.value),
                  fit: BoxFit.cover,
                )
              : (controller.photo.value.isEmpty
                    ? Image.asset(ImageAssetsConstants.pic, fit: BoxFit.cover)
                    : cacheProfilePictureImage(
                        controller.photo.value,
                        ImageAssetsConstants.pic,
                      )),
        ),
      ),
    );
  }

  Widget _buildWebMembershipStatusRow() {
    return Container(
      padding: EdgeInsets.all(30.r),
      decoration: _webCardDecoration(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _statusItem(
            "Type",
            controller.membershipType.value,
            Icons.card_membership,
          ),
          _statusVerticalDivider(),
          _statusItem(
            "Status",
            controller.membershipStatus.value ? "ACTIVE" : "INACTIVE",
            Icons.verified_user_outlined,
            color: controller.membershipStatus.value
                ? AppColors.primaryGreen
                : AppColors.error,
          ),
        ],
      ),
    );
  }

  Widget _buildWebBenefitsCard() {
    return Container(
      decoration: _webCardDecoration(),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.r),
            decoration: BoxDecoration(
              color: AppColors.cAppColors,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.r),
                topRight: Radius.circular(15.r),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.card_giftcard, color: Colors.white),
                SizedBox(width: 15.w),
                Text(
                  "Exclusive Member Benefits 2024",
                  style: getTextBold(colors: Colors.white, size: 18.sp),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(30.r),
            child: HtmlWidget(
              _benefitsHtmlContent(),
              textStyle: getTextRegular(
                colors: const Color(0xFF2C3E50),
                size: 14.sp,
                heights: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper UI Components
  BoxDecoration _webCardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    );
  }

  Widget _statusItem(
    String label,
    String value,
    IconData icon, {
    Color? color,
  }) {
    return Column(
      children: [
        Icon(icon, color: AppColors.indiaOrange, size: 28.sp),
        SizedBox(height: 10.h),
        Text(
          label,
          style: getTextMedium(colors: Colors.grey, size: 14.sp),
        ),
        Text(
          value,
          style: getTextBold(
            colors: color ?? AppColors.cAppColors,
            size: 18.sp,
          ),
        ),
      ],
    );
  }

  Widget _statusVerticalDivider() =>
      Container(height: 50.h, width: 1, color: Colors.grey.shade200);

  Widget _webInfoTile(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: 20.sp),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: getTextRegular(colors: Colors.grey, size: 12.sp),
            ),
            Text(
              value,
              style: getTextMedium(colors: Colors.black, size: 14.sp),
            ),
          ],
        ),
      ],
    );
  }

  String _benefitsHtmlContent() => '''
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
''';
}
