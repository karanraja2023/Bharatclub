import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:organization/common/constant/custom_image.dart';
import 'package:organization/common/constant/image_constants.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/common/widgets/text_input.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/app_util_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/mode/cms_page/event_response.dart';
import '../controller/event_details_one_controller.dart';
import 'package:organization/app_theme/theme/app_theme.dart';

class EventDetailsTwoScreen extends GetView<EventDetailsOneController> {
  final EventModule mEventModule;

  const EventDetailsTwoScreen({super.key, required this.mEventModule});

  @override
  Widget build(BuildContext context) {
    Get.find<EventDetailsOneController>();

    return FocusDetector(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: CustomAppBar(title: 'Event Payment Page'),
        body: Container(
          height: 0.85.sh,
          width: 1.sw,
          padding: EdgeInsets.all(16.w),
          margin: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16.r)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                spreadRadius: 0,
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: eventDetailsView(context),
        ),
      ),
    );
  }

  eventDetailsView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Enhanced Banner with gradient overlay
          _generateBanners(mEventModule.eventAttachments),

          SizedBox(height: 20.h),

          // Event Title with icon
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.cAppColorsBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(
                  Icons.event,
                  color: AppColors.cAppColorsBlue,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  controller.mTitle.value,
                  style: getTextSemiBold(
                    colors: AppColors.cAppColorsBlue,
                    size: 18.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 28.h),

          // Food Catering Section with enhanced card
          controller.mFoodStatus == '1'
              ? _buildSectionCard(
                  title: "Food Catering",
                  icon: Icons.restaurant_menu,
                  child: Column(
                    children: [
                      _buildFoodInputField(
                        label: "Vegetarian",
                        controller: controller.mVegetarianController.value,
                        icon: Icons.eco,
                      ),
                      SizedBox(height: 16.h),
                      _buildFoodInputField(
                        label: "Non-Vegetarian",
                        controller: controller.mNonVegetarianController.value,
                        icon: Icons.dining,
                      ),
                      SizedBox(height: 16.h),
                      _buildFoodInputField(
                        label: "Jain",
                        controller: controller.mJainController.value,
                        icon: Icons.menu_book,
                      ),
                    ],
                  ),
                )
              : SizedBox.shrink(),

          // Subscription Charge Section with enhanced card
          Obx(() {
            if (controller.isMemberRenewal.value &&
                controller.mSubscriptionStatus.value == '1') {
              return Column(
                children: [
                  SizedBox(height: 20.h),
                  _buildSectionCard(
                    title: "Subscription Charge",
                    icon: Icons.credit_card,
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.cAppColorsBlue.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: AppColors.cAppColorsBlue.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value:
                                controller.isSubscriptionRenewalChecked.value,
                            onChanged: (value) {
                              controller.isSubscriptionRenewalCheck(value!);
                            },
                            activeColor: AppColors.cAppColorsBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Include Subscription Renewal Fee",
                              style: getTextRegular(
                                colors: Colors.black87,
                                size: 15.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          }),

          // Enhanced Summary Widget
          SizedBox(height: 28.h),
          summaryWidget(),

          // File Upload Section with enhanced design
          SizedBox(height: 28.h),
          _buildFilePaymentQr(),

          // File Upload Section with enhanced design
          SizedBox(height: 28.h),
          _buildFileUploadSection(),

          // Total Payment Amount with enhanced badge
          SizedBox(height: 28.h),
          _buildTotalPaymentSection(),

          // Enhanced Proceed Button
          SizedBox(height: 40.h),
          _buildProceedButton(),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  // Helper method for food input fields
  Widget _buildFoodInputField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18.sp, color: AppColors.cAppColorsBlue),
            SizedBox(width: 8.w),
            Text(
              label,
              style: getTextRegular(colors: Colors.black87, size: 15.sp),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        TextInputWidget(
          placeHolder: "Enter quantity",
          controller: controller,
          errorText: null,
          textInputType: TextInputType.number,
          hintText: "0",
          showFloatingLabel: false,
          maxLines: 1,
          maxCharLength: 2,
          onFilteringTextInputFormatter: [
            FilteringTextInputFormatter.allow(
              RegExp(AppUtilConstants.patternOnlyNumber),
            ),
            LengthLimitingTextInputFormatter(2),
          ],
        ),
      ],
    );
  }

  // Enhanced section card wrapper
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.cAppColorsBlue.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cAppColorsBlue.withOpacity(0.08),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: AppColors.cAppColorsBlue,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: Colors.white, size: 20.sp),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  title,
                  style: getTextSemiBold(
                    colors: AppColors.cAppColorsBlue,
                    size: 17.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  // PaymentQr
  Widget _buildFilePaymentQr() {
    return _buildSectionCard(
      title: "Payment QR code",
      icon: Icons.qr_code_scanner_outlined,
      child:Column(
        children: [
          Image.asset(
            'assets/images/payment_qr.png',
            width: 200,
            height: 200,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          const Text("Scan this QR code to make payment"),
          const SizedBox(height: 12),
          InkWell(
            onTap: () {
              controller.downloadQR();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.cAppColorsBlue,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.cAppColorsBlue.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.cloud_download, color: Colors.white, size: 22.sp),
                  SizedBox(width: 10.w),
                  Text(
                    "Download QR Code",
                    style: getTextSemiBold(colors: Colors.white, size: 15.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      )
      // Row(
      //   children: [
      //     Expanded(
      //       child: InkWell(
      //         onTap: () {
      //           controller.showQrDialog();
      //         },
      //         child: Container(
      //           padding: EdgeInsets.symmetric(vertical: 16.h),
      //           decoration: BoxDecoration(
      //             color: AppColors.cAppColorsBlue,
      //             borderRadius: BorderRadius.circular(10.r),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: AppColors.cAppColorsBlue.withOpacity(0.3),
      //                 blurRadius: 8,
      //                 spreadRadius: 0,
      //                 offset: Offset(0, 4),
      //               ),
      //             ],
      //           ),
      //           alignment: Alignment.center,
      //           child: Row(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Icon(Icons.qr_code_scanner_outlined, color: Colors.white, size: 22.sp),
      //               SizedBox(width: 10.w),
      //               Text(
      //                 "View",
      //                 style: getTextSemiBold(colors: Colors.white, size: 15.sp),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     SizedBox(width: 15.sp),
      //     Expanded(
      //       child: InkWell(
      //         onTap: () {
      //           controller.downloadQR();
      //         },
      //         child: Container(
      //           padding: EdgeInsets.symmetric(vertical: 16.h),
      //           decoration: BoxDecoration(
      //             color: AppColors.cAppColorsBlue,
      //             borderRadius: BorderRadius.circular(10.r),
      //             boxShadow: [
      //               BoxShadow(
      //                 color: AppColors.cAppColorsBlue.withOpacity(0.3),
      //                 blurRadius: 8,
      //                 spreadRadius: 0,
      //                 offset: Offset(0, 4),
      //               ),
      //             ],
      //           ),
      //           alignment: Alignment.center,
      //           child: Row(
      //             mainAxisSize: MainAxisSize.min,
      //             children: [
      //               Icon(Icons.cloud_download, color: Colors.white, size: 22.sp),
      //               SizedBox(width: 10.w),
      //               Text(
      //                 "Download QR Code",
      //                 style: getTextSemiBold(colors: Colors.white, size: 15.sp),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }

  // Enhanced file upload section
  Widget _buildFileUploadSection() {
    return _buildSectionCard(
      title: "Upload Payment Receipt",
      icon: Icons.upload_file,
      child: Obx(() {
        final selectedFile = controller.mPaymentReceiptController.value.text;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Accepted formats: Image or PDF",
              style: getTextRegular(colors: Colors.grey, size: 13.sp),
            ),
            SizedBox(height: 12.h),

            if (selectedFile.isNotEmpty)
              Container(
                margin: EdgeInsets.only(bottom: 12.h),
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.cAppColorsBlue.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.cAppColorsBlue.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: AppColors.cAppColorsBlue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Icon(
                        Icons.description,
                        color: AppColors.cAppColorsBlue,
                        size: 20.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        selectedFile.split('/').last,
                        style: getTextRegular(
                          colors: Colors.black87,
                          size: 14.sp,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.red[400]),
                      onPressed: () {
                        controller.mPaymentReceiptController.value.text = "";
                        controller.mPaymentReceiptController.refresh();
                      },
                    ),
                  ],
                ),
              ),

            InkWell(
              onTap: () {
                controller.getUploadFile();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.cAppColorsBlue,
                  borderRadius: BorderRadius.circular(10.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cAppColorsBlue.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cloud_upload, color: Colors.white, size: 22.sp),
                    SizedBox(width: 10.w),
                    Text(
                      "Choose File",
                      style: getTextSemiBold(colors: Colors.white, size: 15.sp),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // Enhanced total payment section
  Widget _buildTotalPaymentSection() {
    return Obx(() {
      return Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.cAppColorsBlue,
              AppColors.cAppColorsBlue.withOpacity(0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.cAppColorsBlue.withOpacity(0.3),
              blurRadius: 12,
              spreadRadius: 0,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Payment Amount",
                  style: getTextRegular(
                    colors: Colors.white.withOpacity(0.9),
                    size: 14.sp,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "RM ${controller.totalPaymentAmount.value.toStringAsFixed(2)}",
                  style: getTextBold(colors: Colors.white, size: 24.sp),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.account_balance_wallet,
                color: Colors.white,
                size: 28.sp,
              ),
            ),
          ],
        ),
      );
    });
  }

  // Enhanced proceed button
  Widget _buildProceedButton() {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: [
            AppColors.cAppColors,
            AppColors.cAppColors.withOpacity(0.85),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.cAppColors.withOpacity(0.4),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            controller.validateTotalPax();
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Proceed",
                  style: getTextSemiBold(colors: Colors.white, size: 16.sp),
                ),
                SizedBox(width: 8.w),
                Icon(Icons.arrow_forward, color: Colors.white, size: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Enhanced summary widget
  Widget summaryWidget() {
    return Obx(
      () => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.cAppColorsBlue.withOpacity(0.15),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.cAppColorsBlue.withOpacity(0.08),
              blurRadius: 12,
              spreadRadius: 0,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.cAppColorsBlue,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(
                    Icons.receipt_long,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  "Payment Summary",
                  style: getTextBold(
                    colors: AppColors.cAppColorsBlue,
                    size: 19.sp,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Divider(color: Colors.grey.shade300, thickness: 1),

            summaryRow(
              label:
                  "Adults (${controller.mNumberOfAdultsController.value.text} x ${(double.tryParse(controller.mMemberAdultAmount.value) ?? 0.0).toStringAsFixed(2)}):",
              amount:
                  "${(int.tryParse(controller.mNumberOfAdultsController.value.text) ?? 0) * (double.tryParse(controller.mMemberAdultAmount.value) ?? 0.00)}",
            ),

            (controller.mMemberChildStatus.value == '1')
                ? Column(
                    children: [
                      Divider(color: Colors.grey.shade300, thickness: 1),
                      summaryRow(
                        label:
                            "Children (${controller.mNumberOfChildrenAgeLimitController.value.text} x ${(double.tryParse(controller.mMemberChildAmount.value) ?? 0.00).toStringAsFixed(2)}):",
                        amount:
                            "${(int.tryParse(controller.mNumberOfChildrenAgeLimitController.value.text) ?? 0) * (double.tryParse(controller.mMemberChildAmount.value) ?? 0.0)}",
                      ),
                    ],
                  )
                : SizedBox.shrink(),

            Divider(color: Colors.grey.shade300, thickness: 1),

            summaryRow(
              label:
                  "Guests (${controller.mNumberOfGuestAdultsController.value.text} x ${(double.tryParse(controller.mGuestAdultAmount.value) ?? 0.0).toStringAsFixed(2)}):",
              amount:
                  "${(int.tryParse(controller.mNumberOfGuestAdultsController.value.text) ?? 0) * (double.tryParse(controller.mGuestAdultAmount.value) ?? 0.0)}",
            ),

            controller.mGuestChildStatus == '1'
                ? Column(
                    children: [
                      Divider(color: Colors.grey.shade300, thickness: 1),
                      summaryRow(
                        label:
                            "Guest Children (${controller.mNumberOfGuestChildrenAge12AboveController.value.text} x ${(double.tryParse(controller.mGuestChildAmount.value) ?? 0.0).toStringAsFixed(2)}):",
                        amount:
                            "${(int.tryParse(controller.mNumberOfGuestChildrenAge12AboveController.value.text) ?? 0) * (double.tryParse(controller.mGuestChildAmount.value) ?? 0.0)}",
                      ),
                    ],
                  )
                : SizedBox.shrink(),

            if (controller.isSubscriptionRenewalChecked.value) ...[
              Divider(color: Colors.grey.shade300, thickness: 1),
              summaryRow(
                label: "Subscription Charge:",
                amount: controller.mSubscriptionAmount.value,
              ),
            ],

            SizedBox(height: 12.h),
            Divider(
              color: AppColors.cAppColorsBlue.withOpacity(0.3),
              thickness: 2,
            ),
            SizedBox(height: 8.h),

            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.cAppColorsBlue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total Amount:",
                    style: getTextBold(
                      colors: AppColors.cAppColorsBlue,
                      size: 18.sp,
                    ),
                  ),
                  Text(
                    "RM ${controller.totalPaymentAmount.value.toStringAsFixed(2)}",
                    style: getTextBold(
                      colors: AppColors.cAppColorsBlue,
                      size: 20.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget summaryRow({required String label, required String amount}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              label,
              style: getTextRegular(colors: Colors.black87, size: 14.sp),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            double.tryParse(amount) == 0
                ? "No Cost"
                : "RM ${double.parse(amount).toStringAsFixed(2)}",
            style: getTextSemiBold(
              colors: AppColors.cAppColorsBlue,
              size: 14.sp,
            ),
          ),
        ],
      ),
    );
  }

  Widget _generateBanners(List<EventModuleAttachments>? eventAttachments) {
    String banner = (eventAttachments ?? []).isEmpty
        ? ""
        : (eventAttachments?.first.fileUrl ?? "");
    return Container(
      height: 0.45.sw,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 12,
            spreadRadius: 0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.r),
        child: Stack(
          fit: StackFit.expand,
          children: [
            banner.isEmpty
                ? Container(
                    color: Colors.grey[100],
                    child: Center(
                      child: Image.asset(
                        ImageAssetsConstants.goParkingLogoJpg,
                        fit: BoxFit.contain,
                        width: 0.5.sw,
                      ),
                    ),
                  )
                : cacheImageBannerExploreOurProgram(
                    banner,
                    ImageAssetsConstants.goParkingLogoJpg,
                  ),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.3)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
