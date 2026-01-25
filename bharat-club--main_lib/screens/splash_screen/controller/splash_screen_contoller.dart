import 'dart:async';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/data/local/shared_prefs/shared_prefs.dart';

class SplashController extends GetxController {
  final RxBool hasNavigated = false.obs;

  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    _scheduleNavigation();
  }

  void _scheduleNavigation() {
    _timer = Timer(const Duration(seconds: 3), _checkLoginStatus);
  }

  Future<void> _checkLoginStatus() async {
    if (hasNavigated.value) return;
    hasNavigated.value = true;

    final prefs = SharedPrefs();
    await prefs.sharedPreferencesInstance();
    final loginStatus = await prefs.getUserLoginStatus();
    final token = await prefs.getUserToken();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (token.isNotEmpty && loginStatus != "0") {
        Get.offAllNamed(AppRoutes.home);
      } else {
        Get.offAllNamed(AppRoutes.loginScreen);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
