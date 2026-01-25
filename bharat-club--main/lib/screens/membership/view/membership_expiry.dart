import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mobileapp/alert/app_alert.dart';
import 'package:mobileapp/app/routes_name.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/data/local/shared_prefs/shared_prefs.dart';
import 'package:mobileapp/utils/app_text.dart';

class MembershipExpiredPage extends StatelessWidget {
  final VoidCallback? onContactPressed;
  final VoidCallback? onRenewPressed;

  const MembershipExpiredPage({
    Key? key,
    this.onContactPressed,
    this.onRenewPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const CustomAppBar(
        title: 'Membership Expired',
        showBack: false,
        showMenu: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h),

            // Icon Container
            Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cAppColorsRed.shade50,
                    AppColors.cAppColorsRed.shade100,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cAppColorsRed.shade200.withOpacity(0.3),
                    blurRadius: 20,
                    spreadRadius: 5,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.event_busy_rounded,
                size: 70.sp,
                color: AppColors.cAppColorsRed.shade600,
              ),
            ),

            SizedBox(height: 32.h),

            // Title
            Text(
              'Membership Expired',
              style: getTextBold(
                colors: const Color(0xFF2C3E50),
                size: 26.sp,
                heights: 1.2,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 12.h),

            // Subtitle
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                'Your membership has expired. Please renew to continue accessing all club features and benefits.',
                style: getTextMedium(
                  size: 15.sp,
                  heights: 1.5,
                  colors: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 40.h),

            // Contact Support Button
            Container(
              width: double.infinity,
              height: 54.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.secondaryGreen.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: OutlinedButton.icon(
                onPressed:
                    onContactPressed ??
                    () {
                      AppAlert.showSnackBar(
                        context,
                        'Please contact: clubbharat@gmail.com',
                      );
                    },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.secondaryGreen,
                  side: BorderSide(color: AppColors.secondaryGreen, width: 2.w),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                icon: Icon(Icons.support_agent_rounded, size: 22.sp),
                label: Text(
                  'Contact Support',
                  style: getTextSemiBold(
                    size: 16.sp,
                    colors: AppColors.secondaryGreen,
                  ),
                ),
              ),
            ),

            SizedBox(height: 28.h),

            // Info Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.secondaryGreen.withOpacity(0.05),
                    AppColors.secondaryGreen.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14.r),
                border: Border.all(
                  color: AppColors.secondaryGreen.withOpacity(0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryGreen.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.info_outline_rounded,
                      color: AppColors.secondaryGreen,
                      size: 22.sp,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Need Help?',
                          style: getTextSemiBold(
                            size: 16.sp,
                            colors: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'For membership renewal queries, please reach out to our support team. We\'re here to help you!',
                          style: getTextRegular(
                            size: 14.sp,
                            heights: 1.4,
                            colors: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 36.h),

            // Benefits Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.stars_rounded,
                        color: AppColors.secondaryGreen,
                        size: 24.sp,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Membership Benefits',
                        style: getTextBold(
                          size: 18.sp,
                          colors: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  _buildBenefitItem(
                    icon: Icons.event_available_rounded,
                    text: 'Access to exclusive events',
                  ),
                  SizedBox(height: 14.h),
                  _buildBenefitItem(
                    icon: Icons.event,
                    text: 'Attend exclusive events',
                  ),
                  SizedBox(height: 14.h),
                  _buildBenefitItem(
                    icon: Icons.photo_library_rounded,
                    text: 'View event galleries',
                  ),
                  SizedBox(height: 14.h),
                  _buildBenefitItem(
                    icon: Icons.groups_rounded,
                    text: 'Be a part of our community',
                  ),
                  SizedBox(height: 14.h),
                  _buildBenefitItem(
                    icon: Icons.card_membership_rounded,
                    text: 'Member-only privileges',
                  ),
                ],
              ),
            ),

            SizedBox(height: 40.h),
            Container(
              width: double.infinity,
              height: 54.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cAppColorsRed.shade300.withOpacity(0.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cAppColorsRed.shade500,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                ),
                icon: Icon(Icons.logout_rounded, size: 20.sp),
                label: Text(
                  'Logout',
                  style: getTextSemiBold(size: 16.sp, colors: Colors.white),
                ),
                onPressed: () async {
                  await SharedPrefs().logout();
                  Get.offAllNamed(AppRoutes.loginScreen);
                },
              ),
            ),

            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem({required IconData icon, required String text}) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          decoration: BoxDecoration(
            color: AppColors.secondaryGreen.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, size: 18.sp, color: AppColors.secondaryGreen),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Text(
            text,
            style: getTextMedium(size: 15.sp, colors: AppColors.textSecondary),
          ),
        ),
      ],
    );
  }
}
