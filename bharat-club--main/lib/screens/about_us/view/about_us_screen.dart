import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/screens/about_us/controller/about_us_controller.dart';
import 'package:mobileapp/common/widgets/banner_card.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/utils/app_text.dart';
import 'package:mobileapp/utils/message_constants.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/common/widgets/loader.dart';
import 'package:mobileapp/utils/network_util.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:mobileapp/alert/app_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class AboutUsScreen extends GetView<AboutUsController> {
//   const AboutUsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     Get.lazyPut(() => AboutUsController());
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: CustomAppBar(title: 'About Us'),
//       body: FocusDetector(
//         onVisibilityGained: () async {
//           bool isInternetAvailable = await NetworkUtils()
//               .checkInternetConnection();
//           if (isInternetAvailable) {
//             await controller.getAboutUsApi();
//           } else {
//             AppAlert.showSnackBar(
//               Get.context!,
//               MessageConstants.noInternetConnection,
//             );
//           }
//         },
//         child: Obx(() {
//           final aboutUs = controller.mAboutUsResponse.value;
//
//           if (aboutUs == null || aboutUs.data == null) {
//             return const CustomLoader();
//           }
//
//           final content = aboutUs.data!.content ?? "";
//           List<String> paragraphs = _extractParagraphs(content);
//
//           return ListView(
//             padding: EdgeInsets.all(16),
//             children: [
//               Obx(
//                 () => BannerCard(bannerUrl: controller.aboutBannerImage.value),
//               ),
//               SizedBox(height: 20),
//               ...paragraphs
//                   .map((paragraph) => _buildParagraphCard(paragraph))
//                   .toList(),
//             ],
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildParagraphCard(String text) {
//     bool isTitle = text.length < 50 || text.toLowerCase().contains('history');
//
//     return Container(
//       margin: EdgeInsets.only(bottom: 16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: Colors.grey.shade300, width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 4,
//             offset: Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Text(
//         text,
//         style: getTextMedium(
//           size: isTitle ? 20.sp : 16.sp,
//           colors: isTitle ? Colors.black87 : Colors.black87,
//           heights: 1.5.sp,
//         ),
//       ),
//     );
//   }
//
//   List<String> _extractParagraphs(String html) {
//     List<String> paragraphs = [];
//     RegExp pTagRegex = RegExp(r'<p[^>]*>(.*?)</p>', dotAll: true);
//     Iterable<RegExpMatch> matches = pTagRegex.allMatches(html);
//
//     for (var match in matches) {
//       String content = match.group(1) ?? '';
//       content = content
//           .replaceAll(RegExp(r'<[^>]*>'), '')
//           .replaceAll('&rsquo;', "'")
//           .replaceAll('&ldquo;', '"')
//           .replaceAll('&rdquo;', '"')
//           .replaceAll('&nbsp;', ' ')
//           .replaceAll('&amp;', '&')
//           .replaceAll(RegExp(r'\s+'), ' ')
//           .trim();
//
//       if (content.isNotEmpty) {
//         paragraphs.add(content);
//       }
//     }
//     if (paragraphs.isEmpty) {
//       String cleanText = html
//           .replaceAll(RegExp(r'<[^>]*>'), ' ')
//           .replaceAll('&rsquo;', "'")
//           .replaceAll('&ldquo;', '"')
//           .replaceAll('&rdquo;', '"')
//           .replaceAll('&nbsp;', ' ')
//           .replaceAll('&amp;', '&')
//           .replaceAll(RegExp(r'\s+'), ' ')
//           .trim();
//       paragraphs.add(cleanText);
//     }
//
//     return paragraphs;
//   }
// }


class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AboutUsController());

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint matching ProfileScreen
        bool isWeb = constraints.maxWidth >= 800;

        if (isWeb) {
          return Scaffold(
            backgroundColor: Colors.grey[200], // Background for web margins
            body: Center(
              child: Container(
                width: 500, // Matching ProfileScreen width
                height: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ClipRect(
                  child: aboutView(true),
                ),
              ),
            ),
          );
        } else {
          return aboutView(false);
        }
      },
    );
  }

  Widget aboutView(bool isWeb) {
    return Scaffold(
      backgroundColor: isWeb ? Colors.white : AppColors.background,
      appBar: CustomAppBar(
        title: 'About Us',
        isWeb: isWeb,
      ),
      body: FocusDetector(
        onVisibilityGained: () async {
          bool isInternetAvailable = await NetworkUtils().checkInternetConnection();
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
            padding: EdgeInsets.all(isWeb ? 16 : 16.w),
            children: [
              Obx(
                    () => BannerCard(
                  bannerUrl: controller.aboutBannerImage.value,
                  // Adjust height for web if needed
                  height: isWeb ? 200 : 200.h,
                ),
              ),
              SizedBox(height: isWeb ? 20 : 20.h),
              ...paragraphs
                  .map((paragraph) => _buildParagraphCard(paragraph, isWeb))
                  .toList(),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildParagraphCard(String text, bool isWeb) {
    // Simple logic to detect if a paragraph should act as a header
    bool isTitle = text.length < 60 || text.toLowerCase().contains('history');

    return Container(
      margin: EdgeInsets.only(bottom: isWeb ? 16 : 16.h),
      padding: EdgeInsets.all(isWeb ? 16 : 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isWeb ? 12 : 12.r),
        border: Border.all(color: Colors.grey.shade200, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: isWeb ? 8 : 8.r,
            offset: Offset(0, isWeb ? 4 : 4.h),
          ),
        ],
      ),
      child: Text(
        text,
        style: isTitle
            ? getTextBold(
          size: isWeb ? 18 : 18.sp,
          colors: Colors.black87,
        )
            : getTextMedium(
          size: isWeb ? 15 : 15.sp,
          colors: Colors.black54,
          heights: 1.5,
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
      content = _cleanHtmlContent(content);

      if (content.isNotEmpty) {
        paragraphs.add(content);
      }
    }

    if (paragraphs.isEmpty) {
      paragraphs.add(_cleanHtmlContent(html));
    }

    return paragraphs;
  }

  String _cleanHtmlContent(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]*>'), ' ')
        .replaceAll('&rsquo;', "'")
        .replaceAll('&ldquo;', '"')
        .replaceAll('&rdquo;', '"')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }
}