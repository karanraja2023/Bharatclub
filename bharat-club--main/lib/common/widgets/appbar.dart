import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/utils/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showMenu;
  final VoidCallback? onBack;
  final VoidCallback? onBackPressed;
  final bool isWeb; // Added isWeb property

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.showMenu = false,
    this.onBack,
    this.onBackPressed,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(isWeb ? 24 : 24.r),
        bottomRight: Radius.circular(isWeb ? 24 : 24.r),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryGreen,
        elevation: 4,
        toolbarHeight: isWeb ? 70 : 70.h, // Ensure internal height matches preferredSize
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: getTextSemiBold(
              size: isWeb ? 20 : 22.sp, // Slightly smaller text for web cleaner look
              colors: AppColors.white,
            ),
            maxLines: 1,
          ),
        ),
        centerTitle: true,
        leading: showBack
            ? IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: isWeb ? 24 : 24.sp),
          onPressed: onBackPressed ?? onBack ?? () => Navigator.pop(context),
        )
            : showMenu
            ? Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu, color: Colors.white, size: isWeb ? 24 : 24.sp),
              onPressed: () => Scaffold.of(context).openDrawer(),
            );
          },
        )
            : null,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: isWeb ? 16 : 16.w),
            child: Image.asset(
              "assets/images/india.png",
              height: isWeb ? 40 : 45.h,
              width: isWeb ? 40 : 45.w,
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(isWeb ? 24 : 24.r),
            bottomRight: Radius.circular(isWeb ? 24 : 24.r),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(isWeb ? 70 : 70.h);
}
