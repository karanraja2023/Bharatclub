import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/screens/about_us/controller/about_us_controller.dart';
import 'package:organization/common/widgets/banner_card.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/common/widgets/loader.dart';
import 'package:organization/utils/network_util.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:organization/alert/app_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AboutUsController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppBar(title: 'About Us'),
      body: FocusDetector(
        onVisibilityGained: () async {
          bool isInternetAvailable = await NetworkUtils()
              .checkInternetConnection();
          if (isInternetAvailable) {
            await controller.getAboutUsApi();
          } else {
            AppAlert.showSnackBar(
              Get.context!,
              MessageConstants.noInternetConnection,
            );
          }
        },
        child: Obx(() {
          final aboutUs = controller.mAboutUsResponse.value;

          if (aboutUs == null || aboutUs.data == null) {
            return const CustomLoader();
          }

          final content = aboutUs.data!.content ?? "";
          List<String> paragraphs = _extractParagraphs(content);

          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Obx(
                () => BannerCard(bannerUrl: controller.aboutBannerImage.value),
              ),
              SizedBox(height: 20),
              ...paragraphs
                  .map((paragraph) => _buildParagraphCard(paragraph))
                  .toList(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildParagraphCard(String text) {
    bool isTitle = text.length < 50 || text.toLowerCase().contains('history');

    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        text,
        style: getTextMedium(
          size: isTitle ? 20.sp : 16.sp,
          colors: isTitle ? Colors.black87 : Colors.black87,
          heights: 1.5.sp,
        ),
      ),
    );
  }

  List<String> _extractParagraphs(String html) {
    List<String> paragraphs = [];
    RegExp pTagRegex = RegExp(r'<p[^>]*>(.*?)</p>', dotAll: true);
    Iterable<RegExpMatch> matches = pTagRegex.allMatches(html);

    for (var match in matches) {
      String content = match.group(1) ?? '';
      content = content
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .replaceAll('&rsquo;', "'")
          .replaceAll('&ldquo;', '"')
          .replaceAll('&rdquo;', '"')
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp;', '&')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();

      if (content.isNotEmpty) {
        paragraphs.add(content);
      }
    }
    if (paragraphs.isEmpty) {
      String cleanText = html
          .replaceAll(RegExp(r'<[^>]*>'), ' ')
          .replaceAll('&rsquo;', "'")
          .replaceAll('&ldquo;', '"')
          .replaceAll('&rdquo;', '"')
          .replaceAll('&nbsp;', ' ')
          .replaceAll('&amp;', '&')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim();
      paragraphs.add(cleanText);
    }

    return paragraphs;
  }
}
