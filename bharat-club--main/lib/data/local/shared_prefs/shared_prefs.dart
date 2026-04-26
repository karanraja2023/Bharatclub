import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../mode/membership_type/membership_type_response.dart';
import '../../mode/registration/registration_response.dart';
import 'pref_constants.dart';

class SharedPrefs {
  // Singleton approach
  static final SharedPrefs _instance = SharedPrefs._internal();

  factory SharedPrefs() => _instance;
  static const String _deviceIdKey = 'device_id';

  SharedPrefs._internal();

  SharedPreferences? sharedPreferences;

  Future<SharedPreferences> _prefs() async {
    return sharedPreferences ??= await SharedPreferences.getInstance();
  }

  sharedPreferencesInstance() async {
    if (sharedPreferences == null) {
      return sharedPreferences = await SharedPreferences.getInstance();
    } else {
      return sharedPreferences;
    }
  }

  /// AppUserToke
  Future<void> setUserLoginStatus(String? loginStatus) async {
    /// debugPrint("setToken $bearerToken");
    final prefs = await _prefs();
    await prefs.setString(PrefConstants.sLoginStatus, loginStatus ?? "");
  }

  Future<String> getUserLoginStatus() async {
    final prefs = await _prefs();
    String value = prefs.getString(PrefConstants.sLoginStatus) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return "";
  }

  /// AppUserToke
  Future<void> setUserToken(String? bearerToken) async {
    /// debugPrint("setToken $bearerToken");
    final prefs = await _prefs();
    await prefs.setString(PrefConstants.token, bearerToken ?? "");
  }

  Future<String> getUserToken() async {
    final prefs = await _prefs();
    String value = prefs.getString(PrefConstants.token) ?? "";
    if (value.isNotEmpty) {
      return value;
    }
    return "";
  }

  Future<void> setUserDetails(String? setUserDetails) async {
    final prefs = await _prefs();
    await prefs.setString(
      PrefConstants.sUserDetails,
      setUserDetails ?? "",
    );
  }

  Future<RegistrationUser> getUserDetails() async {
    final prefs = await _prefs();
    String value = prefs.getString(PrefConstants.sUserDetails) ?? "";
    if (value.isNotEmpty) {
      return RegistrationUser.fromJson(json.decode(value));
    }
    return RegistrationUser();
  }

  //MebershipType Data
  Future<void> setMembershipTypeAll(String? setMembershipTypeAll) async {
    final prefs = await _prefs();
    await prefs.setString(
      PrefConstants.sMembershipTypeAll,
      setMembershipTypeAll ?? "",
    );
  }

  Future<List<MembershipTypeData>> getMembershipTypeAll() async {
    final prefs = await _prefs();
    String value = prefs.getString(PrefConstants.sMembershipTypeAll) ?? "";
    if (value.isNotEmpty) {
      List<dynamic> jsonList = jsonDecode(value);
      return jsonList.map((e) => MembershipTypeData.fromJson(e)).toList();
    }
    return [];
  }

  Future<void> logout() async {
    await sharedPreferences?.remove(PrefConstants.token);
    await sharedPreferences?.remove(PrefConstants.sUserDetails);
    await sharedPreferences?.remove(PrefConstants.sLoginStatus);
  }

  Future<bool> setDeviceId(String deviceId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_deviceIdKey, deviceId);
    } catch (e) {
      print('Error saving device ID: $e');
      return false;
    }
  }

  /// Get device ID
  Future<String> getDeviceId() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getString(_deviceIdKey) ?? '';
    } catch (e) {
      print('Error getting device ID: $e');
      return '';
    }
  }
}
