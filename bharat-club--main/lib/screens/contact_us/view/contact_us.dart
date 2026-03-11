import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:mobileapp/alert/app_alert.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/common/widgets/banner_card.dart';
import 'package:mobileapp/screens/contact_us/controller/contact_us_controller.dart';
import 'package:mobileapp/utils/app_text.dart';
import 'package:mobileapp/utils/message_constants.dart';
import 'package:mobileapp/utils/network_util.dart';

// class ContactUsListScreen extends StatefulWidget {
//   const ContactUsListScreen({super.key});
//
//   @override
//   State<ContactUsListScreen> createState() => _ContactUsListScreenState();
// }
//
// class _ContactUsListScreenState extends State<ContactUsListScreen> {
//   late ContactUsController controller;
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
//       if (Get.isRegistered<ContactUsController>()) {
//         controller = Get.find<ContactUsController>();
//       } else {
//         controller = Get.put(ContactUsController());
//       }
//
//       _isInitialized = true;
//
//       if (mounted) {
//         await _fetchContactData();
//       }
//     } catch (e) {
//       if (kDebugMode) print('Error initializing controller: $e');
//       _isInitialized = true;
//     }
//   }
//
//   Future<void> _fetchContactData() async {
//     try {
//       if (kDebugMode) print('Fetching contact data...');
//       bool isInternetAvailable = await NetworkUtils().checkInternetConnection();
//
//       if (isInternetAvailable) {
//         await controller.getContactUsApi();
//         if (kDebugMode) print('Contact data fetched successfully');
//       } else {
//         if (mounted && Get.context != null) {
//           AppAlert.showSnackBar(
//             Get.context!,
//             MessageConstants.noInternetConnection,
//           );
//         }
//       }
//     } catch (e) {
//       if (kDebugMode) print('Error fetching contact data: $e');
//       if (mounted && Get.context != null) {
//         AppAlert.showSnackBar(
//           Get.context!,
//           'Error loading contact information: ${e.toString()}',
//         );
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (!_isInitialized) {
//       return const Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: CustomAppBar(title: "Contact Us"),
//         body: Center(child: SizedBox.shrink()),
//       );
//     }
//
//     return Scaffold(
//       backgroundColor: AppColors.background,
//       appBar: const CustomAppBar(title: "Contact Us"),
//       body: FocusDetector(
//         onVisibilityGained: () async {
//           if (kDebugMode) print('ContactUsScreen visibility gained');
//           if (_isInitialized && mounted) {
//             await _fetchContactData();
//           }
//         },
//         child: Obx(() {
//           // Show loading indicator
//           if (controller.isLoading.value) {
//             return const Center(
//               child: CircularProgressIndicator(color: AppColors.cAppColorsBlue),
//             );
//           }
//
//           return SingleChildScrollView(
//             padding: EdgeInsets.all(16.w),
//             child: Card(
//               elevation: 4,
//               color: Colors.white,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(16.r),
//               ),
//               shadowColor: Colors.grey.withOpacity(0.3),
//               child: Padding(
//                 padding: EdgeInsets.all(16.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Banner with safe null handling
//                     _buildBanner(),
//
//                     SizedBox(height: 20.h),
//
//                     // Club Name
//                     Text(
//                       _getClubName(),
//                       style: getTextSemiBold(colors: Colors.black, size: 18.sp),
//                     ),
//
//                     SizedBox(height: 10.h),
//
//                     // Address
//                     Text(
//                       _getAddress(),
//                       style: getTextSemiBold(
//                         colors: AppColors.cAppColorsBlue,
//                         size: 16.sp,
//                       ),
//                     ),
//
//                     SizedBox(height: 16.h),
//
//                     Divider(thickness: 1, color: Colors.grey.withOpacity(0.3)),
//
//                     SizedBox(height: 10.h),
//
//                     // Phone Number
//                     _buildContactRow(
//                       icon: Icons.phone,
//                       text: _getPhoneNumber(),
//                     ),
//
//                     SizedBox(height: 8.h),
//
//                     // Email
//                     _buildContactRow(
//                       icon: Icons.email_outlined,
//                       text: _getEmail(),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildBanner() {
//     final bannerUrl = controller.contactUsValidator.value
//         ? (controller
//                   .mContactUsResponse
//                   .value
//                   .data
//                   ?.cmsPageAttachments
//                   ?.firstOrNull
//                   ?.fileUrl ??
//               "")
//         : "";
//
//     return BannerCard(bannerUrl: bannerUrl, height: 200.h, borderRadius: 12.r);
//   }
//
//   String _getClubName() {
//     if (controller.contactUsValidator.value) {
//       return controller
//               .mContactUsResponse
//               .value
//               .data
//               ?.module
//               ?.firstOrNull
//               ?.name ??
//           "Welcome to Bharat Club";
//     }
//     return "Welcome to Bharat Club";
//   }
//
//   String _getAddress() {
//     if (controller.contactUsValidator.value) {
//       return controller
//               .mContactUsResponse
//               .value
//               .data
//               ?.module
//               ?.firstOrNull
//               ?.address ??
//           "MALAYSIA - Kuala Lumpur";
//     }
//     return "MALAYSIA - Kuala Lumpur";
//   }
//
//   String _getPhoneNumber() {
//     if (controller.contactUsValidator.value) {
//       return controller
//               .mContactUsResponse
//               .value
//               .data
//               ?.module
//               ?.firstOrNull
//               ?.primaryMobile ??
//           "+6 019 533 1794";
//     }
//     return "+6 019 533 1794";
//   }
//
//   String _getEmail() {
//     if (controller.contactUsValidator.value) {
//       return controller
//               .mContactUsResponse
//               .value
//               .data
//               ?.module
//               ?.firstOrNull
//               ?.email ??
//           "clubbharat@gmail.com";
//     }
//     return "clubbharat@gmail.com";
//   }
//
//   Widget _buildContactRow({required IconData icon, required String text}) {
//     return Row(
//       children: [
//         Icon(icon, color: AppColors.cAppColorsBlue, size: 20),
//         SizedBox(width: 10.w),
//         Expanded(
//           child: Text(
//             text,
//             style: getTextRegular(
//               colors: AppColors.cAppColorsBlue,
//               size: 15.sp,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   void dispose() {
//     // Don't dispose controller if it might be used elsewhere
//     super.dispose();
//   }
// }


class ContactUsListScreen extends StatefulWidget {
  const ContactUsListScreen({super.key});

  @override
  State<ContactUsListScreen> createState() => _ContactUsListScreenState();
}

class _ContactUsListScreenState extends State<ContactUsListScreen> {
  late ContactUsController controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeController();
  }

  void _initializeController() async {
    try {
      if (Get.isRegistered<ContactUsController>()) {
        controller = Get.find<ContactUsController>();
      } else {
        controller = Get.put(ContactUsController());
      }
      _isInitialized = true;
      if (mounted) {
        await _fetchContactData();
      }
    } catch (e) {
      if (kDebugMode) print('Error initializing controller: $e');
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(title: "Contact Us"),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Apply the same 800px logic from ProfileScreen
        bool isWeb = constraints.maxWidth >= 800;

        if (isWeb) {
          return Scaffold(
            backgroundColor: Colors.grey[200], // Darker background for margins
            body: Center(
              child: Container(
                width: 500, // Matching ProfileScreen width
                height: double.infinity,
                decoration: const BoxDecoration(
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                child: ClipRect(
                  child: contactView(true),
                ),
              ),
            ),
          );
        } else {
          return contactView(false);
        }
      },
    );
  }

  Widget contactView(bool isWeb) {
    return Scaffold(
      backgroundColor: isWeb ? Colors.white : AppColors.background,
      appBar: CustomAppBar(
        title: "Contact Us",
        isWeb: isWeb, // Supporting responsive app bar
      ),
      body: FocusDetector(
        onVisibilityGained: () async {
          if (_isInitialized && mounted) {
            await _fetchContactData();
          }
        },
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.cAppColorsBlue),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(isWeb ? 16 : 16.w),
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
              ),
              shadowColor: Colors.grey.withOpacity(0.3),
              child: Padding(
                padding: EdgeInsets.all(isWeb ? 16 : 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildBanner(isWeb),
                    SizedBox(height: isWeb ? 20 : 20.h),

                    // Club Name
                    Text(
                      _getClubName(),
                      style: getTextSemiBold(
                        colors: Colors.black,
                        size: isWeb ? 18 : 18.sp,
                      ),
                    ),
                    SizedBox(height: isWeb ? 10 : 10.h),

                    // Address
                    Text(
                      _getAddress(),
                      style: getTextSemiBold(
                        colors: AppColors.cAppColorsBlue,
                        size: isWeb ? 16 : 16.sp,
                      ),
                    ),
                    SizedBox(height: isWeb ? 16 : 16.h),

                    Divider(thickness: 1, color: Colors.grey.withOpacity(0.3)),
                    SizedBox(height: isWeb ? 10 : 10.h),

                    // Phone Number
                    _buildContactRow(
                      icon: Icons.phone,
                      text: _getPhoneNumber(),
                      isWeb: isWeb,
                    ),
                    SizedBox(height: isWeb ? 8 : 8.h),

                    // Email
                    _buildContactRow(
                      icon: Icons.email_outlined,
                      text: _getEmail(),
                      isWeb: isWeb,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- Helper Widgets with Responsive Unit Handling ---

  Widget _buildBanner(bool isWeb) {
    final bannerUrl = controller.contactUsValidator.value
        ? (controller.mContactUsResponse.value.data?.cmsPageAttachments?.firstOrNull?.fileUrl ?? "")
        : "";

    return BannerCard(
      bannerUrl: bannerUrl,
      height: isWeb ? 200 : 200.h,
      borderRadius: isWeb ? 12 : 12.r,
      isWeb: isWeb,
    );
  }

  Widget _buildContactRow({required IconData icon, required String text, required bool isWeb}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cAppColorsBlue, size: isWeb ? 20 : 20.sp),
        SizedBox(width: isWeb ? 10 : 10.w),
        Expanded(
          child: Text(
            text,
            style: getTextRegular(
              colors: AppColors.cAppColorsBlue,
              size: isWeb ? 15 : 15.sp,
            ),
          ),
        ),
      ],
    );
  }

  // --- Logic and Data Handlers ---

  Future<void> _fetchContactData() async {
    try {
      bool isInternetAvailable = await NetworkUtils().checkInternetConnection();
      if (isInternetAvailable) {
        await controller.getContactUsApi();
      } else {
        if (mounted && Get.context != null) {
          AppAlert.showSnackBar(Get.context!, MessageConstants.noInternetConnection);
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching contact data: $e');
    }
  }

  String _getClubName() {
    if (controller.contactUsValidator.value) {
      return controller.mContactUsResponse.value.data?.module?.firstOrNull?.name ?? "Welcome to Bharat Club";
    }
    return "Welcome to Bharat Club";
  }

  String _getAddress() {
    if (controller.contactUsValidator.value) {
      return controller.mContactUsResponse.value.data?.module?.firstOrNull?.address ?? "MALAYSIA - Kuala Lumpur";
    }
    return "MALAYSIA - Kuala Lumpur";
  }

  String _getPhoneNumber() {
    if (controller.contactUsValidator.value) {
      return controller.mContactUsResponse.value.data?.module?.firstOrNull?.primaryMobile ?? "+6 019 533 1794";
    }
    return "+6 019 533 1794";
  }

  String _getEmail() {
    if (controller.contactUsValidator.value) {
      return controller.mContactUsResponse.value.data?.module?.firstOrNull?.email ?? "clubbharat@gmail.com";
    }
    return "clubbharat@gmail.com";
  }
}