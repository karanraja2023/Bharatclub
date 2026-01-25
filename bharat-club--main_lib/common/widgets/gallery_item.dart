import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GalleryItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int index;
  final VoidCallback? onTap;

  const GalleryItem({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.index,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: 'gallery_$index',
        child: Container(
          width: 160.w,
          margin: EdgeInsets.only(right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Image.network(
                  imageUrl,
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(height: 8.h),
            ],
          ),
        ),
      ),
    );
  }
}
