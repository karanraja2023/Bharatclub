import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int index;
  final VoidCallback? onTap;
  final bool isWeb; // Added isWeb property

  const GalleryItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.index,
    this.onTap,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'gallery_$index',
        child: Container(
          // Lock width to 160px on web, use scaled width on mobile
          width: isWeb ? 160 : 160.w,
          margin: EdgeInsets.only(right: isWeb ? 16 : 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(isWeb ? 12 : 12.r),
                child: Image.network(
                  imageUrl,
                  // Maintain square aspect ratio
                  height: isWeb ? 160 : 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: isWeb ? 160 : 160.h,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
              // We keep the SizedBox height consistent
              SizedBox(height: isWeb ? 8 : 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
