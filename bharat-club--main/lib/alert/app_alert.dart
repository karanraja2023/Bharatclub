import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/constant/size_constants.dart';
import 'package:mobileapp/common/widgets/loader.dart';
import 'package:mobileapp/utils/app_text.dart';
import 'package:mobileapp/utils/message_constants.dart';
import 'alert_action.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppAlert {
  AppAlert._();

  static showSnackBar(
    BuildContext context,
    String message, {
    Color mColor = Colors.grey,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
        backgroundColor: mColor,
      ),
    );
  }

  static Future<void> showCustomDismissDialog(
    BuildContext context,
    String message, {
    String? title,
    String? dismissButtonText,
    IconData? icon = Icons.info,
    VoidCallback? onDismiss,
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.0),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(SizeConstants.s_8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConstants.width * 0.08,
                    right: SizeConstants.s_14,
                    top: SizeConstants.width * 0.08,
                    bottom: SizeConstants.s_12,
                  ),
                  child: Row(
                    children: [
                      if (icon != null) ...[
                        Icon(
                          icon,
                          color: Colors.black87,
                          size: SizeConstants.width * 0.06,
                        ),
                        SizedBox(width: SizeConstants.s_12),
                      ],
                      Expanded(
                        child: Text(
                          title ?? "Info",
                          style: getTextSemiBold(
                            colors: Colors.black87,
                            size: SizeConstants.width * 0.045,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: SizeConstants.width * 0.08,
                    right: SizeConstants.s_14,
                    bottom: SizeConstants.s_12,
                  ),
                  child: Text(
                    message,
                    style: getTextRegular(
                      colors: Colors.black87,
                      size: SizeConstants.width * 0.04,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    SizeConstants.width * 0.08,
                    SizeConstants.width * 0.04,
                    SizeConstants.width * 0.08,
                    SizeConstants.width * 0.08,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: SizeConstants.width * 0.1,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              if (onDismiss != null) onDismiss();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade50,
                              side: BorderSide(
                                width: 1.5,
                                color: AppColors.cAppColorsBlue,
                              ),
                            ),
                            child: Text(
                              dismissButtonText ?? "Dismiss",
                              style: getTextMedium(
                                colors: AppColors.cAppColorsRed,
                                size: SizeConstants.width * 0.035,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static showProgressDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.2),
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(20),
              height: 100,
              width: 100,
              child: CustomLoader(),
            ),
          ),
        );
      },
    );
  }

  static showPro() {
    return Center(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white70,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: EdgeInsets.all(SizeConstants.s_16),
        height: 80,
        width: 80,
        child: const CircularProgressIndicator(
          strokeWidth: 6.0,
          color: AppColors.cAppColors,
        ),
      ),
    );
  }

  static showProgressDialogMessage(
    BuildContext context, {
    String message = MessageConstants.loading,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black38,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () {
            return Future.value(false);
          },
          child: Padding(
            padding: EdgeInsets.all(SizeConstants.s_16),
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                padding: EdgeInsets.all(SizeConstants.s_16),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(SizeConstants.s_16),
                      child: const CircularProgressIndicator(
                        strokeWidth: 5.0,
                        color: AppColors.cAppColors,
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: Text(
                          message,
                          style: getTextRegular(
                            colors: Colors.black,
                            size: SizeConstants.width * 0.04,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  static hideLoadingDialog(BuildContext context) {
    Get.back();
  }

  static Future<AlertAction> showCustomDialogYesNoLogout(
    BuildContext context,
    String message, {
    String? title,
    String? negativeActionText,
    String? positiveActionText,
  }) async {
    final action = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 14.w,
                    top: 20.w,
                    bottom: 12.h,
                  ),
                  child: Text(
                    title ?? "Log Out?",
                    style: getTextSemiBold(colors: Colors.black87, size: 16.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 14.w,
                    bottom: 12.h,
                  ),
                  child: Text(
                    message,
                    style: getTextRegular(colors: Colors.black87, size: 14.sp),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 20.h),
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 45.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.back(result: AlertAction.no);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey.shade50,
                              side: const BorderSide(
                                width: 1.5,
                                color: AppColors.cAppColorsBlue,
                              ),
                            ),
                            child: Text(
                              negativeActionText ?? 'Cancel',
                              style: getTextMedium(
                                colors: AppColors.cAppColorsRed,
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 14.w),
                      Expanded(
                        child: SizedBox(
                          height: 45.h,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.cAppColorsBlue,
                            ),
                            onPressed: () {
                              Get.back(result: AlertAction.yes);
                            },
                            child: Text(
                              positiveActionText ?? "Log Out",
                              style: getTextMedium(
                                colors: Colors.white,
                                size: 14.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    return (action != null) ? action : AlertAction.cancel;
  }
}

class AlertActionWithReturnString {
  final AlertAction alertAction;
  final String reasonString;

  AlertActionWithReturnString(this.alertAction, this.reasonString);
}
