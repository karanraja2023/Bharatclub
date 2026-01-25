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
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/cms_page/event_response.dart';
import '../controller/event_details_one_controller.dart';
import 'package:organization/app_theme/theme/app_theme.dart';

class EventDetailsOneScreen extends GetView<EventDetailsOneController> {
  final EventModule mEventModule;

  const EventDetailsOneScreen({super.key, required this.mEventModule});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EventDetailsOneController(mEventModule));

    return FocusDetector(
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: CustomAppBar(title: 'Event Details'),
        body: Container(
          height: 0.85.sh,
          width: 1.sw,
          margin: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.cAppColorsBlue.withOpacity(0.08),
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

  Widget eventDetailsView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner
            _generateBanners(mEventModule.eventAttachments),
            SizedBox(height: 24.h),

            // Title
            Text(
              controller.mTitle.value,
              style: getTextBold(colors: AppColors.cAppColorsBlue, size: 22.sp),
            ),

            SizedBox(height: 16.h),

            // Description
            Text(
              controller.mDescription.value,
              style: getTextRegular(
                colors: AppColors.cAppColorsBlue,
                size: 15.sp,
                heights: 1.5,
              ),
            ),

            SizedBox(height: 24.h),

            // Event Schedule Card
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.cAppColorsBlue.withOpacity(0.1),
                    AppColors.cAppColorsBlue.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: AppColors.cAppColorsBlue.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 18.sp,
                        color: AppColors.cAppColorsBlue,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "Event Schedule",
                        style: getTextSemiBold(
                          colors: AppColors.cAppColorsBlue,
                          size: 16.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "From",
                              style: getTextMedium(
                                colors: Colors.grey[600]!,
                                size: 13.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              controller.mStartDate.value,
                              style: getTextSemiBold(
                                colors: AppColors.cAppColorsBlue,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 1,
                        color: AppColors.cAppColorsBlue.withOpacity(0.3),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "To",
                              style: getTextMedium(
                                colors: Colors.grey[600]!,
                                size: 13.sp,
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              controller.mEndDate.value,
                              style: getTextSemiBold(
                                colors: AppColors.cAppColorsBlue,
                                size: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // Sponsors
            sponsorCarousel(context),

            SizedBox(height: 32.h),

            // Primary Contact
            _buildSectionHeader("Primary Contact", Icons.person),
            SizedBox(height: 16.h),
            Text(
              "Primary Name",
              style: getTextMedium(colors: Colors.grey[700]!, size: 14.sp),
            ),
            SizedBox(height: 8.h),
            TextInputWidget(
              placeHolder: "",
              controller: controller.mPrimaryNameController.value,
              errorText: null,
              textInputType: TextInputType.text,
              hintText: "",
              showFloatingLabel: false,
              isReadOnly: true,
            ),

            SizedBox(height: 32.h),

            // Adult Details
            _buildSectionHeader("Adult Details", Icons.people),
            SizedBox(height: 16.h),
            Text(
              "Number of Adults (Age ${controller.mMemberAdultAge.value} and above)",
              style: getTextMedium(colors: Colors.grey[700]!, size: 14.sp),
            ),
            SizedBox(height: 8.h),
            TextInputWidget(
              placeHolder: "",
              controller: controller.mNumberOfAdultsController.value,
              errorText: null,
              textInputType: TextInputType.number,
              hintText: "Enter number of adults",
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

            // Children (Conditional)
            if (controller.mMemberChildStatus.value == '1') ...[
              SizedBox(height: 32.h),
              _buildSectionHeader("Children Details", Icons.child_care),
              SizedBox(height: 16.h),
              Text(
                "Number of Children (Age ${controller.mMemberChildAge.value} and above)",
                style: getTextMedium(colors: Colors.grey[700]!, size: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextInputWidget(
                placeHolder: "",
                controller:
                    controller.mNumberOfChildrenAgeLimitController.value,
                errorText: null,
                textInputType: TextInputType.number,
                hintText: "Enter number of children",
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
              SizedBox(height: 16.h),
              Text(
                "Number of Children (Age 6 and below)",
                style: getTextMedium(colors: Colors.grey[700]!, size: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextInputWidget(
                placeHolder: "",
                controller:
                    controller.mNumberOfChildrenAge6BelowController.value,
                errorText: null,
                textInputType: TextInputType.number,
                hintText: "Enter number of children",
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

            SizedBox(height: 32.h),
            _buildSectionHeader("Guest Details", Icons.group_add),
            SizedBox(height: 16.h),
            Text(
              "Number of Adults (Age ${controller.mGuestAdultAge.value} and above)",
              style: getTextMedium(colors: Colors.grey[700]!, size: 14.sp),
            ),
            SizedBox(height: 8.h),
            TextInputWidget(
              placeHolder: "",
              controller: controller.mNumberOfGuestAdultsController.value,
              errorText: null,
              textInputType: TextInputType.number,
              hintText: "Enter number of guest adults",
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

            if (controller.mGuestChildStatus == '1') ...[
              SizedBox(height: 16.h),
              Text(
                "Number of Children (Age ${controller.mGuestChildAge.value} and above)",
                style: getTextMedium(colors: Colors.grey[700]!, size: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextInputWidget(
                placeHolder: "",
                controller:
                    controller.mNumberOfGuestChildrenAge12AboveController.value,
                errorText: null,
                textInputType: TextInputType.number,
                hintText: "Enter number of guest children",
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
              SizedBox(height: 16.h),
              Text(
                "Number of Children (Age 6 and below)",
                style: getTextMedium(colors: Colors.grey[700]!, size: 14.sp),
              ),
              SizedBox(height: 8.h),
              TextInputWidget(
                placeHolder: "",
                controller:
                    controller.mNumberOfGuestChildrenAge6BelowController.value,
                errorText: null,
                textInputType: TextInputType.number,
                hintText: "Enter number of guest children",
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

            SizedBox(height: 40.h),
            InkWell(
              onTap: () async {
                await SharedPrefs().getUserDetails();
                controller.navigateToNextScreen(mEventModule, context);
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: 56.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.cAppColorsBlue,
                      AppColors.cAppColorsBlue.withOpacity(0.8),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.cAppColorsBlue.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
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
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.cAppColorsBlue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(icon, size: 20.sp, color: AppColors.cAppColorsBlue),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: getTextBold(colors: AppColors.cAppColorsBlue, size: 18.sp),
        ),
      ],
    );
  }

  Widget _generateBanners(List<EventModuleAttachments>? eventAttachments) {
    String banner = (eventAttachments ?? []).isEmpty
        ? ""
        : (eventAttachments?.first.fileUrl ?? "");
    return Container(
      height: 0.5.sw,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16.r),
        child: banner.isEmpty
            ? Container(
                color: Colors.grey[100],
                child: Center(
                  child: Image.asset(
                    ImageAssetsConstants.goParkingLogoJpg,
                    width: 0.4.sw,
                    fit: BoxFit.contain,
                  ),
                ),
              )
            : cacheImageBannerExploreOurProgram(
                banner,
                ImageAssetsConstants.goParkingLogoJpg,
              ),
      ),
    );
  }

  Widget sponsorCarousel(BuildContext context) {
    final PageController pageController = PageController();
    controller.startTimer(pageController);

    return Obx(() {
      if (controller.sponsorList.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader("Our Sponsors", Icons.business),
          SizedBox(height: 16.h),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.6,
            child: PageView.builder(
              controller: pageController,
              itemCount: controller.sponsorList.length,
              onPageChanged: (index) {
                controller.currentIndex.value = index;
              },
              itemBuilder: (context, index) {
                final sponsor = controller.sponsorList[index];
                return GestureDetector(
                  onTap: () {
                    if (sponsor.website != null &&
                        sponsor.website!.isNotEmpty) {
                      final uri = Uri.parse(sponsor.website!);
                      launchUrl(uri);
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.cAppColorsBlue.withOpacity(0.15),
                          blurRadius: 15,
                          spreadRadius: 2,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          cacheImageBannerExploreOurProgram(
                            sponsor.fileUrl,
                            ImageAssetsConstants.goParkingLogoJpg,
                          ),
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 12.h,
                                horizontal: 16.w,
                              ),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.8),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: Text(
                                sponsor.companyName,
                                style: getTextBold(
                                  colors: Colors.white,
                                  size: 16.sp,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              controller.sponsorList.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                width: controller.currentIndex.value == index ? 24.w : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                  color: controller.currentIndex.value == index
                      ? AppColors.cAppColorsBlue
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
