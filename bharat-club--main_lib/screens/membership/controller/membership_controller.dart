import 'dart:convert';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';

import '../../../alert/app_alert.dart';

import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/membership_type/membership_type_response.dart';
import '../../../data/mode/profile_response/profile_response.dart';
import '../../../data/mode/registration/registration_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';

class MembershipDetailsController extends GetxController {
  RxBool membershipStatus = false.obs;
  RxString membershipEndDate = "".obs;
  RxString membershipType = "".obs;
  RxString membershipId = "".obs;
  RxString userName = "".obs;
  RxString emailId = "".obs;
  RxString phoneNumber = "".obs;
  RxString photo = "".obs;
  RxString attachmentPath = "".obs;
  String fileName = "";
  String sPath = "";

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }
  Future<void> getProfile() async {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postProfile();
        ProfileResponse mProfileResponse = mWebResponseSuccess.data;
        List<MembershipTypeData> membershipList = await SharedPrefs()
            .getMembershipTypeAll();

        if (mProfileResponse.statusCode == WebConstants.statusCode400) {
          AppAlert.showSnackBar(Get.context!, "Token is Expired Please login");
          await SharedPrefs().setUserToken("");
          await SharedPrefs().setUserDetails(jsonEncode(RegistrationUser()));
          Get.offNamed(AppRoutes.home);
        } else if (mWebResponseSuccess.statusCode ==
            WebConstants.statusCode200) {
          // Membership Details
          membershipEndDate.value =
              mProfileResponse.data?.membershipEndDate ?? "";
          membershipStatus.value = membershipEndDate.value.isEmpty
              ? false
              : dateCompare(membershipEndDate.value);

          // Get Membership Type Name
          MembershipTypeData? matchingMembership = membershipList
              .firstWhereOrNull(
                (membership) =>
                    membership.id == mProfileResponse.data!.membershipTypeID,
              );
          membershipType.value = matchingMembership?.type ?? 'No Type';

          membershipId.value = mProfileResponse.data?.membershipId ?? "";

          // User Info
          userName.value = mProfileResponse.data?.name ?? "";
          emailId.value = mProfileResponse.data?.email ?? "";
          phoneNumber.value = mProfileResponse.data?.mobile ?? "";

          // Profile Picture
          attachmentPath.value = "";
          photo.value = (mProfileResponse.data?.userAttachments ?? []).isEmpty
              ? ""
              : (mProfileResponse.data?.userAttachments?.first.fileUrl ?? "");

          await SharedPrefs().setUserDetails(jsonEncode(mProfileResponse.data));
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

    return dt1.compareTo(dt2) >= 0;
  }
}
