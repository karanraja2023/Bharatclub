import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/routes_name.dart';
import 'package:mobileapp/common/constant/web_constant.dart';

import '../../../../data/remote/web_response.dart';
import '../../../alert/app_alert.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/cms_page/cms_page_request.dart';
import '../../../data/mode/cms_page/event_response.dart';
import '../../../data/mode/event_qr_scan/qr_details_request.dart';
import '../../../data/mode/event_qr_scan/qr_details_response.dart';
import '../../../data/mode/registration/registration_response.dart';
import '../../../data/remote/api_call/api_impl.dart';

class EventController extends GetxController {
  /// Reactive states
  var intEventCount = 0.obs;
  var sEventBannerImage = "".obs;
  var sEventTitle = "".obs;
  var sEventDec = "".obs;
  RxList<EventModule> mEventList = <EventModule>[].obs;

  /// New states
  var hasLoadedOnce = false.obs;
  var isLoading = false.obs;
  var isCheckingEvent = false.obs;

  /// Check if event is applied for this member
  Future<void> checkEventAppliedStatus(EventModule mEventModule) async {
    debugPrint("🔍 Starting event check for: ${mEventModule.title}");

    // Prevent multiple simultaneous calls
    if (isCheckingEvent.value) {
      debugPrint("⚠️ Already checking event status, ignoring duplicate call");
      return;
    }

    final BuildContext? context = Get.context;
    if (context == null || !context.mounted) {
      debugPrint("❌ Context is null or not mounted");
      return;
    }

    try {
      isCheckingEvent.value = true;
      debugPrint("✅ Starting event status check");
      debugPrint("📋 Fetching user details...");
      RegistrationUser? mRegistrationUser;

      try {
        mRegistrationUser = await SharedPrefs().getUserDetails().timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            throw TimeoutException('Failed to load user details');
          },
        );
        debugPrint("✅ User details fetched");
      } catch (e) {
        debugPrint("❌ Error fetching user details: $e");
        if (context.mounted) {
          AppAlert.showSnackBar(
            context,
            "Error loading user details. Please login again.",
          );
        }
        return;
      }

      String? mMembershipID = mRegistrationUser.membershipId ?? "";

      if (mMembershipID.isEmpty) {
        debugPrint("⚠️ Membership ID is empty");
        if (context.mounted) {
          AppAlert.showSnackBar(
            context,
            "Membership ID not found. Please login again.",
          );
        }
        return;
      }

      debugPrint("👤 Member ID: $mMembershipID");
      debugPrint("🎫 Event ID: ${mEventModule.id}");
      QrDetailsRequest mQrDetailsRequest = QrDetailsRequest(
        eventId: (mEventModule.id ?? 0).toString(),
        membershipId: mMembershipID,
      );

      debugPrint("📡 Calling API...");

      WebResponseSuccess mWebResponseSuccess;
      try {
        mWebResponseSuccess = await AllApiImpl()
            .postQrDetails(mQrDetailsRequest)
            .timeout(
              const Duration(seconds: 30),
              onTimeout: () {
                throw TimeoutException('API request timed out');
              },
            );
      } catch (e) {
        debugPrint("❌ API call error: $e");
        if (context.mounted) {
          AppAlert.showSnackBar(
            context,
            "Failed to connect to server. Please try again.",
          );
        }
        return;
      }

      debugPrint("✅ API response received: ${mWebResponseSuccess.statusCode}");

      if (mWebResponseSuccess.statusCode != WebConstants.statusCode200) {
        debugPrint("⚠️ API returned non-200 status");
        if (context.mounted) {
          AppAlert.showSnackBar(
            context,
            "Failed to check event status. Please try again.",
          );
        }
        return;
      }

      QrDetailsResponse mQrDetailsResponse = mWebResponseSuccess.data;

      debugPrint("→ Response status code: ${mQrDetailsResponse.statusCode}");
      debugPrint("→ Response data: ${mQrDetailsResponse.data}");

      if (mQrDetailsResponse.statusCode != WebConstants.statusCode200) {
        debugPrint("⚠️ Response status code is not 200");
        if (context.mounted) {
          AppAlert.showSnackBar(
            context,
            mQrDetailsResponse.statusMessage ?? "Error checking event status",
          );
        }
        return;
      }

      // Check registration status
      bool isStatusPresent = false;
      final responseData = mQrDetailsResponse.data;

      debugPrint("→ Checking registration status...");
      debugPrint("→ response object: ${responseData?.response}");
      debugPrint("→ response.status: ${responseData?.response?.status}");
      debugPrint("→ responseBool: ${responseData?.responseBool}");

      if (responseData == null) {
        debugPrint("⚠️ Response data is null");
        isStatusPresent = false;
      }
      // Case 1: User IS registered - response object exists
      else if (responseData.response != null &&
          responseData.response!.status != null) {
        isStatusPresent = responseData.response!.status == 1;
        debugPrint(
          "→ User IS registered - status: ${responseData.response!.status}",
        );
      }
      // Case 2: User is NOT registered - check responseBool
      else if (responseData.responseBool != null) {
        isStatusPresent = responseData.responseBool == true;
        debugPrint("→ Checking responseBool: ${responseData.responseBool}");
      } else {
        debugPrint("⚠️ No valid response data found");
        isStatusPresent = false;
      }

      debugPrint("→ Final isStatusPresent: $isStatusPresent");

      // Check context before navigation
      if (!context.mounted) {
        debugPrint("❌ Context no longer mounted");
        return;
      }

      // Navigate based on status
      await Future.delayed(const Duration(milliseconds: 100));

      if (!context.mounted) {
        debugPrint("❌ Context unmounted after delay");
        return;
      }

      if (isStatusPresent) {
        debugPrint("✅ User already registered → QR Screen");
        QrDetailsRequest mQrDetails = QrDetailsRequest(
          eventId: mEventModule.id.toString(),
          membershipId: mMembershipID,
        );
        Get.toNamed(AppRoutes.qrScreen, arguments: mQrDetails);
      } else {
        debugPrint("❌ User not registered → Event Detail Screen");
        Get.toNamed(AppRoutes.eventDetailOneScreen, arguments: mEventModule);
      }
    } catch (e, stackTrace) {
      debugPrint("❌ Unexpected error: $e");
      debugPrint("Stack trace: $stackTrace");

      if (context.mounted) {
        AppAlert.showSnackBar(
          context,
          "Error checking event status: ${e.toString()}",
        );
      }
    } finally {
      isCheckingEvent.value = false;
      debugPrint("🏁 Event check completed");
    }
  }

  Future<void> getEventUsApi() async {
    try {
      isLoading.value = true;

      CmsPageRequest mCmsPageRequest = CmsPageRequest(
        name: CmsPageRequestType.EVENTS.name,
      );

      WebResponseSuccess mWebResponseSuccess = await AllApiImpl().postCmsPage(
        mCmsPageRequest,
      );

      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        EventResponse mEventResponse = mWebResponseSuccess.data;

        sEventTitle.value =
            mEventResponse.data?.title ??
            "Every year, the club organizes a variety of programs and activities that encourage maximum participation by the members, especially the children.";

        sEventDec.value = mEventResponse.data?.content ?? "";

        // Banner
        if ((mEventResponse.data?.cmsPageAttachments ?? []).isNotEmpty &&
            (mEventResponse.data?.cmsPageAttachments?.first.fileUrl ?? "")
                .isNotEmpty) {
          sEventBannerImage.value =
              mEventResponse.data!.cmsPageAttachments!.first.fileUrl!;
        }

        // Event list
        mEventList.clear();
        mEventList.addAll(mEventResponse.data?.module ?? []);
        intEventCount.value = mEventList.length;

        hasLoadedOnce.value = true;
      }
    } catch (e, stackTrace) {
      debugPrint("Error fetching event data: $e");
      debugPrint("Stack trace: $stackTrace");

      final context = Get.context;
      if (context != null && context.mounted) {
        AppAlert.showSnackBar(context, "Error loading events: ${e.toString()}");
      }
    } finally {
      isLoading.value = false;
    }
  }
}
