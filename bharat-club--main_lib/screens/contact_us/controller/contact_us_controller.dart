import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:organization/api/api_call/api_impl.dart';
import 'package:organization/api/web_response.dart';
import 'package:organization/common/constant/web_constant.dart';
import 'package:organization/data/mode/cms_page/cms_page_request.dart';
import 'package:organization/data/mode/cms_page/contact_us_response.dart';

class ContactUsController extends GetxController {
  final TextEditingController mEmailController = TextEditingController();

  var emailValidator = false.obs;
  var contactUsValidator = false.obs;
  var mContactUsResponse = ContactUsResponse().obs;

  var isLoading = false.obs;

  Future<void> getContactUsApi() async {
    try {
      isLoading.value = true;

      CmsPageRequest mCmsPageRequest = CmsPageRequest(
        name: CmsPageRequestType.CONTACT.name,
      );

      WebResponseSuccess mWebResponseSuccess = await AllApiImpl().postCmsPage(
        mCmsPageRequest,
      );

      if (mWebResponseSuccess.statusCode == WebConstants.statusCode200) {
        mContactUsResponse.value = mWebResponseSuccess.data;
        contactUsValidator.value =
            (mContactUsResponse.value.data?.module ?? []).isNotEmpty;
      }
    } catch (e) {
      print("Error fetching Contact Us: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
