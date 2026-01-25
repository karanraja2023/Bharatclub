// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class PinController extends GetxController {
//   static const String PIN_KEY = 'user_pin';
  
//   final RxBool isPinSet = false.obs;
//   final RxBool isLoading = false.obs;
//   final RxBool showConfirmPin = false.obs;
//   final RxString initialPin = ''.obs;
  
//   @override
//   void onInit() {
//     super.onInit();
//     checkPinExists();
//   }
  
//   // Check if PIN is already set
//   Future<void> checkPinExists() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final savedPin = prefs.getString(PIN_KEY);
//       isPinSet.value = savedPin != null && savedPin.isNotEmpty;
//     } catch (e) {
//       print('Error checking PIN: $e');
//       isPinSet.value = false;
//     }
//   }
  
//   // Save new PIN
//   Future<bool> savePin(String pin) async {
//     try {
//       isLoading.value = true;
//       final prefs = await SharedPreferences.getInstance();
//       final success = await prefs.setString(PIN_KEY, pin);
      
//       if (success) {
//         isPinSet.value = true;
//       }
      
//       isLoading.value = false;
//       return success;
//     } catch (e) {
//       print('Error saving PIN: $e');
//       isLoading.value = false;
//       return false;
//     }
//   }
  
//   // Verify PIN
//   Future<bool> verifyPin(String enteredPin) async {
//     try {
//       isLoading.value = true;
//       final prefs = await SharedPreferences.getInstance();
//       final savedPin = prefs.getString(PIN_KEY);
      
//       await Future.delayed(const Duration(milliseconds: 500));
      
//       isLoading.value = false;
//       return savedPin == enteredPin;
//     } catch (e) {
//       print('Error verifying PIN: $e');
//       isLoading.value = false;
//       return false;
//     }
//   }
  
//   Future<bool> resetPin() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final success = await prefs.remove(PIN_KEY);
      
//       if (success) {
//         isPinSet.value = false;
//       }
      
//       return success;
//     } catch (e) {
//       print('Error resetting PIN: $e');
//       return false;
//     }
//   }
//     Future<String?> getSavedPin() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       return prefs.getString(PIN_KEY);
//     } catch (e) {
//       print('Error getting PIN: $e');
//       return null;
//     }
//   }
// }