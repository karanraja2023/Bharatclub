import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:organization/alert/app_alert.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/common/widgets/banner_card.dart';
import 'package:organization/screens/contact_us/controller/contact_us_controller.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/message_constants.dart';
import 'package:organization/utils/network_util.dart';

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

  Future<void> _fetchContactData() async {
    try {
      if (kDebugMode) print('Fetching contact data...');
      bool isInternetAvailable = await NetworkUtils().checkInternetConnection();

      if (isInternetAvailable) {
        await controller.getContactUsApi();
        if (kDebugMode) print('Contact data fetched successfully');
      } else {
        if (mounted && Get.context != null) {
          AppAlert.showSnackBar(
            Get.context!,
            MessageConstants.noInternetConnection,
          );
        }
      }
    } catch (e) {
      if (kDebugMode) print('Error fetching contact data: $e');
      if (mounted && Get.context != null) {
        AppAlert.showSnackBar(
          Get.context!,
          'Error loading contact information: ${e.toString()}',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(title: "Contact Us"),
        body: Center(child: SizedBox.shrink()),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const CustomAppBar(title: "Contact Us"),
      body: FocusDetector(
        onVisibilityGained: () async {
          if (kDebugMode) print('ContactUsScreen visibility gained');
          if (_isInitialized && mounted) {
            await _fetchContactData();
          }
        },
        child: Obx(() {
          // Show loading indicator
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.cAppColorsBlue),
            );
          }

          return SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Card(
              elevation: 4,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              shadowColor: Colors.grey.withOpacity(0.3),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Banner with safe null handling
                    _buildBanner(),

                    SizedBox(height: 20.h),

                    // Club Name
                    Text(
                      _getClubName(),
                      style: getTextSemiBold(colors: Colors.black, size: 18.sp),
                    ),

                    SizedBox(height: 10.h),

                    // Address
                    Text(
                      _getAddress(),
                      style: getTextSemiBold(
                        colors: AppColors.cAppColorsBlue,
                        size: 16.sp,
                      ),
                    ),

                    SizedBox(height: 16.h),

                    Divider(thickness: 1, color: Colors.grey.withOpacity(0.3)),

                    SizedBox(height: 10.h),

                    // Phone Number
                    _buildContactRow(
                      icon: Icons.phone,
                      text: _getPhoneNumber(),
                    ),

                    SizedBox(height: 8.h),

                    // Email
                    _buildContactRow(
                      icon: Icons.email_outlined,
                      text: _getEmail(),
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

  Widget _buildBanner() {
    final bannerUrl = controller.contactUsValidator.value
        ? (controller
                  .mContactUsResponse
                  .value
                  .data
                  ?.cmsPageAttachments
                  ?.firstOrNull
                  ?.fileUrl ??
              "")
        : "";

    return BannerCard(bannerUrl: bannerUrl, height: 200.h, borderRadius: 12.r);
  }

  String _getClubName() {
    if (controller.contactUsValidator.value) {
      return controller
              .mContactUsResponse
              .value
              .data
              ?.module
              ?.firstOrNull
              ?.name ??
          "Welcome to Bharat Club";
    }
    return "Welcome to Bharat Club";
  }

  String _getAddress() {
    if (controller.contactUsValidator.value) {
      return controller
              .mContactUsResponse
              .value
              .data
              ?.module
              ?.firstOrNull
              ?.address ??
          "MALAYSIA - Kuala Lumpur";
    }
    return "MALAYSIA - Kuala Lumpur";
  }

  String _getPhoneNumber() {
    if (controller.contactUsValidator.value) {
      return controller
              .mContactUsResponse
              .value
              .data
              ?.module
              ?.firstOrNull
              ?.primaryMobile ??
          "+6 019 533 1794";
    }
    return "+6 019 533 1794";
  }

  String _getEmail() {
    if (controller.contactUsValidator.value) {
      return controller
              .mContactUsResponse
              .value
              .data
              ?.module
              ?.firstOrNull
              ?.email ??
          "clubbharat@gmail.com";
    }
    return "clubbharat@gmail.com";
  }

  Widget _buildContactRow({required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(icon, color: AppColors.cAppColorsBlue, size: 20),
        SizedBox(width: 10.w),
        Expanded(
          child: Text(
            text,
            style: getTextRegular(
              colors: AppColors.cAppColorsBlue,
              size: 15.sp,
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Don't dispose controller if it might be used elsewhere
    super.dispose();
  }
}
