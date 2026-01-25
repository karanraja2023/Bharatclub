import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/utils/app_text.dart';

class SponsorItem extends StatelessWidget {
  final String imageUrl;
  final int index;
  final VoidCallback? onTap; // ✅ added callback

  const SponsorItem({
    super.key,
    required this.imageUrl,
    required this.index,
    this.onTap, // ✅ optional onTap
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // ✅ tap handler
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12.r,
              offset: Offset(0, 4.h),
              spreadRadius: 2.r,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.r),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: 120.h,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: double.infinity,
                height: 120.h,
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                        : null,
                    color: AppColors.secondaryGreen,
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: double.infinity,
                height: 120.h,
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.business, size: 40.sp, color: Colors.grey[400]),
                    SizedBox(height: 8.h),
                    Text(
                      'Sponsor ${index + 1}',
                      style: getTextSemiBold1(
                        size: 14.sp,
                        colors: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
