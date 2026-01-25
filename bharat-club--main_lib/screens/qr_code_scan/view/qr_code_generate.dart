import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/common/widgets/loader.dart';
import 'package:organization/utils/app_text.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../controller/qr_code_generate_controller.dart';

class QrCodeGenerateScreen extends StatelessWidget {
  final mQrDetails;

  QrCodeGenerateScreen({super.key, required this.mQrDetails});

  final QrCodeGenerateController controller = Get.put(
    QrCodeGenerateController(),
  );

  @override
  Widget build(BuildContext context) {
    final String qrData = mQrDetails.membershipId;
    final String eventId = mQrDetails.eventId;

    final String dataFormat = 'Bharat=$qrData&$eventId';
    String encodedData = controller.encodeToBase64(dataFormat);

    return WillPopScope(
      onWillPop: () async {
        // Prevent back navigation to the form
        // Go directly to home instead
        Get.offAllNamed(AppRoutes.home);
        return false;
      },
      child: FocusDetector(
        onFocusGained: () {
          // Screen is now visible
          print("QR Screen is visible");
        },
        child: Scaffold(
          backgroundColor: Colors.grey[50],
          appBar: CustomAppBar(
            title: 'QR Code',
            showBack: true,
            onBackPressed: () {
              Get.offAllNamed(AppRoutes.home);
            },
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.15),
                          spreadRadius: 3,
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Scan to Check-In",
                          style: getTextSemiBold1(
                            size: 18.sp,
                            colors: AppColors.textPrimary,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        _buildQrCodeWidget(encodedData),
                        SizedBox(height: 20.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryGreen.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.primaryGreen.withOpacity(0.5),
                              width: 1.5,
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.badge_outlined,
                                size: 20.sp,
                                color: AppColors.primaryGreen,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                "ID: $qrData",
                                style: getTextSemiBold1(
                                  size: 15.sp,
                                  colors: AppColors.primaryGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),

                  // Instructions Card
                  Container(
                    width: 1.sw,
                    padding: EdgeInsets.all(18.w),
                    decoration: BoxDecoration(
                      color: Colors.amber[50],
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: Colors.amber[300]!, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: Colors.amber[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.info_outline,
                            color: Colors.amber[800],
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 14.w),
                        Expanded(
                          child: Text(
                            "Show this QR code at the entrance for check-in",
                            style: getTextRegular(
                              size: 14.sp,
                              colors: Colors.amber,
                              heights: 1.3.h,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Back to Home Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Clear navigation stack and go to home
                        Get.offAllNamed(AppRoutes.home);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryGreen,
                        elevation: 4,
                        shadowColor: AppColors.secondaryGreen.withOpacity(0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.home_rounded,
                            size: 24.sp,
                            color: Colors.white,
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            "Back to Home",
                            style: getTextSemiBold(
                              size: 17.sp,
                              colors: Colors.white,
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
          ),
        ),
      ),
    );
  }

  Widget _buildQrCodeWidget(String encodedData) {
    if (encodedData.isEmpty) {
      return const CustomLoader();
    } else {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: Colors.grey[300]!, width: 3),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: QrImageView(
          data: encodedData,
          version: QrVersions.auto,
          size: 260.w,
          eyeStyle: QrEyeStyle(
            eyeShape: QrEyeShape.square,
            color: AppColors.primaryGreen,
          ),
          dataModuleStyle: QrDataModuleStyle(
            dataModuleShape: QrDataModuleShape.square,
            color: Colors.black,
          ),
        ),
      );
    }
  }
}
