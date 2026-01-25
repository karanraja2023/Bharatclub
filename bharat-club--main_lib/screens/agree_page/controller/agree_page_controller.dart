import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsAndConditionsController extends GetxController {



    void webView() async {
        String url = WebConstants.actionWebUrl;
    final Uri _url = Uri.parse(url);
    await launchUrl(_url);

    Future.delayed(Duration(milliseconds: 500), () {
    Get.offAllNamed(AppRoutes.loginScreen);
  });
  }
  
}
