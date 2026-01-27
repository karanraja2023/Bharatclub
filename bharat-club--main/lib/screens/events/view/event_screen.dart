import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/constant/custom_image.dart';
import 'package:mobileapp/common/constant/image_constants.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/common/widgets/banner_card.dart';
import 'package:mobileapp/data/mode/cms_page/event_response.dart';
import 'package:mobileapp/utils/app_text.dart';
import 'package:mobileapp/utils/message_constants.dart';
import 'package:mobileapp/utils/network_util.dart';
import '../../../alert/app_alert.dart';
import '../controller/event_controller.dart';
import 'package:flutter/foundation.dart';

// class EventScreen extends StatefulWidget {
//   const EventScreen({super.key});
//
//   @override
//   State<EventScreen> createState() => _EventScreenState();
// }
//
// class _EventScreenState extends State<EventScreen> {
//   late EventController controller;
//   bool _isInitialized = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeController();
//   }
//
//   void _initializeController() async {
//     try {
//       if (Get.isRegistered<EventController>()) {
//         controller = Get.find<EventController>();
//       } else {
//         controller = Get.put(EventController());
//       }
//
//       _isInitialized = true;
//
//       if (mounted) {
//         await _fetchEventData();
//       }
//     } catch (e) {
//       if (kDebugMode) print('Error initializing controller: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized) {
//       return const Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: CustomAppBar(title: 'Events'),
//         body: Center(child: SizedBox.shrink()),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: const CustomAppBar(title: 'Events'),
//       body: FocusDetector(
//         onVisibilityGained: () async {
//           if (kDebugMode) print('EventScreen visibility gained');
//           if (_isInitialized && mounted && controller.hasLoadedOnce.value) {
//             await _fetchEventData();
//           }
//         },
//         child: Obx(() {
//           return Container(
//             height: 0.85.sh,
//             width: 1.sw,
//             padding: EdgeInsets.all(13.w),
//             margin: EdgeInsets.all(13.w),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10.r),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.grey.withOpacity(0.4),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: const Offset(0, 1),
//                 ),
//               ],
//             ),
//             child: eventView(),
//           );
//         }),
//       ),
//     );
//   }
//
//   Future<void> _fetchEventData() async {
//     try {
//       if (kDebugMode) print('Fetching event data...');
//       bool isInternetAvailable = await NetworkUtils().checkInternetConnection();
//
//       if (isInternetAvailable) {
//         await controller.getEventUsApi();
//         if (kDebugMode) print('Event data fetched successfully');
//       } else {
//         if (mounted && Get.context != null) {
//           AppAlert.showSnackBar(
//             Get.context!,
//             MessageConstants.noInternetConnection,
//           );
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) print('Error fetching event data: $e');
//       if (mounted && Get.context != null) {
//         AppAlert.showSnackBar(
//           Get.context!,
//           'Error loading events: ${e.toString()}',
//         );
//       }
//     }
//   }
//
//   Widget eventView() {
//     return SingleChildScrollView(
//       padding: EdgeInsets.zero,
//       child: Column(
//         children: [
//           // Banner
//           BannerCard(bannerUrl: controller.sEventBannerImage.value),
//
//           SizedBox(height: 5.h),
//
//           // HTML Content with custom text styling
//           _buildStyledContent(controller.sEventDec.value),
//
//           SizedBox(height: 5.h),
//
//           // Event List
//           controller.intEventCount.value > 0
//               ? ListView.builder(
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: controller.mEventList.length,
//                   padding: EdgeInsets.zero,
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     EventModule mEventModule = controller.mEventList[index];
//                     return GestureDetector(
//                       onTap: () =>
//                           controller.checkEventAppliedStatus(mEventModule),
//                       child: Container(
//                         height: 160.h,
//                         margin: EdgeInsets.all(5.w),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(10.r),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.grey.withOpacity(0.4),
//                               spreadRadius: 2,
//                               blurRadius: 3,
//                               offset: const Offset(0, 1),
//                             ),
//                           ],
//                         ),
//                         child: Stack(
//                           children: [
//                             _generateEvent(mEventModule),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.35),
//                                 borderRadius: BorderRadius.circular(10.r),
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.all(15.w),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     mEventModule.title ?? "",
//                                     style: getTextSemiBold(
//                                       colors: Colors.white,
//                                       size: 16.sp,
//                                     ),
//                                   ),
//                                   SizedBox(height: 4.h),
//                                   Text(
//                                     mEventModule.description ?? "",
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: getTextSemiBold(
//                                       colors: Colors.white,
//                                       size: 13.sp,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Positioned(
//                               right: 15.w,
//                               bottom: 15.h,
//                               child: Text(
//                                 mEventModule.endDate ?? "",
//                                 style: getTextSemiBold(
//                                   colors: Colors.white,
//                                   size: 15.sp,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 )
//               : SizedBox(
//                   height: 250.h,
//                   child: Center(
//                     child: Text(
//                       "No data found",
//                       style: getTextSemiBold(
//                         colors: AppColors.cAppColorsBlue,
//                         size: 18.sp,
//                       ),
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStyledContent(String htmlContent) {
//     if (htmlContent.isEmpty) {
//       return const SizedBox.shrink();
//     }
//
//     // Parse HTML content and convert to structured text with bullet points
//     List<ContentItem> contentItems = _parseHtmlContent(htmlContent);
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: contentItems.map((item) {
//         if (item.isBullet) {
//           return Padding(
//             padding: EdgeInsets.only(left: 10.w, bottom: 8.h),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 6.h, right: 8.w),
//                   child: Container(
//                     width: 5.w,
//                     height: 5.w,
//                     decoration: const BoxDecoration(
//                       color: Colors.black87,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//                 ),
//                 Expanded(
//                   child: Text(
//                     item.text,
//                     style: getTextRegular(
//                       colors: Colors.black87,//function
//                       size: 15.sp,
//                       heights: 1.5,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else if (item.isHeading) {
//           return Padding(
//             padding: EdgeInsets.only(bottom: 8.h, top: 5.h),
//             child: Text(
//               item.text,
//               style: getTextSemiBold(
//                 colors: Colors.black,
//                 size: 17.sp,
//                 heights: 1.4,
//               ),
//             ),
//           );
//         } else {
//           return Padding(
//             padding: EdgeInsets.only(bottom: 8.h),
//             child: Text(
//               item.text,
//               style: getTextSemiBold(
//                 colors: Colors.black87,//chnage
//                 size: 16.sp,
//                 heights: 1.5,
//               ),
//               textAlign: TextAlign.left,
//             ),
//           );
//         }
//       }).toList(),
//     );
//   }
//
//   List<ContentItem> _parseHtmlContent(String htmlContent) {
//     List<ContentItem> items = [];
//
//     // Remove script and style tags
//     htmlContent = htmlContent.replaceAll(
//       RegExp(r'<script[^>]*>.*?</script>', dotAll: true),
//       '',
//     );
//     htmlContent = htmlContent.replaceAll(
//       RegExp(r'<style[^>]*>.*?</style>', dotAll: true),
//       '',
//     );
//
//     // Split by common block elements
//     List<String> blocks = htmlContent.split(
//       RegExp(r'</(?:p|div|li|h[1-6])>', caseSensitive: false),
//     );
//
//     for (String block in blocks) {
//       if (block.trim().isEmpty) continue;
//
//       // Check if it's a list item
//       bool isBullet = block.contains(
//         RegExp(r'<li[^>]*>', caseSensitive: false),
//       );
//
//       // Check if it's a heading
//       bool isHeading = block.contains(
//         RegExp(r'<h[1-6][^>]*>', caseSensitive: false),
//       );
//
//       // Strip all HTML tags
//       String text = _stripHtmlTags(block);
//
//       if (text.trim().isNotEmpty) {
//         items.add(
//           ContentItem(
//             text: text.trim(),
//             isBullet: isBullet,
//             isHeading: isHeading,
//           ),
//         );
//       }
//     }
//
//     return items;
//   }
//
//   String _stripHtmlTags(String htmlString) {
//     // Remove HTML tags
//     RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: false);
//     String result = htmlString.replaceAll(exp, '');
//
//     // Decode HTML entities
//     result = result
//         .replaceAll('&nbsp;', ' ')
//         .replaceAll('&amp;', '&')
//         .replaceAll('&lt;', '<')
//         .replaceAll('&gt;', '>')
//         .replaceAll('&quot;', '"')
//         .replaceAll('&#39;', "'")
//         .replaceAll('&rdquo;', '"')
//         .replaceAll('&ldquo;', '"')
//         .replaceAll('&rsquo;', "'")
//         .replaceAll('&lsquo;', "'")
//         .replaceAll('&bull;', '•')
//         .replaceAll('&middot;', '·');
//
//     // Clean up extra whitespace
//     result = result.replaceAll(RegExp(r'\s+'), ' ').trim();
//
//     return result;
//   }
//
//   Widget _generateEvent(EventModule mEventModule) {
//     final imageUrl = mEventModule.eventAttachments?.first.fileUrl ?? '';
//     return Positioned.fill(
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(10.r),
//         child: cacheImageBannerExploreOurProgram(
//           imageUrl,
//           ImageAssetsConstants.goParkingLogoJpg,
//         ),
//       ),
//     );
//   }
// }

// Helper class for content items


class EventScreen extends StatefulWidget {
  const EventScreen({super.key});

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  late EventController controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() async {
    try {
      if (Get.isRegistered<EventController>()) {
        controller = Get.find<EventController>();
      } else {
        controller = Get.put(EventController());
      }

      _isInitialized = true;

      if (mounted) {
        await _fetchEventData();
      }
    } catch (e) {
      if (kDebugMode) print('Error initializing controller: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(title: 'Events'),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint matching ProfileScreen
        bool isWeb = constraints.maxWidth >= 800;

        if (isWeb) {
          return Scaffold(
            backgroundColor: Colors.grey[200], // Margin color for Web
            body: Center(
              child: Container(
                width: 500, // Matching ProfileScreen container width
                height: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ClipRect(
                  child: eventMainView(true),
                ),
              ),
            ),
          );
        } else {
          return eventMainView(false);
        }
      },
    );
  }

  Widget eventMainView(bool isWeb) {
    return Scaffold(
      backgroundColor: isWeb ? Colors.white : AppColors.background,
      appBar: CustomAppBar(
        title: 'Events',
        isWeb: isWeb,
      ),
      body: FocusDetector(
        onVisibilityGained: () async {
          if (_isInitialized && mounted && controller.hasLoadedOnce.value) {
            await _fetchEventData();
          }
        },
        child: Obx(() {
          return Container(
            height: isWeb ? double.infinity : 0.85.sh,
            width: double.infinity,
            padding: EdgeInsets.all(isWeb ? 13 : 13.w),
            margin: EdgeInsets.all(isWeb ? 13 : 13.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(isWeb ? 10 : 10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.4),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: eventListView(isWeb),
          );
        }),
      ),
    );
  }

  Widget eventListView(bool isWeb) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          // Banner
          BannerCard(bannerUrl: controller.sEventBannerImage.value),

          SizedBox(height: isWeb ? 15 : 5.h),

          // HTML Content
          _buildStyledContent(controller.sEventDec.value, isWeb),

          SizedBox(height: isWeb ? 15 : 5.h),

          // Event List
          controller.intEventCount.value > 0
              ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.mEventList.length,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              EventModule mEventModule = controller.mEventList[index];
              return _buildEventItem(mEventModule, isWeb);
            },
          )
              : _buildNoData(isWeb),
        ],
      ),
    );
  }

  Widget _buildEventItem(EventModule mEventModule, bool isWeb) {
    return GestureDetector(
      onTap: () => controller.checkEventAppliedStatus(mEventModule),
      child: Container(
        height: isWeb ? 160 : 160.h,
        margin: EdgeInsets.all(isWeb ? 5 : 5.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isWeb ? 10 : 10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Stack(
          children: [
            _generateEvent(mEventModule, isWeb),
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.35),
                borderRadius: BorderRadius.circular(isWeb ? 10 : 10.r),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(isWeb ? 15 : 15.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mEventModule.title ?? "",
                    style: getTextSemiBold(
                      colors: Colors.white,
                      size: isWeb ? 16 : 16.sp,
                    ),
                  ),
                  SizedBox(height: isWeb ? 4 : 4.h),
                  Text(
                    mEventModule.description ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getTextSemiBold(
                      colors: Colors.white,
                      size: isWeb ? 13 : 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: isWeb ? 15 : 15.w,
              bottom: isWeb ? 15 : 15.h,
              child: Text(
                mEventModule.endDate ?? "",
                style: getTextSemiBold(
                  colors: Colors.white,
                  size: isWeb ? 15 : 15.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStyledContent(String htmlContent, bool isWeb) {
    if (htmlContent.isEmpty) return const SizedBox.shrink();
    List<ContentItem> contentItems = _parseHtmlContent(htmlContent);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: contentItems.map((item) {
        if (item.isBullet) {
          return Padding(
            padding: EdgeInsets.only(left: isWeb ? 10 : 10.w, bottom: isWeb ? 8 : 8.h),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: isWeb ? 6 : 6.h, right: isWeb ? 8 : 8.w),
                  child: Container(
                    width: isWeb ? 5 : 5.w,
                    height: isWeb ? 5 : 5.w,
                    decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                  ),
                ),
                Expanded(
                  child: Text(
                    item.text,
                    style: getTextRegular(colors: Colors.black87, size: isWeb ? 15 : 15.sp, heights: 1.5),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.only(bottom: isWeb ? 8 : 8.h),
            child: Text(
              item.text,
              style: item.isHeading
                  ? getTextSemiBold(colors: Colors.black, size: isWeb ? 17 : 17.sp, heights: 1.4)
                  : getTextSemiBold(colors: Colors.black87, size: isWeb ? 16 : 16.sp, heights: 1.5),
              textAlign: TextAlign.left,
            ),
          );
        }
      }).toList(),
    );
  }

  Widget _buildNoData(bool isWeb) {
    return SizedBox(
      height: isWeb ? 250 : 250.h,
      child: Center(
        child: Text(
          "No data found",
          style: getTextSemiBold(colors: AppColors.cAppColorsBlue, size: isWeb ? 18 : 18.sp),
        ),
      ),
    );
  }

  Widget _generateEvent(EventModule mEventModule, bool isWeb) {
    final imageUrl = mEventModule.eventAttachments?.first.fileUrl ?? '';
    return Positioned.fill(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isWeb ? 10 : 10.r),
        child: cacheImageBannerExploreOurProgram(
          imageUrl,
          ImageAssetsConstants.goParkingLogoJpg,
        ),
      ),
    );
  }

  // --- Logic Methods ---

  Future<void> _fetchEventData() async {
    try {
      bool isInternetAvailable = await NetworkUtils().checkInternetConnection();
      if (isInternetAvailable) {
        await controller.getEventUsApi();
      } else {
        if (mounted && Get.context != null) {
          AppAlert.showSnackBar(Get.context!, MessageConstants.noInternetConnection);
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching events: $e');
    }
  }

  List<ContentItem> _parseHtmlContent(String htmlContent) {
    List<ContentItem> items = [];
    htmlContent = htmlContent.replaceAll(RegExp(r'<(script|style)[^>]*>.*?</\1>', dotAll: true), '');
    List<String> blocks = htmlContent.split(RegExp(r'</(?:p|div|li|h[1-6])>'));

    for (String block in blocks) {
      if (block.trim().isEmpty) continue;
      bool isBullet = block.contains(RegExp(r'<li[^>]*>'));
      bool isHeading = block.contains(RegExp(r'<h[1-6][^>]*>'));
      String text = _stripHtmlTags(block);
      if (text.trim().isNotEmpty) {
        items.add(ContentItem(text: text.trim(), isBullet: isBullet, isHeading: isHeading));
      }
    }
    return items;
  }

  String _stripHtmlTags(String htmlString) {
    String result = htmlString.replaceAll(RegExp(r"<[^>]*>"), '');
    result = result
        .replaceAll('&nbsp;', ' ').replaceAll('&amp;', '&')
        .replaceAll('&quot;', '"').replaceAll('&#39;', "'")
        .replaceAll('&rdquo;', '"').replaceAll('&ldquo;', '"')
        .replaceAll('&rsquo;', "'").replaceAll('&bull;', '•');
    return result.replaceAll(RegExp(r'\s+'), ' ').trim();
  }
}

class ContentItem {
  final String text;
  final bool isBullet;
  final bool isHeading;

  ContentItem({
    required this.text,
    this.isBullet = false,
    this.isHeading = false,
  });
}
