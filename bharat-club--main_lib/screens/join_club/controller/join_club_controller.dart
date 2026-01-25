import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/utils/app_util.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';
import '../../../alert/app_alert.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/join_clube/join_club_response.dart';
import '../../../data/mode/join_clube/join_club_submit_request.dart';
import '../../../data/mode/join_clube/join_club_submit_response.dart';
import '../../../data/mode/profile_response/profile_response.dart';
import '../../../data/mode/registration/registration_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import 'package:intl/intl.dart';

class JoinClubController extends GetxController {
  var counter = 0.obs;
  var isJoinClub = false.obs;
  final pageController = PageController(initialPage: 0);

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  var selectRadioButtonValue = 0.obs;
  var mClubsMembership = ClubsMembership().obs;
  final Rx<TextEditingController> mMemberNameController =
      TextEditingController().obs;
  final TextEditingController mCompanyNameController = TextEditingController();
  final Rx<TextEditingController> mMobilePhoneController =
      TextEditingController().obs;
  final TextEditingController mMemberPassportController =
      TextEditingController();
  final Rx<TextEditingController> mEmailController =
      TextEditingController().obs;
  final TextEditingController mAddressController = TextEditingController();

  var showMemberDetailsNext = false.obs;
  var showMemberDetailsMessage = "".obs;

  isMemberDetailsCheck() {
    showMemberDetailsNext.value = false;
    showMemberDetailsMessage.value = "";
    if (mMemberNameController.value.text.isEmpty) {
      showMemberDetailsMessage.value = "Please enter your name";
    } else if (mCompanyNameController.text.isEmpty) {
      showMemberDetailsMessage.value = "Please enter your company name";
    } else if (mMobilePhoneController.value.text.isEmpty) {
      showMemberDetailsMessage.value = "Please enter your mobile number";
    } else if (AppUtils.isValidPhone(mMobilePhoneController.value.text)) {
      showMemberDetailsMessage.value = "Please enter your valid mobile number";
    } else if (mEmailController.value.text.isEmpty) {
      showMemberDetailsMessage.value = "Please enter your email";
    } else if (mMemberPassportController.text.isEmpty) {
      showMemberDetailsMessage.value = "Please enter your passport";
    } else if (AppUtils.isValidEmail(mEmailController.value.text)) {
      showMemberDetailsMessage.value = "Please enter your valid email";
    } else if (mAddressController.text.isEmpty) {
      showMemberDetailsMessage.value = "Please enter your address";
    } else {
      showMemberDetailsNext.value = true;
    }
    if (showMemberDetailsMessage.value.isNotEmpty) {
      AppAlert.showSnackBar(Get.context!, showMemberDetailsMessage.value);
    } else {
      pageController.jumpToPage(2);
    }
  }

  final TextEditingController mSpouseNameController = TextEditingController();
  final TextEditingController mSpouseMobilePhoneController =
      TextEditingController();
  final TextEditingController mSpouseEmailController = TextEditingController();
  final TextEditingController mChildrenDetailsController =
      TextEditingController();
  final TextEditingController mSpousePassportController =
      TextEditingController();

  var showSpouseDetailsNext = false.obs;
  var showSpouseDetailsMessage = "".obs;

  isSpouseDetailsCheck() {
    showMemberDetailsNext.value = false;
    showMemberDetailsMessage.value = "";
    pageController.jumpToPage(3);
  }

  ///page forth page
  final Rx<TextEditingController> mAmountController =
      TextEditingController().obs;
  final TextEditingController mBankNameController = TextEditingController();
  final Rx<TextEditingController> mPaymentDateController =
      TextEditingController().obs;
  final Rx<TextEditingController> mPaymentReceiptController =
      TextEditingController().obs;
  final TextEditingController mPaymentReferenceNumberController =
      TextEditingController();

  var showPaymentMessage = "".obs;

  submit() {
    showPaymentMessage.value = "";
    if (mAmountController.value.text.isEmpty) {
      showPaymentMessage.value = "Please enter your amount";
    } else if (mBankNameController.text.isEmpty) {
      showPaymentMessage.value = "Please enter your bank name";
    } else if (mPaymentDateController.value.text.isEmpty) {
      showPaymentMessage.value = "Please enter your payment date";
    } else if (mPaymentReferenceNumberController.text.isEmpty) {
      showPaymentMessage.value = "Please enter your reference number";
    } else if (mPaymentReceiptController.value.text.isEmpty) {
      showPaymentMessage.value =
          "Please select your payment receipt and upload";
    }

    if (showPaymentMessage.value.isNotEmpty) {
      AppAlert.showSnackBar(Get.context!, showPaymentMessage.value);
    } else {
      getJoinClubSubmitApi();
    }
  }

  getCalendar() async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      DateFormat formatter = DateFormat('dd-MM-yyyy');
      mPaymentDateController.value.text = formatter.format(picked);
    }
  }

  getUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      mPaymentReceiptController.value.text = file.path.toString();
    } else {
      // User canceled the picker
    }
  }

  ///
  var sJoinClubBannerImage = "".obs;
  var sJoinClubTitle = "".obs;
  var sJoinClubDec = "".obs;
  var sJoinClubShotDec = "".obs;
  var sJoinClubAddress = "".obs;
  var sJoinClubEmail = "".obs;
  var sJoinClubPhone = "".obs;
  var sJoinClubMembership = [].obs;

  var clubId = "".obs;

  getJoinClubApi() async {
    WebResponseSuccess mWebResponseSuccess = await AllApiImpl().postJoinClubs();
    if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
      JoinClubResponse mJoinClubResponse = mWebResponseSuccess.data;

      ///banner
      if ((mJoinClubResponse.data?.clubsAttachments ?? []).isNotEmpty &&
          (mJoinClubResponse.data?.clubsAttachments?.first.fileUrl ?? "")
              .isNotEmpty) {
        sJoinClubBannerImage.value =
            (mJoinClubResponse.data?.clubsAttachments?.first.fileUrl ?? "");
      }

      ///details
      if ((mJoinClubResponse.data?.clubs ?? []).isNotEmpty) {
        clubId.value = (mJoinClubResponse.data?.clubs?.first.id ?? "")
            .toString();

        sJoinClubTitle.value =
            (mJoinClubResponse.data?.clubs?.first.clubTitle ?? "");
        sJoinClubDec.value =
            (mJoinClubResponse.data?.clubs?.first.description ?? "");
        sJoinClubAddress.value =
            (mJoinClubResponse.data?.clubs?.first.address ?? "");
        sJoinClubShotDec.value =
            (mJoinClubResponse.data?.clubs?.first.shortDescription ?? "");
        sJoinClubEmail.value =
            (mJoinClubResponse.data?.clubs?.first.email ?? "");
        sJoinClubPhone.value =
            (mJoinClubResponse.data?.clubs?.first.phone ?? "");

        sJoinClubMembership.addAll(
          mJoinClubResponse.data?.clubsMembership ?? [],
        );
      }
    }
  }

  getJoinClubSubmitApi() async {
    RegistrationUser mRegistrationUser = await SharedPrefs().getUserDetails();
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        JoinClubSubmitRequest mJoinClubSubmitRequest = JoinClubSubmitRequest(
          userId: (mRegistrationUser.id ?? "").toString(),
          clubsId: clubId.value,
          primaryMembername: mMemberNameController.value.text,
          companyname: mCompanyNameController.text,
          mobile: mMobilePhoneController.value.text,
          memberIcpassport: mMemberPassportController.text,
          email: mEmailController.value.text,
          residenceAddress: mAddressController.text,
          spousename: mSpouseNameController.text,
          spouseMobile: mSpouseMobilePhoneController.text,
          spouseIcpassport: mSpousePassportController.text,
          spouseEmail: mSpouseEmailController.text,
          spouseChildren: mChildrenDetailsController.text,
          amount: mClubsMembership.value.membershipPackageAmount ?? "",
          bankname: mBankNameController.text,
          paymentDate: mPaymentDateController.value.text,
          referenceNumber: mPaymentReferenceNumberController.text,
        );
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postJoinClubSubmit(mJoinClubSubmitRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          JoinClubSubmitResponse mJoinClubSubmitResponse =
              mWebResponseSuccess.data;
          if (mJoinClubSubmitResponse.statusCode ==
              WebConstants.statusCode200) {
            getProfile();
            AppAlert.showSnackBar(
              Get.context!,
              mJoinClubSubmitResponse.data?.message ?? "",
            );
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              mJoinClubSubmitResponse.data?.message ?? "",
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

  getProfile() async {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postProfile();
        ProfileResponse mProfileResponse = mWebResponseSuccess.data;
        if (mProfileResponse.statusCode == WebConstants.statusCode400) {
          AppAlert.showSnackBar(Get.context!, "Token is Expired Please login");
          await SharedPrefs().setUserToken("");
          await SharedPrefs().setUserDetails(jsonEncode(RegistrationUser()));
          Get.offNamed(AppRoutes.home);
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode200) {
          await SharedPrefs().setUserDetails(jsonEncode(mProfileResponse.data));
          Get.offNamed(AppRoutes.home);
        }
      } else {
        AppAlert.showSnackBar(
          Get.context!,
          MessageConstants.noInternetConnection,
        );
      }
    });
  }

  getRegistrationUserDetails() async {
    RegistrationUser mRegistrationUser = await SharedPrefs().getUserDetails();
    mMemberNameController.value.text = mRegistrationUser.name ?? "";
    mMobilePhoneController.value.text = mRegistrationUser.mobile ?? "";
    mEmailController.value.text = mRegistrationUser.email ?? "";
  }
}
