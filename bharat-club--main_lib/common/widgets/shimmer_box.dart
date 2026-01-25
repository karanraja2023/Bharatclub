import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerBox extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
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
          borderRadius: borderRadius ?? BorderRadius.circular(4.r),
        ),
      ),
    );
  }
}

class ProfileCardShimmer extends StatelessWidget {
  const ProfileCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10.r,
            offset: Offset(0, 5.h),
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
                ShimmerBox(width: 100.w, height: 14.h),
                SizedBox(height: 8.h),
                ShimmerBox(width: 150.w, height: 20.h),
                SizedBox(height: 8.h),
                ShimmerBox(
                  width: 110.w,
                  height: 24.h,
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ],
            ),
          ),
          ShimmerBox(
            width: 70.w,
            height: 70.h,
            borderRadius: BorderRadius.circular(35.r),
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

  const SectionShimmer({
    Key? key,
    required this.itemWidth,
    required this.itemHeight,
    this.itemCount = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: ShimmerBox(width: 100.w, height: 22.h),
          ),
          SizedBox(
            height: itemHeight,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: itemCount,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(right: 16.w),
                  child: ShimmerBox(
                    width: itemWidth,
                    height: itemHeight,
                    borderRadius: BorderRadius.circular(16.r),
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
  const SponsorShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: ShimmerBox(width: 130.w, height: 22.h),
        ),
        SizedBox(
          height: 120.h,
          child: Center(
            child: ShimmerBox(
              width: 250.w,
              height: 100.h,
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
      ],
    );
  }
}