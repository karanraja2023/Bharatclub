import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/app_theme/theme/app_theme.dart';

class CarouselIndicators extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const CarouselIndicators({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        bool isActive = currentIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive ? 24.w : 8.w,
          height: 8.h,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            color: isActive
                ? AppColors.secondaryGreen
                : Colors.grey.withValues(alpha: 0.4),
          ),
        );
      }),
    );
  }
}