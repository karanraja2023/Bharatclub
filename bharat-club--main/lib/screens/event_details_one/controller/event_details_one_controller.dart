import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' hide Uint8List;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mobileapp/app/routes_name.dart';
import 'package:mobileapp/common/constant/web_constant.dart';
import 'package:mobileapp/common/widgets/snackbar.dart';
import 'package:mobileapp/utils/app_util.dart';
import 'package:mobileapp/utils/message_constants.dart';
import 'package:mobileapp/utils/network_util.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../alert/app_alert.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/cms_page/event_response.dart';
import '../../../data/mode/event_model/event_payment_submit_request.dart';
import '../../../data/mode/event_one_model/participant_submit_request.dart';
import '../../../data/mode/event_one_model/participant_submit_response.dart';
import '../../../data/mode/event_qr_scan/qr_details_request.dart';
import '../../../data/mode/membership_type/membership_type_response.dart';
import '../../../data/mode/registration/registration_response.dart';
import '../../../data/mode/sponsor_event/sponsor_event_attach_request.dart';
import '../../../data/mode/sponsor_event/sponsor_event_attach_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';

class EventDetailsOneController extends GetxController {
  final EventModule mEventModule;

  EventDetailsOneController(this.mEventModule) {
    _initializeUserDetails();

    mNumberOfAdultsController.value.text = "2";
    _initializeEventDetails();

    fetchSponsorDataApi();
  }

  final Rx<TextEditingController> mNameController = TextEditingController().obs;
  final Rx<TextEditingController> mEmailController =
      TextEditingController().obs;
  final Rx<TextEditingController> msNoOfPersonController =
      TextEditingController().obs;
  final Rx<TextEditingController> mMessageController =
      TextEditingController().obs;
  final Rx<TextEditingController> mPaymentReceiptController =
      TextEditingController().obs;
  final Rx<TextEditingController> mPrimaryNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> mSpouseNameController =
      TextEditingController().obs;
  final Rx<TextEditingController> mNumberOfAdultsController =
      TextEditingController().obs;
  final Rx<TextEditingController> mNumberOfChildrenAgeLimitController =
      TextEditingController().obs;
  final Rx<TextEditingController> mNumberOfChildrenAge6BelowController =
      TextEditingController().obs;
  final Rx<TextEditingController> mNumberOfGuestAdultsController =
      TextEditingController().obs;
  final Rx<TextEditingController> mNumberOfGuestChildrenAge12AboveController =
      TextEditingController().obs;
  final Rx<TextEditingController> mNumberOfGuestChildrenAge6BelowController =
      TextEditingController().obs;
  final Rx<TextEditingController> mVegetarianController =
      TextEditingController().obs;
  final Rx<TextEditingController> mNonVegetarianController =
      TextEditingController().obs;
  final Rx<TextEditingController> mJainController = TextEditingController().obs;

  //Sponsor
  final RxList<Sponsor> sponsorList = <Sponsor>[].obs;
  Timer? _timer;
  final currentIndex = 0.obs;

  void startTimer(PageController pageController) {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageController.hasClients) {
        if (currentIndex.value < sponsorList.length - 1) {
          currentIndex.value++;
        } else {
          currentIndex.value = 0;
        }
        pageController.animateToPage(
          currentIndex.value,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void onClose() {
    stopTimer();
    super.onClose();
  }

  //Event Details onload
  final RxString mTitle = ''.obs;
  final RxString mDescription = ''.obs;
  final RxString mStartDate = ''.obs;
  final RxString mEndDate = ''.obs;
  final RxString mMemberAdultAge = ''.obs;
  final RxString mMemberAdultAmount = ''.obs;
  final RxString mMemberChildStatus = ''.obs;
  final RxString mMemberChildAge = ''.obs;
  final RxString mMemberChildAmount = ''.obs;
  final RxString mGuestAdultAge = ''.obs;
  final RxString mGuestAdultAmount = ''.obs;
  final RxString mGuestChildStatus = ''.obs;
  final RxString mGuestChildAge = ''.obs;
  final RxString mGuestChildAmount = ''.obs;
  final RxString mFoodStatus = ''.obs;
  final RxString mSubscriptionStatus = ''.obs;
  final RxString mSubscriptionAmount = ''.obs;
  final RxString mUserMembershipType = ''.obs;
  final RxString mUserMembershipID = ''.obs;

  // Subscription-related variables
  var isMemberRenewal = false.obs;
  var isSubscriptionRenewalChecked = false.obs;

  var totalPaymentAmount = 0.00.obs;

  List<Map<String, dynamic>> memberships = [];

  var emailValidator = false.obs;
  RxString showPaymentMessage = ''.obs;

  void _initializeUserDetails() async {
    try {
      RegistrationUser mRegistrationUser = await SharedPrefs().getUserDetails();
      mPrimaryNameController.value.text = mRegistrationUser.name ?? "";
      mUserMembershipType.value = mRegistrationUser.membershipType ?? "";
      mEmailController.value.text = mRegistrationUser.email ?? "";
      mUserMembershipID.value = mRegistrationUser.membershipId ?? "";

      _membertypeapi(mUserMembershipType.value);
    } catch (e) {
      // Handle any errors
      print("Error fetching user details: $e");
    }
  }

  void _membertypeapi(String userMembershipType) async {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postMembershipType();
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          MembershipTypeResponse mMembershipType = mWebResponseSuccess.data;
          if (mMembershipType.statusCode == WebConstants.statusCode200) {
            if (mMembershipType.data != null) {
              memberships = mMembershipType.data!
                  .map((e) => e.toJson())
                  .toList();
            }

            for (var membership in memberships) {
              if (membership['type'] == userMembershipType &&
                  membership['renewal_status'] == 1) {
                isMemberRenewal.value = true;
                // return membership['subscription_amount'];
                mSubscriptionAmount.value = membership['subscription_amount'];
              } else if (userMembershipType == membership['type']) {
                isMemberRenewal.value = false;
                mSubscriptionAmount.value = membership['subscription_amount'];
              }
            }
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              mMembershipType.statusMessage ?? "",
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

  void fetchSponsorDataApi() async {
    // final request = SponsorEventAttachmentRequest(eventId: "12345").toJson();

    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        SponsorEventAttachmentRequest mSponsorEventAttachmentRequest =
            SponsorEventAttachmentRequest(
              eventId: (mEventModule.id ?? 0).toString(),
            );

        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postSponsorEvent(mSponsorEventAttachmentRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          SponsorEventAttachmentResponse mSponsorEventAttachmentResponse =
              mWebResponseSuccess.data;

          if (mSponsorEventAttachmentResponse.statusCode ==
              WebConstants.statusCode200) {
            sponsorList.assignAll(
              (mSponsorEventAttachmentResponse.data?.sponsor ?? [])
                  .map((e) => Sponsor.fromJson(e.toJson()))
                  .toList(),
            );
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              mSponsorEventAttachmentResponse.statusMessage,
            );
          }
        } else {
          SponsorEventAttachmentResponse mSponsorEventAttachmentResponse =
              mWebResponseSuccess.data;
          if (mSponsorEventAttachmentResponse.statusCode ==
              WebConstants.statusCode200) {
            // AppAlert.showSnackBar(
            //     Get.context!, mSponsorEventAttachmentResponse.data?.message ?? "");
          } else {
            // AppAlert.showSnackBar(
            //     Get.context!, mSponsorEventAttachmentResponse.statusMessage ?? "");
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

  void calculateTotalPaymentAmount() {
    int adults = int.tryParse(mNumberOfAdultsController.value.text) ?? 0;
    int children =
        int.tryParse(mNumberOfChildrenAgeLimitController.value.text) ?? 0;
    int guests = int.tryParse(mNumberOfGuestAdultsController.value.text) ?? 0;
    int guestsChildren =
        int.tryParse(mNumberOfGuestChildrenAge12AboveController.value.text) ??
        0;
    double subscriptionCharge = isSubscriptionRenewalChecked.value
        ? double.parse(
            (double.tryParse(mSubscriptionAmount.value) ?? 0.00)
                .toStringAsFixed(2),
          )
        : 0.00;

    double mMemberAdultAmountValue = double.parse(
      (double.tryParse(mMemberAdultAmount.value) ?? 0.00).toStringAsFixed(2),
    );
    double mMemberChildAmountValue = double.parse(
      (double.tryParse(mMemberChildAmount.value) ?? 0.00).toStringAsFixed(2),
    );
    double mGuestAdultAmountValue = double.parse(
      (double.tryParse(mGuestAdultAmount.value) ?? 0.00).toStringAsFixed(2),
    );
    double mGuestChildAmountValue = double.parse(
      (double.tryParse(mGuestChildAmount.value) ?? 0.00).toStringAsFixed(2),
    );

    // Then use the rounded values in the total calculation
    double total =
        (adults * mMemberAdultAmountValue) +
        (children * mMemberChildAmountValue) +
        (guests * mGuestAdultAmountValue) +
        (guestsChildren * mGuestChildAmountValue) +
        subscriptionCharge;

    totalPaymentAmount.value = double.parse(total.toStringAsFixed(2));
  }

  void isSubscriptionRenewalCheck(bool value) {
    isSubscriptionRenewalChecked.value = value;
    calculateTotalPaymentAmount();
  }

  // COMPLETE FIXED VERSION OF EventDetailsOneController

  void validateTotalPax() {
    // Calculate total number of participants
    int totalParticipants =
        (int.tryParse(mNumberOfAdultsController.value.text) ?? 0) +
        (int.tryParse(mNumberOfChildrenAgeLimitController.value.text) ?? 0) +
        (int.tryParse(mNumberOfChildrenAge6BelowController.value.text) ?? 0) +
        (int.tryParse(mNumberOfGuestAdultsController.value.text) ?? 0) +
        (int.tryParse(mNumberOfGuestChildrenAge12AboveController.value.text) ??
            0) +
        (int.tryParse(mNumberOfGuestChildrenAge6BelowController.value.text) ??
            0);

    // Calculate total number of food catering pax
    int totalCateringPax =
        (int.tryParse(mVegetarianController.value.text) ?? 0) +
        (int.tryParse(mNonVegetarianController.value.text) ?? 0) +
        (int.tryParse(mJainController.value.text) ?? 0);

    // Check if the totals match - FIXED: Use .value for mFoodStatus
    if (totalParticipants != totalCateringPax && mFoodStatus.value == '1') {
      Get.defaultDialog(
        title: "Alert",
        middleText:
            "The total number of food catering pax does not match the total number of participants.",
        onConfirm: () => Get.back(),
        textConfirm: "OK",
      );
    } else if (mPaymentReceiptController.value.text.isEmpty) {
      Get.defaultDialog(
        title: "Alert",
        middleText: "Please upload a payment receipt attachment",
        onConfirm: () => Get.back(),
        textConfirm: "OK",
      );
    } else {
      getEventSubmitApi();
    }
  }

  void _initializeEventDetails() {
    mTitle.value = mEventModule.title ?? '';
    mDescription.value = mEventModule.description ?? '';

    DateTime parsedstartDate = DateTime.parse(mEventModule.startDate ?? '');
    String formattedstartDate = DateFormat(
      'dd/MM/yyyy',
    ).format(parsedstartDate);
    mStartDate.value = formattedstartDate;
    // mStartDate.value = mEventModule.startDate ?? '';

    DateTime parsedendDate = DateTime.parse(mEventModule.startDate ?? '');
    String formattedendDate = DateFormat('dd/MM/yyyy').format(parsedendDate);
    mEndDate.value = formattedendDate;
    // mEndDate.value = mEventModule.endDate ?? '';

    mMemberAdultAge.value = mEventModule.memberAdultAge ?? '';
    mMemberAdultAmount.value = mEventModule.memberAdultAmount ?? '';
    mMemberChildStatus.value = mEventModule.memberChildStatus?.toString() ?? '';
    mMemberChildAge.value = mEventModule.memberChildAge ?? '';
    mMemberChildAmount.value = mEventModule.memberChildAmount?.toString() ?? '';
    mGuestAdultAge.value = mEventModule.guestAdultAge ?? '';
    mGuestAdultAmount.value = mEventModule.guestAdultAmount?.toString() ?? '';
    mGuestChildStatus.value = mEventModule.guestChildStatus?.toString() ?? '';
    mGuestChildAge.value = mEventModule.guestChildAge ?? '';
    mGuestChildAmount.value = mEventModule.guestChildAmount?.toString() ?? '';
    mFoodStatus.value = mEventModule.foodStatus?.toString() ?? '';
    // isMemberRenewal.value = mEventModule.subscriptionStatus == 1 ? true : false;
    mSubscriptionStatus.value =
        mEventModule.subscriptionStatus?.toString() ?? '';
  }

  //Event Details api
  getEventSubmitApi() async {
    try {
      bool isInternetAvailable = await NetworkUtils().checkInternetConnection();

      if (!isInternetAvailable) {
        AppAlert.showSnackBar(
          Get.context!,
          MessageConstants.noInternetConnection,
        );
        return;
      }

      // Show loading indicator
      Get.dialog(
        WillPopScope(
          onWillPop: () async => false,
          child: Center(child: CircularProgressIndicator()),
        ),
        barrierDismissible: false,
      );

      ParticipantSubmitRequest mPrticipantRequest = ParticipantSubmitRequest(
        eventId: (mEventModule.id ?? 0).toString(),
        participantName: mPrimaryNameController.value.text,
        emailAddress: mEmailController.value.text,
        noOfParticipants: int.tryParse(msNoOfPersonController.value.text) ?? 0,
        noOfAdult: int.tryParse(mNumberOfAdultsController.value.text) ?? 0,
        noOfChild:
            int.tryParse(mNumberOfChildrenAgeLimitController.value.text) ?? 0,
        noOfFreeChild:
            int.tryParse(mNumberOfChildrenAge6BelowController.value.text) ?? 0,
        noOfGuest: int.tryParse(mNumberOfGuestAdultsController.value.text) ?? 0,
        noOfGuestChild:
            int.tryParse(
              mNumberOfGuestChildrenAge12AboveController.value.text,
            ) ??
            0,
        noOfGuestFreeChild:
            int.tryParse(
              mNumberOfGuestChildrenAge6BelowController.value.text,
            ) ??
            0,
        veg: int.tryParse(mVegetarianController.value.text) ?? 0,
        nonVeg: int.tryParse(mNonVegetarianController.value.text) ?? 0,
        jain: int.tryParse(mJainController.value.text) ?? 0,
        subsInclude: isSubscriptionRenewalChecked.value,
        totalAmountPaid: totalPaymentAmount.value,
        membershipId: mUserMembershipID.value,
      );

      WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
          .postParticipantSubmit(mPrticipantRequest);

      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        ParticipantSubmitResponse mParticipantSubmitResponse =
            mWebResponseSuccess.data;

        if (mParticipantSubmitResponse.statusCode ==
            WebConstants.statusCode200) {
          // Extract participant ID from the response
          String participantId = "";

          try {
            participantId =
                mParticipantSubmitResponse.data?.getParticipantId() ?? "";

            if (participantId.isNotEmpty) {
              print("Successfully extracted participant ID: $participantId");
            } else {
              print("Warning: Participant ID is empty");
            }
          } catch (e) {
            print("Error extracting participant ID: $e");
            print("Stack trace: ${StackTrace.current}");
          }

          // Upload payment receipt if exists and we have a valid participant ID
          if (mPaymentReceiptController.value.text.isNotEmpty &&
              participantId.isNotEmpty) {
            try {
              await paymentFileUpload(participantId);
              print("Payment receipt upload completed");
            } catch (e) {
              print("Error uploading payment receipt: $e");
              // Continue even if upload fails
            }
          }

          // Close loading dialog
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }

          // Create QR details
          QrDetailsRequest mQrDetails = QrDetailsRequest(
            eventId: (mEventModule.id ?? 0).toString(),
            membershipId: mUserMembershipID.value,
          );

          print(
            "QR Details created - EventID: ${mQrDetails.eventId}, MembershipID: ${mQrDetails.membershipId}",
          );

          // Show success message
          AppAlert.showSnackBar(Get.context!, "Successfully Registered");

          // Wait a moment for the snackbar to show
          await Future.delayed(Duration(milliseconds: 500));

          // Navigate to QR screen and remove all previous routes
          // This ensures user can't go back to the form
          Get.offAllNamed(AppRoutes.qrScreen, arguments: mQrDetails);
        } else {
          // Close loading dialog
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }

          AppAlert.showSnackBar(
            Get.context!,
            mParticipantSubmitResponse.statusMessage ?? "Submission failed",
          );
        }
      } else {
        // Close loading dialog
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }

        ParticipantSubmitResponse mParticipantSubmitResponse =
            mWebResponseSuccess.data;
        AppAlert.showSnackBar(
          Get.context!,
          mParticipantSubmitResponse.statusMessage ?? "Request failed",
        );
      }
    } catch (e) {
      // Close loading dialog if open
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }

      print("Error in getEventSubmitApi: $e");
      print("Stack trace: ${StackTrace.current}");
      AppAlert.showSnackBar(Get.context!, "An error occurred: ${e.toString()}");
    }
  }

  Future<void> paymentFileUpload(String id) async {
    try {
      bool isInternetAvailable = await NetworkUtils().checkInternetConnection();

      if (!isInternetAvailable) {
        print("No internet connection for payment upload");
        return;
      }

      EventPaymentSubmitRequest mEventPaymentSubmitRequest =
          EventPaymentSubmitRequest(id: id);

      WebResponseSuccess mWebResponseSuccess = await AllApiImpl().eventsImage(
        mPaymentReceiptController.value.text,
        mEventPaymentSubmitRequest,
      );

      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        print("Payment receipt uploaded successfully for ID: $id");
      } else {
        print(
          "Payment receipt upload failed with status: ${mWebResponseSuccess.statusCode}",
        );
      }
    } catch (e) {
      print("Error uploading payment receipt: $e");
      // Don't throw error, just log it
    }
  }

  void navigateToNextScreen(EventModule eventModule, context) {
    // Check if mNumberOfAdultsController is filled
    if (mNumberOfAdultsController.value.text.isEmpty) {
      SnackbarHelper.showError(context, "Please enter the number of adults");
      return;
    }

    // Check if mMemberChildStatus is '1' and validate children controllers
    if (mMemberChildStatus.value == '1') {
      if (mNumberOfChildrenAgeLimitController.value.text.isEmpty) {
        SnackbarHelper.showError(
          context,
          "Please enter the number of children",
        );
        return;
      }
      if (mNumberOfChildrenAge6BelowController.value.text.isEmpty) {
        SnackbarHelper.showError(
          context,
          "Please enter the number of children (Age 6 and below)",
        );

        return;
      }
    }

    // Check if mNumberOfGuestAdultsController is filled
    if (mNumberOfGuestAdultsController.value.text.isEmpty) {
      SnackbarHelper.showError(
        context,
        "Please enter the number of guest adults",
      );

      return;
    }

    // Check if mGuestChildStatus is '1' and validate guest children controllers
    if (mGuestChildStatus.value == '1') {
      if (mNumberOfGuestChildrenAge12AboveController.value.text.isEmpty) {
        SnackbarHelper.showError(
          context,
          "Please enter the number of guest children",
        );

        return;
      }
      if (mNumberOfGuestChildrenAge6BelowController.value.text.isEmpty) {
        SnackbarHelper.showError(
          context,
          "Please enter the number of guest children (Age 6 and below)",
        );

        return;
      }
    }

    msNoOfPersonController.value.text = getTotalParticipants().toString();

    calculateTotalPaymentAmount();
    // All validations passed, navigate to the next screen
    Get.toNamed(AppRoutes.eventDetailTwoScreen, arguments: eventModule);
  }

  int getTotalParticipants() {
    int totalParticipants = 0;

    totalParticipants +=
        int.tryParse(mNumberOfAdultsController.value.text) ?? 0;
    if (mMemberChildStatus.value == "1") {
      totalParticipants +=
          int.tryParse(mNumberOfChildrenAgeLimitController.value.text) ?? 0;
      totalParticipants +=
          int.tryParse(mNumberOfChildrenAge6BelowController.value.text) ?? 0;
    }
    totalParticipants +=
        int.tryParse(mNumberOfGuestAdultsController.value.text) ?? 0;
    if (mGuestChildStatus.value == "1") {
      totalParticipants +=
          int.tryParse(mNumberOfGuestChildrenAge12AboveController.value.text) ??
          0;
      totalParticipants +=
          int.tryParse(mNumberOfGuestChildrenAge6BelowController.value.text) ??
          0;
    }

    return totalParticipants;
  }

  getUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf', 'heic', 'heif'],
    );

    if (result != null && result.files.single.path != null) {
      mPaymentReceiptController.value.text = result.files.single.path!;

      mPaymentReceiptController.refresh();
    }
  }



  Future<void> downloadQR() async {
    // Request permission (Android)
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      if (!status.isGranted) {
        throw Exception("Storage permission denied");
      }
    }

    // Load asset image as bytes
    ByteData data =
    await rootBundle.load('assets/images/payment_qr.png');
    Uint8List bytes = data.buffer.asUint8List();

    Directory directory;

    if (Platform.isAndroid) {
      // Android Downloads folder
      directory = Directory('/storage/emulated/0/Download');
    } else {
      // iOS Documents directory
      directory = await getApplicationDocumentsDirectory();
    }

    final filePath = '${directory.path}/payment_qr.png';
    final file = File(filePath);

    await file.writeAsBytes(bytes);
    AppAlert.showSnackBar(Get.context!, 'Download qr successful',mColor: Colors.green);

    print("QR saved at: $filePath");
  }

  void showQrDialog() {
    showDialog(
      context: Get.context!,
      barrierDismissible: true,
      builder: (_) {
        return AlertDialog(
          title: const Text("Payment QR Code"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                'assets/images/payment_qr.png',
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 12),
              const Text("Scan this QR code to make payment"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(Get.context!),
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }

  submit() {
    showPaymentMessage.value = "";
    if (mNameController.value.text.isEmpty) {
      showPaymentMessage.value = "Please enter your name";
    } else if (mEmailController.value.text.isEmpty) {
      showPaymentMessage.value = "Please enter your Email id";
    } else if (msNoOfPersonController.value.text.isEmpty) {
      showPaymentMessage.value = "Please enter no of person";
    } else if (AppUtils.getInValue(msNoOfPersonController.value.text) <= 0) {
      showPaymentMessage.value = "No of person should be greater than 0";
    }

    if (showPaymentMessage.value.isNotEmpty) {
      AppAlert.showSnackBar(Get.context!, showPaymentMessage.value);
    } else {
      getEventSubmitApi();
    }
  }
}
