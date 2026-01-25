import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/constant/size_constants.dart';
import 'package:organization/common/widgets/text_input.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/app_util_constants.dart';
import '../../controller/join_club_controller.dart';

class PageFourScreen extends StatelessWidget {
  late JoinClubController mJoinClubController = Get.find();

  PageFourScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: FocusDetector(
        onVisibilityGained: () {
          mJoinClubController.mAmountController.value.text =
              "RM ${mJoinClubController.mClubsMembership.value.membershipPackageAmount ?? ""}";
        },
        onVisibilityLost: () {
          mJoinClubController.mAmountController.value.text = "";
        },
        child: Container(
          height: SizeConstants.height * 0.85,
          width: SizeConstants.width,
          padding: EdgeInsets.all(SizeConstants.s1 * 13),
          margin: EdgeInsets.fromLTRB(
            SizeConstants.s1 * 13,
            SizeConstants.s1 * 13,
            SizeConstants.s1 * 13,
            SizeConstants.s1 * 13,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(SizeConstants.s1 * 10),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.4),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: pageFourView(),
        ),
      ),
    );
  }

  pageFourView() {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Payment Details",
                style: getTextSemiBold(
                  colors: AppColors.cAppColorsBlue,
                  size: SizeConstants.s1 * 22,
                ),
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            getTextSpan(word: "Amount ", size: SizeConstants.s1 * 17),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mAmountController.value,
                errorText: null,
                textInputType: TextInputType.text,
                hintText: "",
                showFloatingLabel: false,
                isReadOnly: true,
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            ///Bank Name
            getTextSpan(word: "Bank Name ", size: SizeConstants.s1 * 17),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mBankNameController,
                errorText: null,
                textInputType: TextInputType.name,
                hintText: "",
                showFloatingLabel: false,
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                    RegExp(AppUtilConstants.patternStringAndSpace),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            ///Payment Date
            getTextSpan(word: "Payment Date ", size: SizeConstants.s1 * 17),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mPaymentDateController.value,
                errorText: null,
                textInputType: TextInputType.text,
                hintText: "",
                showFloatingLabel: false,
                suffixIcon: Icons.calendar_month,
                onClick: (value) {
                  mJoinClubController.getCalendar();
                },
                isReadOnly: true,
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            ///Payment Reference Number
            getTextSpan(
              word: "Payment Reference Number ",
              size: SizeConstants.s1 * 17,
            ),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller:
                    mJoinClubController.mPaymentReferenceNumberController,
                errorText: null,
                textInputType: TextInputType.text,
                hintText: "",
                showFloatingLabel: false,
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                    RegExp(AppUtilConstants.patternStringNumberSpace),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            ///Payment Receipt
            getTextSpan(word: "Payment Receipt ", size: SizeConstants.s1 * 17),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              height: SizeConstants.s1 * 57,
              width: SizeConstants.s1 * 200,
              child: TextInputWidget(
                placeHolder: "Upload File",
                controller: mJoinClubController.mPaymentReceiptController.value,
                errorText: null,
                textInputType: TextInputType.text,
                hintText: "Upload File",
                showFloatingLabel: false,
                suffixIcon: Icons.upload_outlined,
                onClick: (value) {
                  mJoinClubController.getUploadFile();
                },
                isReadOnly: true,
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 40),

            ///button
            Row(
              mainAxisAlignment: mJoinClubController.showMemberDetailsNext.value
                  ? MainAxisAlignment.spaceBetween
                  : MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: SizeConstants.s1 * 55,
                  width: SizeConstants.width * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                  ),
                  child: rectangleRoundedCornerSemiBoldButton(
                    "BACK",
                    () {
                      mJoinClubController.pageController.jumpToPage(2);
                    },
                    buttonColors: AppColors.cAppColors,
                    textColors: Colors.white,
                  ),
                ),
                Container(
                  height: SizeConstants.s1 * 55,
                  width: SizeConstants.width * 0.4,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                  ),
                  child: rectangleRoundedCornerSemiBoldButton(
                    "SUBMIT",
                    () {
                      mJoinClubController.submit();
                    },
                    buttonColors: AppColors.cAppColors,
                    textColors: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}

rectangleRoundedCornerSemiBoldButton(
  String sTitle,
  Function onClick, {
  Color textColors = AppColors.cAppColors,
  Color buttonColors = AppColors.cAppColors,
  IconData? mIconData,
}) {
  return GestureDetector(
    onTap: () {
      onClick();
    },
    child: Container(
      // width: SizeConstants.width * 0.55,
      // height: SizeConstants.s1 *45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(SizeConstants.s1 * 10),
        color: buttonColors,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          mIconData != null
              ? SizedBox(
                  // margin: EdgeInsets.only(right: SizeConstants.s1 * 10),
                  height: SizeConstants.s1 * 35,
                  width: SizeConstants.s1 * 26,
                  child: Icon(
                    mIconData,
                    color: textColors,
                    size: SizeConstants.s1 * 35,
                  ),
                )
              : SizedBox(),
          Text(
            sTitle,
            style: getTextSemiBold(
              size: SizeConstants.s1 * 17,
              colors: textColors,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
