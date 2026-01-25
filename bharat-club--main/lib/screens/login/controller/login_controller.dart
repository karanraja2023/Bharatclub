import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/routes_name.dart';
import 'package:mobileapp/common/constant/web_constant.dart';
import 'package:mobileapp/data/local/shared_prefs/shared_prefs.dart';
import 'package:mobileapp/lang/translation_service_key.dart';
import 'package:mobileapp/utils/app_util.dart';
import 'package:mobileapp/utils/message_constants.dart';
import 'package:mobileapp/utils/network_util.dart';
import '../../../alert/app_alert.dart';
import '../../../data/mode/registration/registration_request.dart';
import '../../../data/mode/registration/registration_response.dart';
import '../../../data/remote/api_call/api_impl.dart';
import '../../../data/remote/web_response.dart';
import '../../../utils/device_info_helper.dart';

class LoginScreenController extends GetxController {
  late final TextEditingController mEmailController;
  late final TextEditingController mPasswordController;

  final formKey = GlobalKey<FormState>();

  RxBool emailValidator = false.obs;
  Rx<IconData> suffixIcon = Icons.visibility_off.obs;
  RxBool passwordValidator = false.obs;
  RxBool hidePassword = true.obs;
  RxString seEmailValidator = (sEmailError.tr).obs;
  RxString sePasswordValidator = (sPasswordError.tr).obs;
  RxBool isLoading = false.obs;

  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

  // Device ID
  RxString deviceId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    mEmailController = TextEditingController();
    mPasswordController = TextEditingController();
    _initializeDeviceInfo();
  }

  @override
  void onClose() {
    try {
      mEmailController.dispose();
      mPasswordController.dispose();
    } catch (e) {
      print('Error disposing controllers: $e');
    }
    super.onClose();
  }

  /// Initialize device information
  Future<void> _initializeDeviceInfo() async {
    try {
      deviceId.value = await DeviceInfoHelper.getDeviceId();
      debugPrint('Device ID initialized: ${deviceId.value}');
    } catch (e) {
      debugPrint('Error initializing device info: $e');
      deviceId.value = 'ERROR';
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      emailError.value = 'Email is required';
      return emailError.value;
    }

    final trimmedValue = value.trim();
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmedValue)) {
      emailError.value = 'Please enter a valid email address';
      return emailError.value;
    }

    if (trimmedValue.length < 5) {
      emailError.value = 'Email is too short';
      return emailError.value;
    }

    if (trimmedValue.length > 254) {
      emailError.value = 'Email is too long';
      return emailError.value;
    }

    emailError.value = '';
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      passwordError.value = 'Password is required';
      return passwordError.value;
    }

    if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return passwordError.value;
    }

    if (value.length > 50) {
      passwordError.value = 'Password is too long';
      return passwordError.value;
    }

    passwordError.value = '';
    return null;
  }

  void handleLogin() async {
    emailError.value = '';
    passwordError.value = '';

    // Capture and print device ID when login button is pressed
    deviceId.value = await DeviceInfoHelper.getDeviceId();

    debugPrint('==========================================');
    debugPrint('LOGIN BUTTON PRESSED');
    debugPrint('Device ID: ${deviceId.value}');
    debugPrint('==========================================');

    final emailValidationError = validateEmail(mEmailController.text);
    final passwordValidationError = validatePassword(mPasswordController.text);

    if (emailValidationError != null || passwordValidationError != null) {
      formKey.currentState?.validate();
      Get.snackbar(
        'Validation Error',
        'Please fill all fields correctly',
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        borderRadius: 12,
        duration: const Duration(seconds: 2),
      );
    } else {
      validateUserLogin();
    }
  }

  isCheck() {
    setValidator();
    if (mEmailController.text.isEmpty) {
      seEmailValidator.value = (sEmailError.tr);
      emailValidator.value = true;
    } else if (AppUtils.isValidEmail(mEmailController.text)) {
      seEmailValidator.value = sEmailErrorValid.tr;
      emailValidator.value = true;
    } else if (mPasswordController.text.isEmpty) {
      sePasswordValidator.value = (sPasswordError.tr);
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
    isLoading.value = true;
    await loginApi(RegistrationRequestType.NORMAL_LOGIN.name);
  }

  loginApi(String type) async {
    try {
      NetworkUtils()
          .checkInternetConnection()
          .then((isInternetAvailable) async {
            if (isInternetAvailable) {
              try {
                RegistrationRequest mRegistrationRequest = RegistrationRequest(
                  email: mEmailController.text,
                  password: mPasswordController.text,
                  deviceId: '123456789',
                  // deviceId: deviceId.value,

                  name: "",
                  profile: "",
                  mobile: "",
                  type: "",
                );

                WebResponseSuccess mWebResponseSuccess = await AllApiImpl()
                    .postLogin(mRegistrationRequest);

                isLoading.value = false;

                if (mWebResponseSuccess.statusCode ==
                    WebConstants.statusCode200) {
                  RegistrationResponse mRegistrationResponse =
                      mWebResponseSuccess.data;
                  await SharedPrefs().setUserToken(
                    mRegistrationResponse.data?.token ?? "",
                  );
                  await SharedPrefs().setUserLoginStatus(
                    (mRegistrationResponse.data?.user?.loginStatus ?? 0)
                        .toString(),
                  );
                  await SharedPrefs().setUserDetails(
                    jsonEncode(mRegistrationResponse.data!.user),
                  );

                  // Save device ID
                  await SharedPrefs().setDeviceId(deviceId.value);

                  if (mRegistrationResponse.data!.user != null) {
                    if ((mRegistrationResponse.data?.user?.loginStatus ?? 0) ==
                        0) {
                      Get.toNamed(AppRoutes.changePassword);
                    } else {
                      mEmailController.text = "";
                      mPasswordController.text = "";
                      Get.delete<LoginScreenController>();
                      Get.offNamed(AppRoutes.home);
                    }
                  } else {
                    AppAlert.showSnackBar(
                      Get.context!,
                      'Please enter the valid user id and password',
                    );
                  }
                } else {
                  AppAlert.showSnackBar(
                    Get.context!,
                    'Invalid credentials. Please try again.',
                  );
                }
              } catch (e) {
                isLoading.value = false;
                AppAlert.showSnackBar(
                  Get.context!,
                  'Login failed. Please try again.',
                );
                print('Login API Error: $e');
              }
            } else {
              isLoading.value = false;
              AppAlert.showSnackBar(
                Get.context!,
                MessageConstants.noInternetConnection,
              );
            }
          })
          .catchError((error) {
            isLoading.value = false;
            AppAlert.showSnackBar(
              Get.context!,
              'Connection error. Please try again.',
            );
            print('Connection Error: $error');
          });
    } catch (e) {
      isLoading.value = false;
      AppAlert.showSnackBar(
        Get.context!,
        'An error occurred. Please try again.',
      );
      print('Unexpected Error: $e');
    }
  }
}
