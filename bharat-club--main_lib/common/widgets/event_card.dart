import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/utils/app_text.dart';

class EventCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String date;
  final int index;
  final VoidCallback? onTap;

  const EventCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.date,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'event_$index',
        child: Container(
          width: 280.w,
          margin: EdgeInsets.only(right: 12.w), // Reduced from 16.w
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10.r,
                offset: Offset(0, 5.h),
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
                      top: Radius.circular(16.r),
                    ),
                    child: Image.network(
                      imageUrl,
                      height: 140.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                      child: Container(
                        height: 140.h,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.25),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 12.h,
                    right: 12.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        date,
                        style: getTextSemiBold(
                          size: 13.sp,
                          colors: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(12.w), 
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: getTextSemiBold(
                        colors: AppColors.black,
                        size: 16.sp,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      description,
                      style: getTextRegular(colors: AppColors.textPrimary),
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
