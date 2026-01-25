import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/utils/app_text.dart';

class ProfileCard extends StatelessWidget {
  final String welcomeText;
  final String userName;
  final String membershipType;
  final String profileImageUrl;
  final String membershipId;
  final String membershipEndDate;
  final String spouseName;
  final VoidCallback? onTap;

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
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // Main card container
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 70.h,
              bottom: 16.h,
            ),
            padding: EdgeInsets.only(
              left: 24.w,
              right: 24.w,
              top: 90.h,
              bottom: 24.h,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFED9F54), 
                  Color(0xFFF4F4F4), // white shade
                  Color(0xFF4EAB5F), // green shade
                ],
                begin: Alignment.topLeft, // diagonal start
                end: Alignment.bottomRight, // diagonal end
                tileMode: TileMode.clamp,
                stops: [0.0, 0.5, 1.0], // color stops for smooth transition
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10.r,
                  offset: Offset(0, 5.h),
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
                    size: 20.sp,
                    colors: AppColors.textPrimary,
                  ),
                  textAlign: TextAlign.center,
                ),
                  SizedBox(height: 4.h),
                  Text(
                    spouseName,
                    style: getTextSemiBold(
                      size: 18.sp,
                      colors: AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                  ),

                SizedBox(height: 8.h),

                // Membership Type
                Text(
                  membershipType.isNotEmpty ? membershipType : '--',
                  style: getTextSemiBold(
                    size: 16.sp,
                    colors: AppColors.primaryGreen,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 4.h),

                // Membership ID
                Text(
                  membershipId.isNotEmpty ? membershipId : '--',
                  style: getTextMedium(
                    size: 15.sp,
                    colors: AppColors.indiaOrange,
                  ),
                  textAlign: TextAlign.center,
                ),

                // Membership End Date (conditional)
                if (membershipType.toLowerCase().contains('annual') &&
                    membershipEndDate.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8.r),
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
                            size: 14.sp,
                            color: AppColors.primaryGreen,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Valid till: ',
                            style: getTextMedium(
                              size: 12.sp,
                              colors: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            membershipEndDate,
                            style: getTextSemiBold(
                              size: 12.sp,
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

          // Profile Image (positioned at top center)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.topCenter,
              child: Hero(
                tag: 'profile_image',
                child: Container(
                  width: 130.w,
                  height: 130.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.white, width: 4.w),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 12.r,
                        offset: Offset(0, 4.h),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: profileImageUrl.isNotEmpty
                        ? Image.network(
                            profileImageUrl,
                            width: 130  .w,
                            height: 130.h,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return _buildPlaceholderImage();
                            },
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
      child: Icon(Icons.person, size: 60.sp, color: Colors.grey[600]),
    );
  }
}
