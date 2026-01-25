// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:get/get.dart';
// import 'package:mobileapp/app/routes_name.dart';
// import 'package:mobileapp/app_theme/theme/app_theme.dart';
// import 'package:mobileapp/common/widgets/appbar.dart';
// import 'package:mobileapp/common/widgets/carousel_slider.dart';
// import 'package:mobileapp/common/widgets/event_card.dart';
// import 'package:mobileapp/common/widgets/gallery_item.dart';
// import 'package:mobileapp/common/widgets/profile_card.dart';
// import 'package:mobileapp/common/widgets/menu_drawer.dart';
// import 'package:mobileapp/common/widgets/section_header.dart';
// import 'package:mobileapp/common/widgets/shimmer_box.dart';
// import 'package:mobileapp/common/widgets/sponsor_item.dart';
// import 'package:mobileapp/screens/home/controller/home_controller.dart';
// import 'package:mobileapp/screens/membership/view/membership_expiry.dart';
// import '../../../alert/app_alert.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final CarouselSliderController _carouselController =
//       CarouselSliderController();
//   final HomeController controller = Get.put(HomeController());
//
//   @override
//   void initState() {
//     super.initState();
//     _loadData();
//   }
//
//   Future<void> _loadData() async {
//     await controller.membershipTypeLoad();
//   }
//
//   @override
//   void dispose() {
//     controller.stopTimer();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         if (constraints.maxWidth >= 800) {
//           return Scaffold(
//             // Add a scaffold background for the "letterbox" effect
//             backgroundColor: Colors.grey[200],
//             // Darker background for the web margins
//             body: Center(
//               child: Container(
//                 width: 500,
//                 // Standard mobile width feels better on web than 800
//                 height: double.infinity,
//                 decoration: BoxDecoration(
//                   boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
//                 ),
//                 child: ClipRect(
//                   // Keeps the UI inside the 500px bounds
//                   child: mobileView(),
//                 ),
//               ),
//             ),
//           );
//         } else {
//           return mobileView();
//         }
//       },
//     );
//   }
//
//   mobileView() {
//     return Obx(() {
//       if (controller.isLoading.value) {
//         return Scaffold(
//           backgroundColor: AppColors.background,
//           appBar: const CustomAppBar(
//             title: 'Bharat Club',
//             showMenu: true,
//             showBack: false,
//           ),
//           drawer: const CustomMenuDrawer(),
//           body: _buildShimmerLoading(),
//         );
//       }
//
//       if (controller.membershipExpired.value) {
//         return Scaffold(
//           backgroundColor: AppColors.background,
//           body: SafeArea(
//             child: MembershipExpiredPage(
//               onContactPressed: () => controller.handleContactSupport(),
//               onRenewPressed: () => controller.handleRenewMembership(),
//             ),
//           ),
//         );
//       }
//
//       return Scaffold(
//         backgroundColor: AppColors.background,
//         appBar: const CustomAppBar(
//           title: 'Bharat Club',
//           showMenu: true,
//           showBack: false,
//         ),
//         drawer: const CustomMenuDrawer(),
//         body: RefreshIndicator(
//           onRefresh: _handleRefresh,
//           color: AppColors.secondaryGreen,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: _buildContent(),
//           ),
//         ),
//       );
//     });
//   }
//
//   Widget _buildContent() {
//     return Column(
//       children: [
//         // Profile Card Section
//         Padding(
//           padding: EdgeInsets.only(top: 16.h, bottom: 8.h),
//           child: Obx(
//             () => ProfileCard(
//               welcomeText: 'Welcome back',
//               userName: controller.userName.value.isNotEmpty
//                   ? controller.userName.value
//                   : 'Guest User',
//               spouseName: controller.spouseName.value.isNotEmpty
//                   ? controller.spouseName.value
//                   : '--',
//               membershipId: controller.membershipId.value.isNotEmpty
//                   ? controller.membershipId.value
//                   : 'MemberId',
//               membershipType: controller.membershipType.value.isNotEmpty
//                   ? controller.membershipType.value
//                   : 'Member',
//               profileImageUrl: controller.photo.value.isNotEmpty
//                   ? controller.photo.value
//                   : 'https://picsum.photos/200',
//               membershipEndDate: controller.membershipEndDate.value.isNotEmpty
//                   ? controller.membershipEndDate.value
//                   : 'N/A',
//             ),
//           ),
//         ),
//
//         // Events Section
//         _buildEventsSection(),
//         SizedBox(height: 12.h),
//         // Gallery Section
//         _buildGallerySection(),
//         SizedBox(height: 12.h),
//         // Sponsors Section
//         _buildSponsorsCarousel(),
//         SizedBox(height: 24.h),
//       ],
//     );
//   }
//
//   Widget _buildShimmerLoading() {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           Padding(
//             padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
//             child: const ProfileCardShimmer(),
//           ),
//           SectionShimmer(itemWidth: 280.w, itemHeight: 220.h, itemCount: 3),
//           SizedBox(height: 16.h),
//           SectionShimmer(itemWidth: 160.w, itemHeight: 200.h, itemCount: 5),
//           SizedBox(height: 16.h),
//           const SponsorShimmer(),
//           SizedBox(height: 24.h),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _handleRefresh() async {
//     await controller.membershipTypeLoad();
//   }
//
//   Widget _buildEventsSection() {
//     return Obx(() {
//       final events = controller.mDashboardEventList;
//
//       if (events.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section Header
//           SectionHeader(
//             title: 'Events',
//             onViewAllPressed: () {
//               Get.toNamed(AppRoutes.events);
//             },
//           ),
//           SizedBox(height: 12.h),
//           // Events List
//           SizedBox(
//             height: 210.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               itemCount: events.length,
//               itemBuilder: (context, index) {
//                 final event = events[index];
//                 String imageUrl = 'https://picsum.photos/400/200';
//                 if (event.eventAttachments != null &&
//                     event.eventAttachments!.isNotEmpty) {
//                   imageUrl = event.eventAttachments!.first.fileUrl ?? imageUrl;
//                 }
//
//                 return Padding(
//                   padding: EdgeInsets.only(right: 12.w),
//                   child: EventCard(
//                     title: event.title ?? 'Event',
//                     description: event.description ?? '',
//                     imageUrl: imageUrl,
//                     date: event.startDate ?? '',
//                     index: index,
//                     onTap: () {
//                       _handleEventTap(event);
//                     },
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   void _handleEventTap(dynamic event) {
//     if (controller.membershipStatus.value) {
//       controller.checkEventAppliedStatus(event);
//     } else {
//       AppAlert.showSnackBar(Get.context!, "Please renew your membership");
//     }
//   }
//
//   Widget _buildGallerySection() {
//     return Obx(() {
//       final galleries = controller.mDashboardGalleryList;
//
//       if (galleries.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section Header
//           SectionHeader(
//             title: 'Gallery',
//             onViewAllPressed: () {
//               Get.toNamed(AppRoutes.gallery);
//             },
//           ),
//           SizedBox(height: 12.h),
//           // Gallery List
//           SizedBox(
//             height: 168.h,
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               padding: EdgeInsets.symmetric(horizontal: 16.w),
//               itemCount: galleries.length,
//               itemBuilder: (context, index) {
//                 final gallery = galleries[index];
//                 return Padding(
//                   padding: EdgeInsets.only(right: 12.w),
//                   child: GalleryItem(
//                     title: gallery.fileName ?? 'Gallery',
//                     imageUrl:
//                         gallery.fileUrl ?? 'https://picsum.photos/300/200',
//                     index: index,
//                     onTap: () =>
//                         Get.toNamed(AppRoutes.gallery, arguments: gallery),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       );
//     });
//   }
//
//   Widget _buildSponsorsCarousel() {
//     return Obx(() {
//       final sponsors = controller.mDashboardBeloBannerList;
//
//       if (sponsors.isEmpty) {
//         return const SizedBox.shrink();
//       }
//
//       return Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section Header
//           SectionHeader(title: 'Our Sponsors', showViewAll: false),
//           SizedBox(height: 16.h),
//
//           // Carousel
//           CarouselSlider(
//             carouselController: _carouselController,
//             options: CarouselOptions(
//               height: 100.h,
//               viewportFraction: 0.95,
//               autoPlay: true,
//               autoPlayInterval: const Duration(seconds: 4),
//               autoPlayAnimationDuration: const Duration(milliseconds: 800),
//               autoPlayCurve: Curves.fastOutSlowIn,
//               enlargeCenterPage: true,
//               enlargeFactor: 0.15,
//               padEnds: true,
//               onPageChanged: (index, reason) {
//                 controller.currentSponsorIndex.value = index;
//               },
//             ),
//             items: sponsors.asMap().entries.map((entry) {
//               final index = entry.key;
//               final sponsor = entry.value;
//               return SponsorItem(
//                 imageUrl: sponsor.image ?? 'https://picsum.photos/100/100',
//                 index: index,
//                 onTap: () {
//                   if (sponsor.redirectionUrl != null &&
//                       sponsor.redirectionUrl!.isNotEmpty) {
//                     controller.webView(sponsor.redirectionUrl!);
//                   }
//                 },
//               );
//             }).toList(),
//           ),
//           SizedBox(height: 12.h),
//           // Carousel Indicators
//           Obx(
//             () => CarouselIndicators(
//               itemCount: sponsors.length,
//               currentIndex: controller.currentSponsorIndex.value,
//             ),
//           ),
//         ],
//       );
//     });
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:mobileapp/app/routes_name.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/common/widgets/appbar.dart';
import 'package:mobileapp/common/widgets/carousel_slider.dart';
import 'package:mobileapp/common/widgets/event_card.dart';
import 'package:mobileapp/common/widgets/gallery_item.dart';
import 'package:mobileapp/common/widgets/profile_card.dart';
import 'package:mobileapp/common/widgets/menu_drawer.dart';
import 'package:mobileapp/common/widgets/section_header.dart';
import 'package:mobileapp/common/widgets/shimmer_box.dart';
import 'package:mobileapp/common/widgets/sponsor_item.dart';
import 'package:mobileapp/screens/home/controller/home_controller.dart';
import 'package:mobileapp/screens/membership/view/membership_expiry.dart';
import '../../../alert/app_alert.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await controller.membershipTypeLoad();
  }

  @override
  void dispose() {
    controller.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Breakpoint for Web/Tablet
        bool isWeb = constraints.maxWidth >= 800;

        if (isWeb) {
          return Scaffold(
            backgroundColor: Colors.grey[200], // Background for margins
            body: Center(
              child: Container(
                width: 500, // Fixed phone-style width on web
                height: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: ClipRect(child: mobileView(isWeb)),
              ),
            ),
          );
        } else {
          return mobileView(isWeb);
        }
      },
    );
  }

  Widget mobileView(bool isWeb) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: const CustomAppBar(
            title: 'Bharat Club',
            showMenu: true,
            showBack: false,
          ),
          drawer: CustomMenuDrawer(),
          body: _buildShimmerLoading(isWeb),
        );
      }

      if (controller.membershipExpired.value) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: MembershipExpiredPage(
              onContactPressed: () => controller.handleContactSupport(),
              onRenewPressed: () => controller.handleRenewMembership(),
            ),
          ),
        );
      }

      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: CustomAppBar(
          title: 'Bharat Club',
          showMenu: true,
          showBack: false,
          isWeb: isWeb,
        ),
        drawer: CustomMenuDrawer(),
        body: RefreshIndicator(
          onRefresh: _handleRefresh,
          color: AppColors.secondaryGreen,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: _buildContent(isWeb),
          ),
        ),
      );
    });
  }

  Widget _buildContent(bool isWeb) {
    return Column(
      children: [
        // Profile Card Section
        Padding(
          padding: EdgeInsets.only(
            top: isWeb ? 16 : 16.h,
            bottom: isWeb ? 8 : 8.h,
          ),
          child: Obx(
            () => ProfileCard(
              welcomeText: 'Welcome back',
              userName: controller.userName.value.isNotEmpty
                  ? controller.userName.value
                  : 'Guest User',
              spouseName: controller.spouseName.value.isNotEmpty
                  ? controller.spouseName.value
                  : '--',
              membershipId: controller.membershipId.value.isNotEmpty
                  ? controller.membershipId.value
                  : 'MemberId',
              membershipType: controller.membershipType.value.isNotEmpty
                  ? controller.membershipType.value
                  : 'Member',
              profileImageUrl: controller.photo.value.isNotEmpty
                  ? controller.photo.value
                  : 'https://picsum.photos/200',
              membershipEndDate: controller.membershipEndDate.value.isNotEmpty
                  ? controller.membershipEndDate.value
                  : 'N/A',
              isWeb: isWeb,
            ),
          ),
        ),

        _buildEventsSection(isWeb),
        SizedBox(height: isWeb ? 12 : 12.h),
        _buildGallerySection(isWeb),
        SizedBox(height: isWeb ? 12 : 12.h),
        _buildSponsorsCarousel(isWeb),
        SizedBox(height: isWeb ? 24 : 24.h),
      ],
    );
  }

  Widget _buildEventsSection(bool isWeb) {
    return Obx(() {
      final events = controller.mDashboardEventList;
      if (events.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Events',
            isWeb: isWeb,
            onViewAllPressed: () => Get.toNamed(AppRoutes.events),
          ),
          SizedBox(height: isWeb ? 12 : 12.h),
          SizedBox(
            height: isWeb ? 210 : 210.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: isWeb ? 16 : 16.w),
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                String imageUrl = 'https://picsum.photos/400/200';
                if (event.eventAttachments != null &&
                    event.eventAttachments!.isNotEmpty) {
                  imageUrl = event.eventAttachments!.first.fileUrl ?? imageUrl;
                }

                return Padding(
                  padding: EdgeInsets.only(right: isWeb ? 12 : 12.w),
                  child: EventCard(
                    title: event.title ?? 'Event',
                    isWeb: isWeb,
                    description: event.description ?? '',
                    imageUrl: imageUrl,
                    date: event.startDate ?? '',
                    index: index,
                    onTap: () => _handleEventTap(event),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildGallerySection(bool isWeb) {
    return Obx(() {
      final galleries = controller.mDashboardGalleryList;
      if (galleries.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Gallery',
            isWeb: isWeb,
            onViewAllPressed: () => Get.toNamed(AppRoutes.gallery),
          ),
          SizedBox(height: isWeb ? 12 : 12.h),
          SizedBox(
            height: isWeb ? 168 : 168.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: isWeb ? 16 : 16.w),
              itemCount: galleries.length,
              itemBuilder: (context, index) {
                final gallery = galleries[index];
                return Padding(
                  padding: EdgeInsets.only(right: isWeb ? 12 : 12.w),
                  child: GalleryItem(
                    isWeb: isWeb,
                    title: gallery.fileName ?? 'Gallery',
                    imageUrl:
                        gallery.fileUrl ?? 'https://picsum.photos/300/200',
                    index: index,
                    onTap: () =>
                        Get.toNamed(AppRoutes.gallery, arguments: gallery),
                  ),
                );
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildSponsorsCarousel(bool isWeb) {
    return Obx(() {
      final sponsors = controller.mDashboardBeloBannerList;
      if (sponsors.isEmpty) return const SizedBox.shrink();

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Our Sponsors',
            isWeb: isWeb,
            showViewAll: false,
          ),
          SizedBox(height: isWeb ? 16 : 16.h),
          CarouselSlider(
            carouselController: _carouselController,
            options: CarouselOptions(
              height: isWeb ? 100 : 100.h,
              viewportFraction: isWeb ? 0.9 : 0.95,
              autoPlay: true,
              enlargeCenterPage: true,
              onPageChanged: (index, _) =>
                  controller.currentSponsorIndex.value = index,
            ),
            items: sponsors.asMap().entries.map((entry) {
              return SponsorItem(
                imageUrl: entry.value.image ?? 'https://picsum.photos/100/100',
                isWeb: isWeb,
                index: entry.key,
                onTap: () {
                  if (entry.value.redirectionUrl?.isNotEmpty ?? false) {
                    controller.webView(entry.value.redirectionUrl!);
                  }
                },
              );
            }).toList(),
          ),
          SizedBox(height: isWeb ? 12 : 12.h),
          Obx(
            () => CarouselIndicators(
              itemCount: sponsors.length,
              currentIndex: controller.currentSponsorIndex.value,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildShimmerLoading(bool isWeb) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: isWeb ? 16 : 16.h),
            child: ProfileCardShimmer(isWeb: isWeb),
          ),
          SectionShimmer(
            itemWidth: isWeb ? 280 : 280.w,
            itemHeight: isWeb ? 220 : 220.h,
            itemCount: 3,
            isWeb: isWeb,
          ),
          SizedBox(height: isWeb ? 16 : 16.h),
          SectionShimmer(
            itemWidth: isWeb ? 160 : 160.w,
            itemHeight: isWeb ? 200 : 200.h,
            itemCount: 5,
            isWeb: isWeb,
          ),
          SizedBox(height: isWeb ? 16 : 16.h),
          SponsorShimmer(isWeb: isWeb),
        ],
      ),
    );
  }

  Future<void> _handleRefresh() async => await controller.membershipTypeLoad();

  void _handleEventTap(dynamic event) {
    if (controller.membershipStatus.value) {
      controller.checkEventAppliedStatus(event);
    } else {
      AppAlert.showSnackBar(Get.context!, "Please renew your membership");
    }
  }
}
