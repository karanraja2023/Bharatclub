import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/utils/app_text.dart';

class SponsorItem extends StatelessWidget {
  final String imageUrl;
  final int index;
  final VoidCallback? onTap;
  final bool isWeb; // Added isWeb property

  const SponsorItem({
    super.key,
    required this.imageUrl,
    required this.index,
    this.onTap,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    // Set a base height for web vs mobile
    final double itemHeight = isWeb ? 120 : 120.h;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: isWeb ? 8 : 8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: isWeb ? 12 : 12.r,
              offset: Offset(0, isWeb ? 4 : 4.h),
              spreadRadius: isWeb ? 2 : 2.r,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
          child: Image.network(
            imageUrl,
            width: double.infinity,
            height: itemHeight,
            // BoxFit.contain is often better for logos to avoid cropping
            fit: isWeb ? BoxFit.contain : BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                width: double.infinity,
                height: itemHeight,
                color: Colors.grey[200],
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
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
                height: itemHeight,
                color: Colors.grey[200],
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                        Icons.business,
                        size: isWeb ? 40 : 40.sp,
                        color: Colors.grey[400]
                    ),
                    SizedBox(height: isWeb ? 8 : 8.h),
                    Text(
                      'Sponsor ${index + 1}',
                      style: getTextSemiBold(
                        size: isWeb ? 14 : 14.sp,
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
