import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/utils/app_text.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;
  final bool showViewAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAllPressed,
    this.showViewAll = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 22.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: getTextSemiBold(
              colors: AppColors.secondaryGreen,
              size: 18.sp,
            ),
          ),
          if (showViewAll)
            TextButton(
              onPressed: onViewAllPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: getTextMedium(
                  colors: AppColors.black,
                  size: 14.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}