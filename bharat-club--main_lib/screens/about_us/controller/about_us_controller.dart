import 'package:get/get.dart';
import 'package:organization/api/api_call/api_impl.dart';
import 'package:organization/api/web_response.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/data/mode/cms_page/cms_page_request.dart';
import 'package:organization/screens/about_us/about_us_model.dart';

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
