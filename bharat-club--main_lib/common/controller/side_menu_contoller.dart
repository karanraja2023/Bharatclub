import 'package:get/get.dart';
import 'package:organization/data/local/shared_prefs/shared_prefs.dart';
import 'package:organization/data/mode/registration/registration_response.dart';

class CustomMenuDrawerController extends GetxController {
  RxBool adminStatus = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    getAdminStatus();
  }

  Future<void> getAdminStatus() async {
    try {
      isLoading.value = true;

      // Ensure SharedPrefs is initialized
      await SharedPrefs().sharedPreferencesInstance();

      RegistrationUser mRegistrationUser = await SharedPrefs().getUserDetails();
      adminStatus.value = mRegistrationUser.adminFlag == 1;

      print('Admin status loaded: ${adminStatus.value}');
    } catch (e) {
      adminStatus.value = false;
      print('Error getting admin status: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
