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

class PageTwoScreen extends StatelessWidget {
  late JoinClubController mJoinClubController =
      mJoinClubController = Get.find();

  PageTwoScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
        body: FocusDetector(
            onVisibilityGained: () {
              mJoinClubController.getRegistrationUserDetails();
            },
            onVisibilityLost: () {},
            child: Container(
                height: SizeConstants.height * 0.85,
                width: SizeConstants.width,
                padding: EdgeInsets.all(SizeConstants.s1 * 13),
                margin: EdgeInsets.fromLTRB(
                    SizeConstants.s1 * 13,
                    SizeConstants.s1 * 13,
                    SizeConstants.s1 * 13,
                    SizeConstants.s1 * 13),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(SizeConstants.s1 * 10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 1), // changes position of shadow
                    ),
                  ],
                ),
                child: pageTwoView())));
  }

  pageTwoView() {
    return SingleChildScrollView(
      child: Obx(
        () {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Member Details",
                  style: getTextSemiBold(
                      colors: AppColors.cAppColorsBlue,
                      size: SizeConstants.s1 * 22),
                ),
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),

              ///Member Name
              getTextSpan(
                  word: "Primary Member Name ", size: SizeConstants.s1 * 17),
              SizedBox(
                height: SizeConstants.s1 * 5,
              ),
              SizedBox(
                // height: SizeConstants.s1 * 55,
                child: TextInputWidget(
                  placeHolder: "",
                  controller: mJoinClubController.mMemberNameController.value,
                  errorText: null,
                  textInputType: TextInputType.name,
                  hintText: "",
                  showFloatingLabel: false,
                  isReadOnly:true ,
                  onFilteringTextInputFormatter:
                      [FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternStringAndSpace))],
                ),
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),

              ///Company Name
              getTextSpan(word: "Company Name ", size: SizeConstants.s1 * 17),
              SizedBox(
                height: SizeConstants.s1 * 5,
              ),
              SizedBox(
                // height: SizeConstants.s1 * 55,
                child: TextInputWidget(
                  placeHolder: "",
                  controller: mJoinClubController.mCompanyNameController,
                  errorText: null,
                  textInputType: TextInputType.name,
                  hintText: "",
                  showFloatingLabel: false,
                  onFilteringTextInputFormatter:
                      [FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternStringAndSpace))],
                ),
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),

              ///Mobile Phone Number
              getTextSpan(
                  word: "Mobile Phone Number ", size: SizeConstants.s1 * 17),
              SizedBox(
                height: SizeConstants.s1 * 5,
              ),
              SizedBox(
                // height: SizeConstants.s1 * 55,
                child: TextInputWidget(
                  placeHolder: "",
                  controller: mJoinClubController.mMobilePhoneController.value,
                  isReadOnly:true ,
                  errorText: null,
                  textInputType: TextInputType.phone,
                  hintText: "",
                  showFloatingLabel: false,
                  maxCharLength: 11,
                  onFilteringTextInputFormatter:
                      [FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternOnlyNumber))],
                ),
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),

              ///Citizenship/Visa status & Passport/IC number: Member
              getTextSpan(
                  word: "Citizenship/Visa status & Passport/IC number: Member",
                  size: SizeConstants.s1 * 17),
              SizedBox(
                height: SizeConstants.s1 * 5,
              ),
              SizedBox(
                // height: SizeConstants.s1 * 55,
                child: TextInputWidget(
                    placeHolder: "",
                    controller: mJoinClubController.mMemberPassportController,
                    errorText: null,
                    textInputType: TextInputType.text,
                    hintText: "",
                    showFloatingLabel: false,
                    onFilteringTextInputFormatter:
                        [FilteringTextInputFormatter.allow(
                            RegExp(AppUtilConstants.patternStringNumberSpace))]),
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),

              ///E-Mail
              getTextSpan(word: "E-Mail ", size: SizeConstants.s1 * 17),
              SizedBox(
                height: SizeConstants.s1 * 5,
              ),
              SizedBox(
                // height: SizeConstants.s1 * 55,
                child: TextInputWidget(
                  placeHolder: "",
                  controller: mJoinClubController.mEmailController.value,
                  isReadOnly:true ,
                  errorText: null,
                  textInputType: TextInputType.emailAddress,
                  hintText: "",
                  showFloatingLabel: false,
                  onFilteringTextInputFormatter:
                      [FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternEmailStringAtDot))],
                ),
              ),
              SizedBox(
                height: SizeConstants.s1 * 15,
              ),

              ///Address
              getTextSpan(
                  word: "Residence Address (Local) ",
                  size: SizeConstants.s1 * 17),
              SizedBox(
                height: SizeConstants.s1 * 5,
              ),
              SizedBox(
                // height: SizeConstants.s1 * 55,
                child: TextInputWidget(
                  placeHolder: "",
                  controller: mJoinClubController.mAddressController,
                  errorText: null,
                  textInputType: TextInputType.emailAddress,
                  hintText: "",
                  showFloatingLabel: false,
                  onFilteringTextInputFormatter:
                      [FilteringTextInputFormatter.allow(
                          RegExp(AppUtilConstants.patternAddress))],
                ),
              ),
              SizedBox(
                height: SizeConstants.s1 * 40,
              ),
              Row(
                mainAxisAlignment:
                    mJoinClubController.showMemberDetailsNext.value
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: SizeConstants.s1 * 55,
                      width: SizeConstants.width * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 5),
                      ),
                      child: rectangleRoundedCornerSemiBoldButton("BACK", () {
                        mJoinClubController.pageController.jumpToPage(0);
                      },
                          buttonColors: AppColors.cAppColors,
                          textColors: Colors.white)),
                  Container(
                      height: SizeConstants.s1 * 55,
                      width: SizeConstants.width * 0.4,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(SizeConstants.s1 * 5),
                      ),
                      child: rectangleRoundedCornerSemiBoldButton("NEXT", () {
                        mJoinClubController.isMemberDetailsCheck();
                      },
                          buttonColors: AppColors.cAppColors,
                          textColors: Colors.white)),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
