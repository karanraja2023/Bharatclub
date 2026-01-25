import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/utils/app_util.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';
import '../../../alert/app_alert.dart';
import '../../../data/mode/forgot_password/forgot_password_delete_request.dart';
import '../../../data/mode/forgot_password/forgot_password_delete_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../lang/translation_service_key.dart';


class ForgotPasswordScreenController extends GetxController {
  final TextEditingController mEmailController = TextEditingController();
  RxBool emailValidator = false.obs;
  RxString seEmailValidator = (sEmailError.tr).obs;

  isCheck() {
    if (mEmailController.text.isEmpty) {
      seEmailValidator.value = (sEmailError.tr);
      emailValidator.value = true;
    } else if (AppUtils.isValidEmail(mEmailController.text)) {
      seEmailValidator.value = sEmailErrorValid.tr;
      emailValidator.value = true;
    } else {
      forgotPasswordApiCall();
    }
  }

  void forgotPasswordApiCall() {
    NetworkUtils().checkInternetConnection().then((isInternetAvailable) async {
      if (isInternetAvailable) {
        ForgotPasswordDeleteRequest mForgotPasswordDeleteRequest =
            ForgotPasswordDeleteRequest(email: mEmailController.text);
        WebResponseSuccess mWebResponseSuccess =
            await AllApiImpl().postForgetPassword(mForgotPasswordDeleteRequest);
        if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
          ForgotPasswordDeleteResponse mForgotPasswordDeleteResponse =
              mWebResponseSuccess.data;
          if (mForgotPasswordDeleteResponse.statusCode ==
              WebConstants.statusCode200) {
            AppAlert.showSnackBar(Get.context!,
                mForgotPasswordDeleteResponse.data?.message ?? "");
            Get.back();
          } else {
            AppAlert.showSnackBar(Get.context!,
                mForgotPasswordDeleteResponse.data?.message ?? "");
          }
        }
      } else {
        AppAlert.showSnackBar(
            Get.context!, MessageConstants.noInternetConnection);
      }
    });
  }
}
