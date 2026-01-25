import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

/// Helper class to get device ID
class DeviceInfoHelper {
  static final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();

  /// Get unique device ID based on platform
  static Future<String> getDeviceId() async {
    try {
      if (Platform.isAndroid) {
        return await _getAndroidDeviceId();
      } else if (Platform.isIOS) {
        return await _getIOSDeviceId();
      } else {
        return 'UNKNOWN_PLATFORM';
      }
    } catch (e) {
      debugPrint('Error getting device ID: $e');
      return 'ERROR_GETTING_DEVICE_ID';
    }
  }

  /// Get Android device ID
  static Future<String> _getAndroidDeviceId() async {
    try {
      AndroidDeviceInfo androidInfo = await _deviceInfoPlugin.androidInfo;
      return androidInfo.id;
    } catch (e) {
      debugPrint('Error getting Android device ID: $e');
      return 'ANDROID_ERROR';
    }
  }

  /// Get iOS device ID
  static Future<String> _getIOSDeviceId() async {
    try {
      IosDeviceInfo iosInfo = await _deviceInfoPlugin.iosInfo;
      return iosInfo.identifierForVendor ?? 'IOS_ERROR';
    } catch (e) {
      debugPrint('Error getting iOS device ID: $e');
      return 'IOS_ERROR';
    }
  }
}