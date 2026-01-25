import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/utils/app_text.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onViewAllPressed;
  final bool showViewAll;
  final bool isWeb; // Added isWeb property

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAllPressed,
    this.showViewAll = true,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // Match the horizontal margins of your ProfileCard and Event lists
      padding: EdgeInsets.symmetric(horizontal: isWeb ? 22 : 22.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: getTextSemiBold(
              colors: AppColors.secondaryGreen,
              // Fixed size for web to maintain professional typography
              size: isWeb ? 18 : 18.sp,
            ),
          ),
          if (showViewAll)
            TextButton(
              onPressed: onViewAllPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(
                    horizontal: isWeb ? 8 : 8.w,
                    vertical: isWeb ? 4 : 4.h
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'View All',
                style: getTextMedium(
                  colors: AppColors.black,
                  size: isWeb ? 14 : 14.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }
}