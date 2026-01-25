import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../alert/app_alert.dart';
import '../../../data/mode/event_qr_scan/qr_details_request.dart';
import '../../../data/mode/event_qr_scan/qr_details_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';

class QrCodeGenerateController extends GetxController {
  RxBool isLoading = false.obs;

  String encodeToBase64(String data) {
    return base64Encode(utf8.encode(data));
  }

  String decodeFromBase64(String base64Data) {
    return utf8.decode(base64Decode(base64Data));
  }

  verifyQrCode(
    String code,
    BuildContext context,
  ) async {
    String memberID = '';
    String eventID = '';

    if (isValidBase64(code)) {
      String decodedData = decodeFromBase64(code);

      if (!decodedData.startsWith("Bharat=")) {
        qrDialog(context);
      } else {
        isLoading.value = true;
        List<String> parts = decodedData.split(RegExp(r'[=&]'));

        memberID = parts[1];
        eventID = parts[2];

        AppAlert.showSnackBar(Get.context!, "QR code verified successfully!");
      }
    } else {
      qrDialog(context);
    }

    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        QrDetailsRequest mQrDetailsRequest = QrDetailsRequest(
          eventId: (eventID).toString(),
          membershipId: memberID,
        );

        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postQrDetails(mQrDetailsRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          isLoading.value = false;

          QrDetailsResponse mQrDetailsResponse = mWebResponseSuccess.data;
          if (mQrDetailsResponse.statusCode == WebConstants.statusCode200) {
            bool isStatusPresent = false;

            if (mQrDetailsResponse.data?.response?.status != null) {
              isStatusPresent = mQrDetailsResponse.data!.response!.status == 1;
            }

            if (isStatusPresent) {
              QrDetailsResponseDetails
              mqQrDetailResponse = QrDetailsResponseDetails(
                participantName:
                    mQrDetailsResponse.data?.response?.participantName ?? '',
                memberNoOfAdults:
                    mQrDetailsResponse.data?.response?.memberNoOfAdults ?? 0,
                memberNoOfChild:
                    mQrDetailsResponse.data?.response?.memberNoOfChild ?? 0,
                memberNoOfChildFree:
                    mQrDetailsResponse.data?.response?.memberNoOfChildFree ?? 0,
                guestNoOfAdults:
                    mQrDetailsResponse.data?.response?.guestNoOfAdults ?? 0,
                guestNoOfChild:
                    mQrDetailsResponse.data?.response?.guestNoOfChild ?? 0,
                guestNoOfChildFree:
                    mQrDetailsResponse.data?.response?.guestNoOfChildFree ?? 0,
                status: mQrDetailsResponse.data?.response?.status ?? 0,
                memberChildStatus:
                    mQrDetailsResponse.data?.response?.memberChildStatus ?? 0,
                guestChildStatus:
                    mQrDetailsResponse.data?.response?.guestChildStatus ?? 0,
              );

              mqQrDetailResponse.eventID = int.tryParse(eventID);
              mqQrDetailResponse.membershipID = memberID;
              Get.toNamed(
                AppRoutes.qrSuccessScreen,
                arguments: mqQrDetailResponse,
              );
            } else {
              qrDialognotregister(context);
            }
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              mQrDetailsResponse.statusMessage ?? "",
            );
          }
        } else {
          isLoading.value = false;
        }
      } else {
        AppAlert.showSnackBar(
          Get.context!,
          MessageConstants.noInternetConnection,
        );
      }
    });
  }

  bool isValidBase64(String data) {
    final base64RegExp = RegExp(r'^[A-Za-z0-9+/]+={0,2}$');

    if (data.isEmpty ||
        !base64RegExp.hasMatch(data) ||
        (data.length % 4 != 0)) {
      return false;
    }

    try {
      base64Decode(data);
      return true;
    } catch (e) {
      return false;
    }
  }

  qrDialog(BuildContext context) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wrong QR Code"),
          content: Text("Scan the correct QR code."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  qrDialognotregister(BuildContext context) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Wrong QR code"),
          content: Text("User not Registered for the event."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                // controller.resumeCamera();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  RxString qrCodePart = ''.obs;

  getUploadFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      // MobileScanner controller
      print("## ${image.path}");
      final barcode = await MobileScannerController().analyzeImage(image.path);

      if (barcode != null && barcode.barcodes.isNotEmpty) {
        String qrValue = barcode.barcodes.first.rawValue.toString();
        print("QR Code Value: $qrValue");
        verifyQrCode(qrValue,Get.context!);
      } else {
        print("No QR code found");
      }
    }
  }
}
