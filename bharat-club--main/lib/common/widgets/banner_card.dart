import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/common/constant/image_constants.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';

// class BannerCard extends StatelessWidget {
//   final String bannerUrl;
//   final double height;
//   final double borderRadius;
//
//   const BannerCard({
//     super.key,
//     required this.bannerUrl,
//     this.height = 180, // base height before scaling
//     this.borderRadius = 20,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: height.h, // 🔹 responsive height
//       width: 1.sw, // 🔹 full screen width
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(
//             borderRadius.r,
//           ), // 🔹 scaled radius
//           border: Border.all(color: Colors.grey.shade300, width: 1.w),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.15),
//               blurRadius: 10.r,
//               offset: Offset(0, 4.h),
//             ),
//           ],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(borderRadius.r),
//           child: Stack(
//             children: [
//               Positioned(
//                 right: -30.w,
//                 top: -30.h,
//                 child: Container(
//                   width: 150.w,
//                   height: 150.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.cAppColorsBlue.withOpacity(0.09),
//                   ),
//                 ),
//               ),
//               Positioned(
//                 left: -20.w,
//                 bottom: -20.h,
//                 child: Container(
//                   width: 100.w,
//                   height: 100.h,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: AppColors.cAppColorsBlue.withOpacity(0.09),
//                   ),
//                 ),
//               ),
//               Center(
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(500.r), // 🔹 very rounded
//                   child: SizedBox(
//                     height: height * 0.65.h, // 🔹 scaled height
//                     child: Padding(
//                       padding: EdgeInsets.all(16.w),
//                       child: bannerUrl.isEmpty
//                           ? Image.asset(
//                               ImageAssetsConstants.goParkingLogoJpg,
//                               fit: BoxFit.contain,
//                             )
//                           : CachedNetworkImage(
//                               imageUrl: bannerUrl,
//                               fit: BoxFit.contain,
//                               placeholder: (context, url) => Center(
//                                 child: CircularProgressIndicator(
//                                   color: AppColors.cAppColorsBlue,
//                                 ),
//                               ),
//                               errorWidget: (context, url, error) => Padding(
//                                 padding: EdgeInsets.all(16.w),
//                                 child: Image.asset(
//                                   ImageAssetsConstants.goParkingLogoJpg,
//                                   fit: BoxFit.contain,
//                                 ),
//                               ),
//                             ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class BannerCard extends StatelessWidget {
  final String bannerUrl;
  final double height;
  final double borderRadius;
  final bool isWeb;
  const BannerCard({
    super.key,
    required this.bannerUrl,
    this.height = 180,
    this.borderRadius = 20,
    this.isWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    // 🔹 Define the platform check once for the build method

    return SizedBox(
      height: isWeb ? height : height.h, // 🔹 Conditional scaling
      width: 1.sw,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isWeb ? borderRadius : borderRadius.r),
          border: Border.all(
            color: Colors.grey.shade300,
            width: isWeb ? 1 : 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: isWeb ? 10 : 10.r,
              offset: Offset(0, isWeb ? 4 : 4.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isWeb ? borderRadius : borderRadius.r),
          child: Stack(
            children: [
              // Background Decorative Circle (Top Right)
              Positioned(
                right: isWeb ? -30 : -30.w,
                top: isWeb ? -30 : -30.h,
                child: Container(
                  width: isWeb ? 150 : 150.w,
                  height: isWeb ? 150 : 150.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cAppColorsBlue.withOpacity(0.09),
                  ),
                ),
              ),
              // Background Decorative Circle (Bottom Left)
              Positioned(
                left: isWeb ? -20 : -20.w,
                bottom: isWeb ? -20 : -20.h,
                child: Container(
                  width: isWeb ? 100 : 100.w,
                  height: isWeb ? 100 : 100.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.cAppColorsBlue.withOpacity(0.09),
                  ),
                ),
              ),
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(isWeb ? 500 : 500.r),
                  child: SizedBox(
                    height: (isWeb ? height : height.h) * 0.65,
                    child: Padding(
                      padding: EdgeInsets.all(isWeb ? 16 : 16.w),
                      child: bannerUrl.isEmpty
                          ? Image.asset(
                        ImageAssetsConstants.goParkingLogoJpg,
                        fit: BoxFit.contain,
                      )
                          : CachedNetworkImage(
                        imageUrl: bannerUrl,
                        fit: BoxFit.contain,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.cAppColorsBlue,
                          ),
                        ),
                        errorWidget: (context, url, error) => Padding(
                          padding: EdgeInsets.all(isWeb ? 16 : 16.w),
                          child: Image.asset(
                            ImageAssetsConstants.goParkingLogoJpg,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
