// Privacy Policy Controller
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicyController extends GetxController {
  final RxBool isLoading = false.obs;
  final String privacyPolicyUrl = 'https://bharatclub.org/index.php/privacy-policy/';

  Future<void> launchPrivacyPolicy() async {
    try {
      isLoading.value = true;
      final Uri url = Uri.parse(privacyPolicyUrl);
      
      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
        Get.snackbar(
          'Error',
          'Could not open privacy policy',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red.shade100,
          colorText: Colors.red.shade900,
          margin: EdgeInsets.all(16),
          borderRadius: 12,
          icon: Icon(Icons.error_outline, color: Colors.red.shade900),
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
        margin: EdgeInsets.all(16),
        borderRadius: 12,
      );
    } finally {
      isLoading.value = false;
    }
  }
}
