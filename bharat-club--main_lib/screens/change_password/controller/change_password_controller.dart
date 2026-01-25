import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/data/mode/change_password/change_password_request.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';
import '../../../alert/app_alert.dart';
import '../../../data/local/shared_prefs/shared_prefs.dart';
import '../../../data/mode/registration/registration_request.dart';
import '../../../data/mode/registration/registration_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../lang/translation_service_key.dart';

class ChangePasswordScreenController extends GetxController {
  final TextEditingController mEmailController = TextEditingController();
  final TextEditingController mPasswordController = TextEditingController();
  RxBool emailValidator = false.obs;
  Rx<IconData> suffixIcon = Icons.visibility_off.obs;
  RxBool passwordValidator = false.obs;
  RxBool hidePassword = true.obs;
  RxString seEmailValidator = (sEmailError.tr).obs;
  RxString sePasswordValidator = (sPasswordError.tr).obs;

  isCheck() {
    setValidator();
    if (mEmailController.text.isEmpty) {
      seEmailValidator.value = ('Please enter the old password');
      emailValidator.value = true;
    } else if (mEmailController.text.length < 6) {
      seEmailValidator.value = (sPasswordErrorValid.tr);
      emailValidator.value = true;
    } else if (mPasswordController.text.isEmpty) {
      sePasswordValidator.value = ('Please enter the new password');
      passwordValidator.value = true;
    } else if (mPasswordController.text.length < 6) {
      sePasswordValidator.value = (sPasswordErrorValid.tr);
      passwordValidator.value = true;
    } else {
      validateUserLogin();
    }
  }

  setValidator() {
    emailValidator.value = false;
    passwordValidator.value = false;
  }

  showPassword() {
    if (hidePassword.value) {
      hidePassword.value = false;
      suffixIcon.value = Icons.visibility;
    } else {
      hidePassword.value = true;
      suffixIcon.value = Icons.visibility_off;
    }
  }

  void setIndonesianEnglish(String sValue) {
    if (sValue == sIndonesian.tr) {
      var locale = const Locale('id', 'ID');
      Get.updateLocale(locale);
    } else if (sValue == sEnglish.tr) {
      var locale = const Locale('en', 'US');
      Get.updateLocale(locale);
    }
  }

  bool getLanguage(String sValue) {
    var getLocale = Get.locale;
    if (sValue == sIndonesian.tr) {
      var locale = const Locale('id', 'ID');
      if (locale == getLocale) {
        return true;
      }
      return false;
    } else if (sValue == sEnglish.tr) {
      var locale = const Locale('en', 'US');
      if (locale == getLocale) {
        return true;
      }
      return false;
    } else {
      return false;
    }
  }

  String errorMessage = "";

  void validateUserLogin() async {
    loginApi(RegistrationRequestType.NORMAL_LOGIN.name);
  }

  loginApi(String type) async {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        ChangePasswordRequest mChangePasswordRequest = ChangePasswordRequest(
          oldPassword: mEmailController.text,
          password: mPasswordController.text,
        );

        WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
            .postChangePassword(mChangePasswordRequest);

        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          RegistrationResponse mRegistrationResponse = mWebResponseSuccess.data;

          if (mRegistrationResponse.data?.user?.id != null) {
            await SharedPrefs().setUserLoginStatus(
              (mRegistrationResponse.data?.user?.loginStatus ?? 0).toString(),
            );
            await SharedPrefs().setUserDetails(
              jsonEncode(mRegistrationResponse.data?.user),
            );
            // context.showSnackBar('Password changed successfully');
            AppAlert.showSnackBar(
              Get.context!,
              'Password changed successfully',
            );

            // Optionally navigate back to Home or Login
            Get.offAllNamed(AppRoutes.home);
          } else if (mRegistrationResponse.data?.user?.original != null) {
            AppAlert.showSnackBar(
              Get.context!,
              mRegistrationResponse.data?.user?.original?.data?.error ?? "",
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
