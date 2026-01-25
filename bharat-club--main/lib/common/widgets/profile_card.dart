import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobileapp/app_theme/theme/app_theme.dart';
import 'package:mobileapp/utils/app_text.dart';

class ProfileCard extends StatelessWidget {
  final String welcomeText;
  final String userName;
  final String membershipType;
  final String profileImageUrl;
  final String membershipId;
  final String membershipEndDate;
  final String spouseName;
  final VoidCallback? onTap;
  final bool isWeb; // Added isWeb property

  const ProfileCard({
    super.key,
    required this.welcomeText,
    required this.userName,
    required this.membershipType,
    required this.profileImageUrl,
    required this.membershipId,
    required this.membershipEndDate,
    this.spouseName = '',
    this.onTap,
    this.isWeb = false, // Default to false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none, // Ensures profile image isn't cut off
        children: [
          // Main card container
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: isWeb ? 24 : 24.w,
              right: isWeb ? 24 : 24.w,
              top: isWeb ? 70 : 70.h,
              bottom: isWeb ? 16 : 16.h,
            ),
            padding: EdgeInsets.only(
              left: isWeb ? 24 : 24.w,
              right: isWeb ? 24 : 24.w,
              top: isWeb ? 80 : 90.h, // Adjusted for web spacing
              bottom: isWeb ? 24 : 24.h,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFED9F54),
                  Color(0xFFF4F4F4),
                  Color(0xFF4EAB5F),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(isWeb ? 16 : 16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: isWeb ? 10 : 10.r,
                  offset: Offset(0, isWeb ? 5 : 5.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // User Name
                Text(
                  userName.isNotEmpty ? userName : '--',
                  style: getTextBold(
                    size: isWeb ? 20 : 20.sp,
                    colors: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: isWeb ? 4 : 4.h),
                Text(
                  spouseName,
                  style: getTextSemiBold(
                    size: isWeb ? 18 : 18.sp,
                    colors: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: isWeb ? 8 : 8.h),

                // Membership Type
                Text(
                  membershipType.isNotEmpty ? membershipType : '--',
                  style: getTextSemiBold(
                    size: isWeb ? 16 : 16.sp,
                    colors: AppColors.primaryGreen,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: isWeb ? 4 : 4.h),

                // Membership ID
                Text(
                  membershipId.isNotEmpty ? membershipId : '--',
                  style: getTextMedium(
                    size: isWeb ? 15 : 15.sp,
                    colors: AppColors.indiaOrange,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Membership End Date
                if (membershipType.toLowerCase().contains('annual') &&
                    membershipEndDate.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: isWeb ? 8 : 8.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: isWeb ? 10 : 10.w,
                        vertical: isWeb ? 6 : 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(isWeb ? 8 : 8.r),
                        border: Border.all(
                          color: AppColors.primaryGreen.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.event_available,
                            size: isWeb ? 14 : 14.sp,
                            color: AppColors.primaryGreen,
                          ),
                          SizedBox(width: isWeb ? 6 : 6.w),
                          Text(
                            'Valid till: ',
                            style: getTextMedium(
                              size: isWeb ? 12 : 12.sp,
                              colors: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            membershipEndDate,
                            style: getTextSemiBold(
                              size: isWeb ? 12 : 12.sp,
                              colors: AppColors.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Profile Image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'profile_image',
                child: Container(
                  width: isWeb ? 130 : 130.w,
                  height: isWeb ? 130 : 130.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: isWeb ? 4 : 4.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: isWeb ? 12 : 12.r,
                        offset: Offset(0, isWeb ? 4 : 4.h),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: profileImageUrl.isNotEmpty
                        ? Image.network(
                      profileImageUrl,
                      width: isWeb ? 130 : 130.w,
                      height: isWeb ? 130 : 130.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => _buildPlaceholderImage(),
                    )
                        : _buildPlaceholderImage(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Container(
      color: Colors.grey[300],
      child: Icon(Icons.person, size: isWeb ? 60 : 60.sp, color: Colors.grey[600]),
    );
  }
}
