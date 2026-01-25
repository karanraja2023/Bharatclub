import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/common/constant/image_constants.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';

class CompactBannerCard extends StatelessWidget {
  final String bannerUrl;
  final double? height;
  final double? width;
  final double borderRadius;
  final double? imagePadding;
  final double? imageHeightRatio;
  final BoxFit imageFit;
  final bool showDecorationCircles;

  const CompactBannerCard({
    super.key,
    required this.bannerUrl,
    this.height,
    this.width,
    this.borderRadius = 16,
    this.imagePadding,
    this.imageHeightRatio = 0.65,
    this.imageFit = BoxFit.contain,
    this.showDecorationCircles = true,
  });

  @override
  Widget build(BuildContext context) {
    final double finalHeight = height ?? 120;
    final double finalWidth = width ?? 1.sw;
    final double finalImagePadding = imagePadding ?? 12.w;

    return SizedBox(
      height: finalHeight.h,
      width: finalWidth.w,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius.r),
          border: Border.all(color: Colors.grey.shade300, width: 1.w),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 10.r,
              offset: Offset(0, 4.h),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(borderRadius.r),
          child: Stack(
            children: [
              // Bg decorative circles (optional)
              if (showDecorationCircles) ...[
                Positioned(
                  right: -30.w,
                  top: -30.h,
                  child: Container(
                    width: 150.w,
                    height: 150.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cAppColorsBlue.withOpacity(0.11),
                    ),
                  ),
                ),
                Positioned(
                  left: -20.w,
                  bottom: -20.h,
                  child: Container(
                    width: 100.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.cAppColorsBlue.withOpacity(0.11),
                    ),
                  ),
                ),
              ],
              Center(
                child: Padding(
                  padding: EdgeInsets.all(finalImagePadding),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: SizedBox(
                      height: (finalHeight * imageHeightRatio!).h,
                      child: bannerUrl.isEmpty
                          ? Image.asset(
                              ImageAssetsConstants.goParkingLogoJpg,
                              fit: imageFit,
                            )
                          : CachedNetworkImage(
                              imageUrl: bannerUrl,
                              fit: imageFit,
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.cAppColorsBlue,
                                  strokeWidth: 2.w,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                ImageAssetsConstants.goParkingLogoJpg,
                                fit: imageFit,
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
