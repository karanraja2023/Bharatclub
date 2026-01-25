import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobileapp/api/api_call/api_provider.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/constant/web_constant.dart';
import 'package:mobileapp/data/mode/event_qr_scan/qr_access_request.dart';

class QRAccessService {
  static final WebProvider _webProvider = WebProvider();

  static Future<bool> verifyQRAccess({required String deviceId}) async {
    _showLoadingDialog();

    try {
      final request = QRAccessRequest(deviceId: deviceId, accessName: 'QRScan');

      debugPrint('QR Access Request: ${request.toJson()}');

      final response = await _webProvider
          .postWithRequest(WebConstants.verifyQRUrl, request.toJson())
          .timeout(
            const Duration(seconds: 15),
            onTimeout: () {
              throw Exception('Request timeout');
            },
          );
      _closeLoadingDialog();

      debugPrint('QR Access Response Status: ${response.statusCode}');
      debugPrint('QR Access Response Body: ${response.body}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = QRAccessResponse.fromJson(response.body);

        debugPrint('Response Error: ${responseData.error}');
        debugPrint('Response Status Code: ${responseData.statusCode}');
        debugPrint('Response Message: ${responseData.message}');

        if (responseData.isAccessGranted) {
          return true;
        } else if (responseData.isAccessDenied) {
          // _showAccessDeniedSnackbar();
          return false;
        } else if (responseData.statusCode == 401) {
          // _showUnauthorizedSnackbar();
          return false;
        } else if (responseData.statusCode == 404) {
          // _showErrorSnackbar('Device not registered in the system');
          return false;
        } else if (responseData.statusCode != null &&
            responseData.statusCode! >= 500) {
          // _showErrorSnackbar('Server error. Please try again later.');
          return false;
        } else {
          final errorMessage =
              responseData.message ??
              responseData.statusMessage ??
              'Failed to verify access';
          // _showErrorSnackbar(errorMessage);
          return false;
        }
      } else if (response.statusCode == 403) {
        // _showAccessDeniedSnackbar();
        print("###########");
        return false;
      } else if (response.statusCode == 401) {
        _showUnauthorizedSnackbar();
        return false;
      } else if (response.statusCode == 404) {
        _showErrorSnackbar('Device not registered in the system');
        return false;
      } else if (response.statusCode != null && response.statusCode! >= 500) {
        _showErrorSnackbar('Server error. Please try again later.');
        return false;
      } else {
        final errorMessage = response.statusText ?? 'Failed to verify access';
        _showErrorSnackbar(errorMessage);
        return false;
      }
    } catch (e) {
      _closeLoadingDialog();

      debugPrint('QR Access Verification Error: $e');
      if (e.toString().contains('timeout')) {
        _showErrorSnackbar('Connection timeout. Please check your internet.');
      } else if (e.toString().contains('SocketException') ||
          e.toString().contains('Network')) {
        _showErrorSnackbar('No internet connection. Please try again.');
      } else if (e.toString().contains('FormatException')) {
        _showErrorSnackbar('Invalid response from server.');
      } else {
        _showErrorSnackbar('Failed to verify access. Please try again.');
      }

      return false;
    }
  }

  static void _showLoadingDialog() {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF2E7D32),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verifying Access',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Please wait...',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  static void _closeLoadingDialog() {
    try {
      if (Get.isDialogOpen ?? false) {
        Get.back();
      }
    } catch (e) {
      debugPrint('Error closing dialog: $e');
    }
  }

  static void _showAccessDeniedSnackbar() {
    Get.snackbar(
      'Access Denied',
      'You do not have permission to access the QR scanner.\nPlease contact: clubbharat@gmail.com',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      icon: const Icon(Icons.block_rounded, color: Colors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(milliseconds: 400),
    );
  }

  static void _showUnauthorizedSnackbar() {
    Get.snackbar(
      'Unauthorized',
      'Please login again to continue',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.indiaOrange,
      colorText: Colors.white,
      icon: const Icon(Icons.warning_rounded, color: Colors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(milliseconds: 400),
    );
  }

  static void _showErrorSnackbar(String message) {
    Get.snackbar(
      'Error',
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.error,
      colorText: Colors.white,
      icon: const Icon(Icons.error_rounded, color: Colors.white),
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      animationDuration: const Duration(milliseconds: 400),
    );
  }
}
