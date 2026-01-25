import 'package:get/get.dart';
import 'package:organization/api/api_call/api_impl.dart';
import 'package:organization/api/web_response.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/data/mode/cms_page/cms_page_request.dart';
import 'package:organization/screens/gallery/model/gallery_model.dart';
import 'package:url_launcher/url_launcher.dart';

class GalleryController extends GetxController {
  var intGalleryCount = 0.obs;
  var sGalleryBannerImage = "".obs;
  var sGalleryTitle = "".obs;
  var sGalleryDec = "".obs;
  RxList<GalleryModule> mGalleryList = <GalleryModule>[].obs;

  /// new reactive states for Fullscreen viewer
  var currentIndex = 0.obs;
  var showControls = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  /// API call for gallery
  getGalleryUsApi() async {
    try {
      CmsPageRequest mCmsPageRequest =
          CmsPageRequest(name: CmsPageRequestType.GALLERY.name);
      WebResponseSuccess mWebResponseSuccess =
          await AllApiImpl().postCmsPage(mCmsPageRequest);

      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        GalleryResponse mGalleryResponse = mWebResponseSuccess.data;

        mGalleryList.clear();
        mGalleryList.addAll(mGalleryResponse.data?.module ?? []);
        intGalleryCount.value = mGalleryList.length;

        if ((mGalleryResponse.data?.cmsPageAttachments ?? []).isNotEmpty &&
            (mGalleryResponse.data?.cmsPageAttachments?.first.fileUrl ?? "")
                .isNotEmpty) {
          sGalleryBannerImage.value =
              (mGalleryResponse.data?.cmsPageAttachments?.first.fileUrl ?? "");
        }

        sGalleryTitle.value = mGalleryResponse.data?.title ?? "Gallery";
        sGalleryDec.value = mGalleryResponse.data?.content ?? "MOMENTS FOREVER";
      }
    } catch (e) {
      print("Error in getGalleryUsApi: $e");
    }
  }

  /// For web/video open
  void webView(String url) async {
    try {
      final Uri _url = Uri.parse(url);
      await launchUrl(_url);
    } catch (e) {
      print("Error launching URL: $e");
    }
  }

  /// new controller-managed functions
  void toggleControls() {
    showControls.value = !showControls.value;
  }

  void updateIndex(int index) {
    currentIndex.value = index;
  }
}
