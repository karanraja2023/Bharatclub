import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/constant/size_constants.dart';
import 'package:organization/common/widgets/text_input.dart';
import 'package:organization/screens/join_club/view/page_view/page_four_screen.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/app_util_constants.dart';
import '../../controller/join_club_controller.dart';

class PageThreeScreen extends StatelessWidget {
  late JoinClubController mJoinClubController = mJoinClubController =
      Get.find();

  PageThreeScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body: FocusDetector(
        onVisibilityGained: () {},
        onVisibilityLost: () {},
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
          child: pageThreeView(),
        ),
      ),
    );
  }

  pageThreeView() {
    return SingleChildScrollView(
      child: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                "Spouse Details",
                style: getTextSemiBold(
                  colors: AppColors.cAppColorsBlue,
                  size: SizeConstants.s1 * 22,
                ),
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            ///Spouse’s Name
            getTextSpan(
              word: "Spouse’s Name ",
              size: SizeConstants.s1 * 17,
              bStare: false,
            ),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mSpouseNameController,
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

            ///Mobile Phone Number
            getTextSpan(
              word: "Mobile Phone Number ",
              size: SizeConstants.s1 * 17,
              bStare: false,
            ),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mSpouseMobilePhoneController,
                errorText: null,
                textInputType: TextInputType.phone,
                hintText: "",
                showFloatingLabel: false,
                maxCharLength: 11,
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                    RegExp(AppUtilConstants.patternOnlyNumber),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            ///E-Mail
            getTextSpan(
              word: "E-Mail ",
              size: SizeConstants.s1 * 17,
              bStare: false,
            ),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mSpouseEmailController,
                errorText: null,
                textInputType: TextInputType.emailAddress,
                hintText: "",
                showFloatingLabel: false,
                onFilteringTextInputFormatter: [
                  FilteringTextInputFormatter.allow(
                    RegExp(AppUtilConstants.patternEmailStringAtDot),
                  ),
                ],
              ),
            ),
            SizedBox(height: SizeConstants.s1 * 15),

            ///Citizenship/Visa status & Passport/IC number: Spouse
            getTextSpan(
              word: "Citizenship/Visa status & Passport/IC number: Spouse",
              size: SizeConstants.s1 * 17,
              bStare: false,
            ),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mSpousePassportController,
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

            ///Children Details (Name / Age)
            getTextSpan(
              word: "Children Details (Name / Age)",
              size: SizeConstants.s1 * 17,
              bStare: false,
            ),
            SizedBox(height: SizeConstants.s1 * 5),
            SizedBox(
              // height: SizeConstants.s1 * 55,
              child: TextInputWidget(
                placeHolder: "",
                controller: mJoinClubController.mChildrenDetailsController,
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

            ///button
            SizedBox(height: SizeConstants.s1 * 25),
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
                      mJoinClubController.pageController.jumpToPage(1);
                    },
                    buttonColors: AppColors.cAppColors,
                    textColors: Colors.white,
                  ),
                ),
                Visibility(
                  visible: true,
                  child: Container(
                    height: SizeConstants.s1 * 55,
                    width: SizeConstants.width * 0.4,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(SizeConstants.s1 * 5),
                    ),
                    child: rectangleRoundedCornerSemiBoldButton(
                      "NEXT",
                      () {
                        mJoinClubController.isSpouseDetailsCheck();
                      },
                      buttonColors: AppColors.cAppColors,
                      textColors: Colors.white,
                    ),
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
