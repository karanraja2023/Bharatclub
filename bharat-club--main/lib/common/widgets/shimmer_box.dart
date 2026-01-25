import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final bool isWeb; // Added isWeb property

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          // If a custom borderRadius is passed, we use it.
          // Otherwise, we default to 4px fixed for web or 4.r for mobile.
          borderRadius: borderRadius ?? BorderRadius.circular(isWeb ? 4 : 4.r),
        ),
      ),
    );
  }
}

class ProfileCardShimmer extends StatelessWidget {
  final bool isWeb; // Added isWeb property

  const ProfileCardShimmer({
    super.key,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(isWeb ? 16 : 16.w),
      padding: EdgeInsets.all(isWeb ? 16 : 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05), // Lighter shadow for shimmer
            blurRadius: isWeb ? 10 : 10.r,
            offset: Offset(0, isWeb ? 5 : 5.h),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // "Welcome back" text placeholder
                ShimmerBox(
                  width: isWeb ? 100 : 100.w,
                  height: isWeb ? 14 : 14.h,
                  isWeb: isWeb,
                ),
                SizedBox(height: isWeb ? 8 : 8.h),
                // User Name placeholder
                ShimmerBox(
                  width: isWeb ? 150 : 150.w,
                  height: isWeb ? 20 : 20.h,
                  isWeb: isWeb,
                ),
                SizedBox(height: isWeb ? 8 : 8.h),
                // Membership Type badge placeholder
                ShimmerBox(
                  width: isWeb ? 110 : 110.w,
                  height: isWeb ? 24 : 24.h,
                  borderRadius: BorderRadius.circular(isWeb ? 12 : 12.r),
                  isWeb: isWeb,
                ),
              ],
            ),
          ),
          // Profile Avatar placeholder
          ShimmerBox(
            width: isWeb ? 70 : 70.w,
            height: isWeb ? 70 : 70.h,
            borderRadius: BorderRadius.circular(isWeb ? 35 : 35.r),
            isWeb: isWeb,
          ),
        ],
      ),
    );
  }
}

class SectionShimmer extends StatelessWidget {
  final double itemWidth;
  final double itemHeight;
  final int itemCount;
  final bool isWeb; // Added isWeb property

  const SectionShimmer({
    Key? key,
    required this.itemWidth,
    required this.itemHeight,
    this.itemCount = 3,
    this.isWeb = false, // Default to false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: isWeb ? 8 : 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Shimmer (e.g., "Events" or "Gallery")
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: isWeb ? 16 : 16.w,
              vertical: isWeb ? 8 : 8.h,
            ),
            child: ShimmerBox(
              width: isWeb ? 100 : 100.w,
              height: isWeb ? 22 : 22.h,
              isWeb: isWeb,
            ),
          ),

          // Horizontal List of Item Shimmers
          SizedBox(
            height: itemHeight,
            // This is already passed as a fixed/scaled value from parent
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: isWeb ? 16 : 16.w),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: isWeb ? 16 : 16.w),
                  child: ShimmerBox(
                    width: itemWidth,
                    // Matches the width of actual Event/Gallery items
                    height: itemHeight,
                    borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
                    isWeb: isWeb,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SponsorShimmer extends StatelessWidget {
  final bool isWeb; // Added isWeb property

  const SponsorShimmer({
    super.key,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Title Shimmer
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWeb ? 16 : 16.w,
            vertical: isWeb ? 8 : 8.h,
          ),
          child: ShimmerBox(
            width: isWeb ? 130 : 130.w,
            height: isWeb ? 22 : 22.h,
            isWeb: isWeb,
          ),
        ),

        // Carousel Shimmer
        SizedBox(
          height: isWeb ? 120 : 120.h,
          child: Center(
            child: ShimmerBox(
              // On web, we match the 250px centered width logic
              width: isWeb ? 250 : 250.w,
              height: isWeb ? 100 : 100.h,
              borderRadius: BorderRadius.circular(isWeb ? 12 : 12.r),
              isWeb: isWeb,
            ),
          ),
        ),
      ],
    );
  }
}
