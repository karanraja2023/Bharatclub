import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/utils/app_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showMenu;
  final VoidCallback? onBack;
  final VoidCallback? onBackPressed; // Add this parameter

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBack = true,
    this.showMenu = false,
    this.onBack,
    this.onBackPressed, // Add this parameter
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(24.r),
        bottomRight: Radius.circular(24.r),
      ),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.secondaryGreen,
        elevation: 4,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            title,
            style: getTextSemiBold(size: 22.sp, colors: AppColors.white),
            maxLines: 1,
          ),
        ),

        centerTitle: true,
        leading: showBack
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed:
                    onBackPressed ??
                    onBack ??
                    () => Navigator.pop(context), 
              )
            : showMenu
            ? Builder(
                builder: (context) {
                  return IconButton(
                    icon: const Icon(Icons.menu, color: Colors.white),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  );
                },
              )
            : null,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Image.asset(
              "assets/images/india.png",
              height: 45.h,
              width: 45.w,
            ),
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(24.r),
            bottomRight: Radius.circular(24.r),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70.h);
}
