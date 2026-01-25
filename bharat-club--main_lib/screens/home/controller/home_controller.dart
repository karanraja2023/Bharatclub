import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/utils/app_text.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/banner_list/banner_list.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/data/mode/registration/registration_response.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../alert/app_alert.dart';
import '../../../../data/remote/web_response.dart';
import '../../../data/mode/cms_page/event_response.dart';
import '../../../data/mode/dashboard/dashboard_response.dart';
import '../../../data/mode/event_qr_scan/qr_details_request.dart';
import '../../../data/mode/event_qr_scan/qr_details_response.dart';
import '../../../data/mode/membership_type/membership_type_response.dart';
import '../../../data/mode/profile_response/profile_response.dart';
import '../../../data/remote/api_call/api_impl.dart';

class HomeController extends GetxController {
  late Timer _timer;

  PageController pageViewController = PageController(initialPage: 0);
  int _currentPage = 0;
  final _kDuration = const Duration(milliseconds: 350);
  final _kCurve = Curves.easeIn;
  RxInt currentSponsorIndex = 0.obs;

  final PageController certificationsPageController = PageController(
    initialPage: 0,
  );

  RxList mDashboardEventList = [].obs;
  RxList mDashboardGalleryList = [].obs;
  var beloBanner = 0.obs;
  RxList mDashboardBeloBannerList = [].obs;
  RxBool membershipStatus = false.obs;
  RxBool membershipExpired = false.obs;
  RxBool isLoading = true.obs; // NEW: Track loading state
  RxString membershipEndDate = "".obs;
  RxString photo = "".obs;
  RxString membershipType = "".obs;
  RxString membershipId = "".obs;
  RxString userName = "".obs;
  RxString spouseName = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    try {
      if (_timer.isActive) {
        _timer.cancel();
      }
    } catch (e) {}
    super.dispose();
  }

  void isTimerSt() {
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (mDashboardBeloBannerList.isNotEmpty) {
        if (pageViewController.hasClients) {
          if (_currentPage < mDashboardBeloBannerList.length - 1) {
            _currentPage++;
          } else {
            _currentPage = 0;
          }
          pageViewController.animateToPage(
            _currentPage,
            duration: _kDuration,
            curve: _kCurve,
          );
        }
      }
    });
  }

  void stopTimer() {
    if (_timer.isActive) {
      _currentPage = 0;
      _timer.cancel();
    }
  }

  void onPageViewChange(int page) {
    _currentPage = page;
  }

  membershipTypeLoad() async {
    isLoading.value = true; // Start loading
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postMembershipType();
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          MembershipTypeResponse mMembershipTypeResponse =
              mWebResponseSuccess.data;
          if (mMembershipTypeResponse.statusCode ==
              WebConstants.statusCode200) {
            await SharedPrefs().setMembershipTypeAll(
              jsonEncode(mMembershipTypeResponse.data),
            );

            await getProfile();
            await getDashboard();
            await getBannerList();
          }
        }
        isLoading.value = false; // Stop loading
      } else {
        isLoading.value = false; // Stop loading
        AppAlert.showSnackBar(
          Get.context!,
          MessageConstants.noInternetConnection,
        );
      }
    });
  }

  getDashboard() async {
    WebResponseSuccess mWebResponseSuccess = await AllApiImpl().postDashboard();
    if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
      DashboardResponse mDashboardResponse = mWebResponseSuccess.data;

      mDashboardEventList.clear();
      mDashboardEventList.addAll(mDashboardResponse.data?.eventList ?? []);
      mDashboardGalleryList.clear();
      mDashboardGalleryList.addAll(mDashboardResponse.data?.galleryList ?? []);
    }
  }

  getBannerList() async {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postBannerList();
        BannerListResponse mBannerListResponse = mWebResponseSuccess.data;
        mDashboardBeloBannerList.clear();
        beloBanner.value = 0;
        if (mBannerListResponse.statusCode == 200) {
          mDashboardBeloBannerList.addAll(
            mBannerListResponse.data?.banner ?? [],
          );
          beloBanner.value = mDashboardBeloBannerList.length;

          if (mDashboardBeloBannerList.length > 1) {
            isTimerSt();
          }
        }
      } else {
        AppAlert.showSnackBar(
          Get.context!,
          MessageConstants.noInternetConnection,
        );
      }
    });
  }

  getProfile() async {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postProfile();
        ProfileResponse mProfileResponse = mWebResponseSuccess.data;
        List<MembershipTypeData> membershipList = await SharedPrefs()
            .getMembershipTypeAll();
        if (mProfileResponse.statusCode == WebConstants.statusCode400) {
          AppAlert.showSnackBar(Get.context!, "Token is Expired Please login");
          await SharedPrefs().setUserLoginStatus("0");
          await SharedPrefs().setUserToken("");
          await SharedPrefs().setUserDetails(jsonEncode(RegistrationUser()));
          Get.offNamed(AppRoutes.loginScreen);
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode200) {
          membershipEndDate.value =
              (mProfileResponse.data?.membershipEndDate ?? "").isEmpty
              ? ""
              : (mProfileResponse.data?.membershipEndDate ?? "");
          
          if (membershipEndDate.value.isEmpty) {
            membershipStatus.value = false;
            membershipExpired.value = true;
          } else {
            await SharedPrefs().setUserDetails(
              jsonEncode(mProfileResponse.data),
            );

            if (dateCompare(membershipEndDate.value)) {
              // Membership is active
              membershipExpired.value = false;
              photo.value =
                  (mProfileResponse.data?.userAttachments ?? []).isEmpty
                  ? ""
                  : (mProfileResponse.data?.userAttachments?.first.fileUrl ??
                        "");

              MembershipTypeData? matchingMembership = membershipList
                  .firstWhereOrNull(
                    (membership) =>
                        membership.id ==
                        mProfileResponse.data!.membershipTypeID,
                  );

              if (matchingMembership != null) {
                membershipType.value = matchingMembership.type ?? '';
              } else {
                membershipType.value = 'No Type';
              }
              userName.value = (mProfileResponse.data?.name ?? "");
              spouseName.value = (mProfileResponse.data?.pocFirstName ?? "");
              membershipId.value = (mProfileResponse.data?.membershipId ?? "");
              membershipStatus.value = true;
            } else {
              // Membership date has passed
              membershipStatus.value = false;
              membershipExpired.value = true;
            }
          }
        }
      } else {
        AppAlert.showSnackBar(
          Get.context!,
          MessageConstants.noInternetConnection,
        );
      }
    });
  }

  bool dateCompare(String endDate) {
    DateTime today = DateTime.now();
    String sToday =
        "${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}";
    DateTime dt1 = DateTime.parse(endDate);
    DateTime dt2 = DateTime.parse(sToday);
    if (dt1.compareTo(dt2) == 0) {
      return true;
    }
    if (dt1.compareTo(dt2) > 0) {
      return true;
    }

    return false;
  }

  void handleContactSupport() {
    AppAlert.showSnackBar(
      Get.context!,
      'Please contact: clubbharat@gmail.com',
    );
  }

  // Handle renew membership button
  void handleRenewMembership() {
    // Navigate to renewal page or show renewal options
    Get.toNamed(AppRoutes.membershipExpired);
  }

  checkEventAppliedStatus(EventModule mEventModule) async {
    RegistrationUser mRegistrationUser = await SharedPrefs().getUserDetails();
    String? mMembershipID = mRegistrationUser.membershipId ?? "";

    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        QrDetailsRequest mQrDetailsRequest = QrDetailsRequest(
          eventId: (mEventModule.id ?? 0).toString(),
          membershipId: mMembershipID,
        );

        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postQrDetails(mQrDetailsRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          QrDetailsResponse mQrDetailsResponse = mWebResponseSuccess.data;
          if (mQrDetailsResponse.statusCode == WebConstants.statusCode200) {
            bool isStatusPresent = false;

            if (mQrDetailsResponse.data?.response?.status != null) {
              isStatusPresent = mQrDetailsResponse.data!.response!.status == 1;
            }

            if (isStatusPresent) {
              QrDetailsRequest mQrDetails = QrDetailsRequest(
                eventId: mEventModule.id.toString(),
                membershipId: mMembershipID,
              );
              Get.toNamed(AppRoutes.qrScreen, arguments: mQrDetails);
            } else {
              Get.toNamed(
                AppRoutes.eventDetailOneScreen,
                arguments: mEventModule,
              );
            }
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              mQrDetailsResponse.statusMessage ?? "",
            );
          }
        }
      } else {
        AppAlert.showSnackBar(
          Get.context!,
          MessageConstants.noInternetConnection,
        );
      }
    });
  }

  void webView(String url) async {
    String formattedUrl = url.trim();
    if (!formattedUrl.startsWith('http://') &&
        !formattedUrl.startsWith('https://')) {
      formattedUrl = 'https://$formattedUrl';
    }
    final Uri uri = Uri.parse(formattedUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      AppAlert.showSnackBar(Get.context!, 'Could not launch $formattedUrl');
    }
  }

  void showAccessDeniedSnackbar() {
    AppAlert.showSnackBar(Get.context!, 'Access Denied',mColor: Colors.red);
    // Get.snackbar(
    //   'Access Denied',
    //   'You do not have permission to access the QR scanner.\nPlease contact: clubbharat@gmail.com',
    //   snackPosition: SnackPosition.TOP,
    //   backgroundColor: AppColors.error,
    //   colorText: Colors.white,
    //   icon: const Icon(Icons.block_rounded, color: Colors.white),
    //   duration: const Duration(seconds: 3),
    //   margin: const EdgeInsets.all(16),
    //   borderRadius: 12,
    //   isDismissible: true,
    //   dismissDirection: DismissDirection.horizontal,
    //   animationDuration: const Duration(milliseconds: 400),
    // );
  }

  void logout() async{
    final shouldLogout = await Get.dialog<bool>(
      Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(20.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  alpha: 0.15,
                ),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen
                      .withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.logout_rounded,
                  color: AppColors.primaryGreen,
                  size: 32.sp,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Confirm Logout',
                style: getTextBold(
                  colors: AppColors.black,
                  size: 20.sp,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'Are you sure you want to logout?\nYou will need to login again to access your account.',
                textAlign: TextAlign.center,
                style: getTextRegular(
                  colors: Colors.grey.shade600,
                  size: 14.sp,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                          width: 1.5,
                        ),
                        borderRadius:
                        BorderRadius.circular(12.r),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              Get.back(result: false),
                          borderRadius:
                          BorderRadius.circular(
                            12.r,
                          ),
                          child: Center(
                            child: Text(
                              'Cancel',
                              style: getTextSemiBold(
                                colors: Colors
                                    .grey
                                    .shade700,
                                size: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primaryGreen,
                            AppColors.secondaryGreen,
                          ],
                        ),
                        borderRadius:
                        BorderRadius.circular(12.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors
                                .primaryGreen
                                .withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () =>
                              Get.back(result: true),
                          borderRadius:
                          BorderRadius.circular(
                            12.r,
                          ),
                          child: Center(
                            child: Text(
                              'Logout',
                              style: getTextSemiBold(
                                colors: AppColors.white,
                                size: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    if (shouldLogout == true) {
      Get.dialog(
        Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: AppColors.primaryGreen,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Logging out...',
                  style: getTextSemiBold(
                    colors: AppColors.black,
                    size: 14.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        barrierDismissible: false,
      );

      await SharedPrefs().sharedPreferencesInstance();
      await SharedPrefs().logout();
      AppAlert.showSnackBar(Get.context!, "Account logged out successfully");

      // Get.snackbar(
      //   'Logged Out',
      //   "Account logged out successfully",
      //   snackPosition: SnackPosition.BOTTOM,
      // );

      Get.offAllNamed(AppRoutes.loginScreen);
    }
  }
}