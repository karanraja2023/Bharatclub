import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/controller/side_menu_contoller.dart';
import 'package:organization/data/local/shared_prefs/shared_prefs.dart';
import 'package:organization/screens/home/controller/home_controller.dart';
import 'package:organization/screens/qr_code_scan/view/qr_access_service.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/device_info_helper.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final String? route;
  final Color? iconColor;
  final bool adminOnly;
  final bool requiresQRVerification;

  MenuItem({
    required this.title,
    required this.icon,
    this.route,
    this.iconColor,
    this.adminOnly = false,
    this.requiresQRVerification = false,
  });
}

class MenuSection {
  final List<MenuItem> items;

  MenuSection({required this.items});
}

class CustomMenuDrawer extends StatefulWidget {
  const CustomMenuDrawer({super.key});

  @override
  State<CustomMenuDrawer> createState() => _CustomMenuDrawerState();
}

class _CustomMenuDrawerState extends State<CustomMenuDrawer>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late Animation<double> _logoAnimation;
  late CustomMenuDrawerController controller;
  final HomeController mHomeController = Get.find<HomeController>();

  String currentLogo = 'assets/images/logo.png';

  List<MenuSection> menuSections = [
    MenuSection(
      items: [
        MenuItem(
          title: 'Profile',
          icon: Icons.person_rounded,
          route: AppRoutes.profile,
          iconColor: AppColors.white,
        ),
        MenuItem(
          title: 'Membership',
          icon: Icons.card_membership_rounded,
          route: AppRoutes.membership,
          iconColor: AppColors.white,
        ),
        MenuItem(
          title: 'Home',
          icon: Icons.home_rounded,
          route: '/home',
          iconColor: AppColors.white,
        ),
        MenuItem(
          title: 'Events',
          icon: Icons.event_rounded,
          route: AppRoutes.events,
          iconColor: AppColors.white,
        ),
        MenuItem(
          title: 'QR Scanner',
          icon: Icons.qr_code_scanner,
          route: AppRoutes.qrCodeScanScreen,
          iconColor: AppColors.white,
          adminOnly: true,
          requiresQRVerification: true,
        ),
        MenuItem(
          title: 'Gallery',
          icon: Icons.photo_library_rounded,
          route: AppRoutes.gallery,
          iconColor: AppColors.white,
        ),
        MenuItem(
          title: 'Contact Us',
          icon: Icons.contact_mail_rounded,
          route: AppRoutes.contactUs,
          iconColor: AppColors.white,
        ),
        MenuItem(
          title: 'About Us',
          icon: Icons.info_rounded,
          route: AppRoutes.aboutus,
          iconColor: AppColors.white,
        ),
        MenuItem(
          title: 'Privacy Policy',
          icon: Icons.privacy_tip_rounded,
          route: AppRoutes.privacyPolicy,
          iconColor: AppColors.white,
        ),
      ],
    ),
  ];

  @override
  void initState() {
    super.initState();
    print('CustomMenuDrawer initState called');

    if (Get.isRegistered<CustomMenuDrawerController>()) {
      controller = Get.find<CustomMenuDrawerController>();
      print('Controller found');
    } else {
      controller = Get.put(CustomMenuDrawerController());
      print('Controller created');
    }

    _logoAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _logoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoAnimationController,
        curve: Curves.elasticOut,
      ),
    );
    _logoAnimationController.forward();
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    super.dispose();
  }

  bool _isActiveRoute(String? route) {
    if (route == null) return false;
    String currentRoute = Get.currentRoute;
    return currentRoute == route;
  }

  /// Handle menu item tap with QR verification
  Future<void> _handleMenuItemTap(
    MenuItem item,
    BuildContext ctx,
    HomeController mHomeController,
  ) async {
    // Unfocus before closing drawer
    FocusScope.of(ctx).unfocus();

    // Close drawer first
    if (Navigator.of(ctx).canPop()) {
      Navigator.of(ctx).pop();
    }
    // If item requires QR verification
    if (item.requiresQRVerification) {
      try {
        // Get device ID
        final deviceId = await DeviceInfoHelper.getDeviceId();

        // Verify access
        final hasAccess = await QRAccessService.verifyQRAccess(
          deviceId: deviceId,
        );

        if (hasAccess) {
          // Navigate to QR scanner
          Get.toNamed(AppRoutes.qrCodeScanScreen);
        } else {
          mHomeController.showAccessDeniedSnackbar();
        }
      } catch (e) {
        debugPrint('Error in QR verification: $e');
        Get.snackbar(
          'Error',
          'Failed to verify access. Please try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(16),
          borderRadius: 12,
        );
      }
    } else {
      // Small delay to ensure drawer is closed
      await Future.delayed(const Duration(milliseconds: 100));

      if (item.route != null) {
        Get.toNamed(item.route!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320.w,
      child: Drawer(
        backgroundColor: AppColors.secondaryGreen,
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              // Logo Section
              Container(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _logoAnimation.value,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.r),
                        child: Image.asset(
                          currentLogo,
                          width: 200.w,
                          height: 70.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.precision_manufacturing_outlined,
                              size: 28.sp,
                              color: AppColors.white,
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Menu Items
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  itemCount: menuSections.length,
                  itemBuilder: (context, sectionIndex) {
                    final section = menuSections[sectionIndex];
                    return Column(
                      children: section.items
                          .map((item) => _buildMenuItem(item))
                          .toList(),
                    );
                  },
                ),
              ),

              // Logout Button
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade800.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      height: 1,
                      margin: EdgeInsets.only(bottom: 16.h),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            Colors.grey.shade700.withValues(alpha: 0.3),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),

                    // Logout Button
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppColors.primaryGreen,
                            AppColors.secondaryGreen,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primaryGreen.withValues(
                              alpha: 0.25,
                            ),
                            blurRadius: 12,
                            offset: const Offset(0, 6),
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: AppColors.primaryGreen.withValues(
                              alpha: 0.1,
                            ),
                            blurRadius: 24,
                            offset: const Offset(0, 12),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () async {
                            Get.back();

                           mHomeController.logout();
                          },
                          borderRadius: BorderRadius.circular(16.r),
                          splashColor: AppColors.white.withValues(alpha: 0.2),
                          highlightColor: AppColors.white.withValues(
                            alpha: 0.1,
                          ),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 24.w,
                              vertical: 16.h,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.logout_rounded,
                                  color: AppColors.white,
                                  size: 22.sp,
                                ),
                                SizedBox(width: 12.w),
                                Text(
                                  'Logout',
                                  style: getTextBold(
                                    colors: AppColors.white,
                                    size: 16.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem(MenuItem item) {
    final isActive = _isActiveRoute(item.route);

    return Obx(() {
      if (controller.isLoading.value && item.adminOnly) {
        return const SizedBox.shrink();
      }

      if (item.adminOnly && !controller.adminStatus.value) {
        return const SizedBox.shrink();
      }

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 1.h),
        child: Material(
          color: AppColors.transparent,
          child: InkWell(
            onTap: () => _handleMenuItemTap(item, context, mHomeController),
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.white.withValues(alpha: 0.3)
                    : AppColors.transparent,
                borderRadius: BorderRadius.circular(10.r),
                border: isActive
                    ? Border.all(
                        color: AppColors.primaryGreen.withValues(alpha: 0.5),
                        width: 1.5,
                      )
                    : null,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(6.w),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white.withValues(alpha: 0.4)
                          : item.iconColor?.withValues(alpha: 0.2) ??
                                Colors.grey.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Icon(
                      item.icon,
                      color: isActive
                          ? AppColors.white
                          : item.iconColor ?? Colors.grey.shade400,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      item.title,
                      style: getTextSemiBold(
                        colors: isActive
                            ? AppColors.white
                            : Colors.grey.shade300,
                        size: 18.sp,
                      ),
                    ),
                  ),
                  if (isActive)
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.white,
                      size: 14.sp,
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
