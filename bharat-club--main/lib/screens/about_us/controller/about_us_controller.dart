import 'package:get/get.dart';
import 'package:mobileapp/api/api_call/api_impl.dart';
import 'package:mobileapp/api/web_response.dart';
import 'package:mobileapp/common/constant/web_constant.dart';
import 'package:mobileapp/data/mode/cms_page/cms_page_request.dart';
import 'package:mobileapp/screens/about_us/about_us_model.dart';

class AboutUsController extends GetxController {
  var mAboutUsResponse = Rxn<AboutUsResponse>();
  var isLoading = false.obs;
  RxString aboutBannerImage = ''.obs;

  Future<void> getAboutUsApi() async {
    isLoading.value = true;

    CmsPageRequest mCmsPageRequest = CmsPageRequest(
      name: CmsPageRequestType.ABOUT_US.name,
    );

    try {
      WebResponseSuccess mWebResponseSuccess = await AllApiImpl().postCmsPage(
        mCmsPageRequest,
      );
      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        if (mWebResponseSuccess.data != null) {
          print("📦 Raw data type: ${mWebResponseSuccess.data.runtimeType}");
          print("📦 Raw data: ${mWebResponseSuccess.data}");
          if (mWebResponseSuccess.data is AboutUsResponse) {
            mAboutUsResponse.value =
                mWebResponseSuccess.data as AboutUsResponse;
          } else if (mWebResponseSuccess.data is Map) {
            mAboutUsResponse.value = AboutUsResponse.fromJson(
              mWebResponseSuccess.data,
            );
          } else {
            print(
              "⚠️ Unknown data type: ${mWebResponseSuccess.data.runtimeType}",
            );
          }
        } else {
          print("⚠️ AboutUs API returned null data");
        }
      } else {
        print("❌ API failed with status ${mWebResponseSuccess.statusCode}");
      }
    } catch (e, stackTrace) {
      print("Stack trace: $stackTrace");
    } finally {
      isLoading.value = false;
    }
  }
}
