import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/utils/app_text.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final int index;
  final VoidCallback? onTap;
  final bool isWeb; // Added isWeb property

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.index,
    this.onTap,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'event_$index',
        child: Container(
          // Lock width on web so the card doesn't stretch
          width: isWeb ? 280 : 280.w,
          margin: EdgeInsets.only(right: isWeb ? 12 : 12.w),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: isWeb ? 10 : 10.r,
                offset: Offset(0, isWeb ? 5 : 5.h),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  // Event image
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(isWeb ? 16 : 16.r),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: isWeb ? 140 : 140.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(isWeb ? 16 : 16.r),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                  // Date Tag
                  Positioned(
                    top: isWeb ? 12 : 12.h,
                    right: isWeb ? 12 : 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWeb ? 8 : 8.w,
                        vertical: isWeb ? 4 : 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(isWeb ? 12 : 12.r),
                      ),
                      child: Text(
                        date,
                        style: getTextSemiBold(
                          size: isWeb ? 13 : 13.sp,
                          colors: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(isWeb ? 12 : 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: getTextSemiBold(
                        colors: AppColors.black,
                        size: isWeb ? 16 : 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: isWeb ? 4 : 4.h),
                    Text(
                      description,
                      style: getTextRegular(
                        colors: AppColors.textPrimary,
                        size: isWeb ? 14 : 14.sp, // Explicit size for consistency
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
}
