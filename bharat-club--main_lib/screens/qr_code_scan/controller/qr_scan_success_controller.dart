import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';
import '../../../alert/app_alert.dart';
import '../../../data/mode/event_attendance/event_attendance_request.dart';
import '../../../data/mode/event_attendance/event_attendance_response.dart';
import '../../../data/mode/event_qr_scan/qr_details_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';

class QrScanSuccessController extends GetxController {
  final QrDetailsResponseDetails mqQrDetailResponse;

  QrScanSuccessController(this.mqQrDetailResponse) {
    _initializeData();
  }
  RxString participantName = ''.obs;
  RxInt memberNoOfAdults = 0.obs;
  RxInt memberNoOfChild = 0.obs;
  RxString eventName = ''.obs;
  RxInt memberNoOfChildFree = 0.obs;
  RxInt guestNoOfAdults = 0.obs;
  RxInt guestNoOfChild = 0.obs;
  RxInt guestNoOfChildFree = 0.obs;
  RxInt status = 0.obs;
  RxString memberShipID = ''.obs;
  RxString eventID = ''.obs;

  TextEditingController adultAttendedController = TextEditingController(
    text: "0",
  );
  TextEditingController childAttendedController = TextEditingController(
    text: "0",
  );
  TextEditingController guestAttendedController = TextEditingController(
    text: "0",
  );
  TextEditingController guestChildAttendedController = TextEditingController(
    text: "0",
  );
  TextEditingController remarksController = TextEditingController();
  RxInt memberChildStatus = 0.obs;
  RxInt guestChildStatus = 0.obs;

  @override
  void onInit() {
    super.onInit();

    // Sync initial values of controllers with reactive variables
    adultAttendedController.text = memberNoOfAdults.value.toString();
    childAttendedController.text = memberNoOfChild.value.toString();
    guestAttendedController.text = guestNoOfAdults.value.toString();
    guestChildAttendedController.text = guestNoOfChild.value.toString();
  }

  @override
  void onClose() {
    // Dispose controllers to free memory
    adultAttendedController.dispose();
    childAttendedController.dispose();
    guestAttendedController.dispose();
    guestChildAttendedController.dispose();
    super.onClose();
  }

  void _initializeData() {
    participantName.value = mqQrDetailResponse.participantName ?? '';
    memberNoOfAdults.value = mqQrDetailResponse.memberNoOfAdults ?? 0;
    memberNoOfChild.value = mqQrDetailResponse.memberNoOfChild ?? 0;
    memberNoOfChildFree.value = mqQrDetailResponse.memberNoOfChildFree ?? 0;
    guestNoOfAdults.value = mqQrDetailResponse.guestNoOfAdults ?? 0;
    guestNoOfChild.value = mqQrDetailResponse.guestNoOfChild ?? 0;
    guestNoOfChildFree.value = mqQrDetailResponse.guestNoOfChildFree ?? 0;
    status.value = mqQrDetailResponse.status ?? 0;
    memberShipID.value = mqQrDetailResponse.membershipID ?? '';
    eventID.value = mqQrDetailResponse.eventID?.toString() ?? '';
    eventName.value = mqQrDetailResponse.eventName ?? '';
    print('mqQrDetailResponse.eventID init ${mqQrDetailResponse.eventID}');
    print('memberShipID.value init  ${memberShipID.value}');
    print('eventName init ${eventName.value}');
    memberChildStatus.value = mqQrDetailResponse.memberChildStatus ?? 0;
    guestChildStatus.value = mqQrDetailResponse.guestChildStatus ?? 0;
  }

  void validateAndSubmitAttendance() {
    try {
      int.parse(adultAttendedController.text.trim());
      int.parse(childAttendedController.text.trim());
      int.parse(guestAttendedController.text.trim());
      int.parse(guestChildAttendedController.text.trim());

      addentanceSubmitApi();
    } catch (e) {
      AppAlert.showCustomDismissDialog(
        Get.context!,
        "Invalid input. Please enter numeric values only.",
      );
    }
  }

  addentanceSubmitApi() async {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        EventAttendanceRequest mEventAttendanceRequest = EventAttendanceRequest(
          eventId: eventID.value,
          membershipId: memberShipID.value,
          adultAttend: int.tryParse(adultAttendedController.text) ?? 0,
          childAttend: int.tryParse(childAttendedController.text) ?? 0,
          guestAttend: int.tryParse(guestAttendedController.text) ?? 0,
          guestChildAttend:
              int.tryParse(guestChildAttendedController.text) ?? 0,
          remarks: remarksController.text,
        );

        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postEventAttendance(mEventAttendanceRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          EventAttendanceResponse mEventAttendanceResponse =
              mWebResponseSuccess.data;
          if (mEventAttendanceResponse.statusCode ==
              WebConstants.statusCode200) {
            Get.delete<QrScanSuccessController>();
            Get.offAllNamed(AppRoutes.home);
            AppAlert.showSnackBar(
              Get.context!,
              mEventAttendanceResponse.data?.message ?? "",
            );
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              mEventAttendanceResponse.statusMessage ?? "",
            );
          }
        } else {
          EventAttendanceResponse mEventAttendanceResponse =
              mWebResponseSuccess.data;
          if (mEventAttendanceResponse.statusCode ==
              WebConstants.statusCode200) {
            AppAlert.showSnackBar(
              Get.context!,
              mEventAttendanceResponse.data?.message ?? "",
            );
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              mEventAttendanceResponse.statusMessage ?? "",
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
}
