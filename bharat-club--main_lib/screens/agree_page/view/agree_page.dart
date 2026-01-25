import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:get/get.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/app_theme/theme/app_theme.dart';
import 'package:organization/common/widgets/appbar.dart';
import 'package:organization/utils/app_text.dart';
import 'package:organization/utils/app_util.dart';
import '../controller/agree_page_controller.dart';

class TermsAndConditionsPage extends StatefulWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isAtBottom = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        _isAtBottom = true;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TermsAndConditionsController());

    return Scaffold(body: _fullView());
  }

  Widget _fullView() {
    return FocusDetector(
      onVisibilityGained: () {},
      onVisibilityLost: () {
        Get.delete<TermsAndConditionsController>();
      },
      child: GestureDetector(
        onTap: () {
          AppUtils.hideKeyboard(Get.context!);
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.cAppColors,
                Colors.grey.shade100,
                Colors.grey.shade100,
                AppColors.cAppColors,
              ],
            ),
          ),
          height: 1.sh,
          width: 1.sw,
          child: Column(
            children: [
              const CustomAppBar(title: 'Agree To Terms'),
              SizedBox(height: 10.h),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: _termsAndConditionsContent(),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              _actionButtons(),
              SizedBox(height: 10.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _termsAndConditionsContent() {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(5.w),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: getTextSemiBold(
                colors: AppColors.cAppColors.shade700,
                size: 18.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              '''
1. Introduction
This document outlines the data collection, usage, and protection policies for the Bharat Club mobile application, which serves expatriates working in Malaysia. By using the application, members consent to the collection and processing of personal data in accordance with these terms.

2. Data Collected
The mobile application collects and processes the following types of personal data:

Member Details:
• Member Name, Email Address, Company Name, Mobile Number, Passport Number, Residence Address, Visa Type

Spouse Details:
• Spouse Name, Spouse Mobile Number, Spouse Email Address, Spouse Passport Number, Spouse Visa Type

Child Details:
• Name and Age

Payment Details:
• Amount (RM), Bank Name, Payment Date, Payment Reference Number, Referred By

3. Purpose of Data Collection
Personal data is collected for the following purposes:
• Member registration and verification
• Event registration and management of member participation
• Payment processing and record-keeping
• Communication with members regarding club activities, services, and updates
• Improvement of member experience through personalized services and communications

4. Legal Basis for Data Processing
The collection and processing of personal data is based on the following:
• Member consent for the collection and processing of their data
• The necessity of data processing for the performance of membership services
• Compliance with legal obligations, especially concerning expatriates

5. Consent
Members provide their consent by using the application and supplying their personal data. Members have the right to withdraw consent at any time by contacting the club’s administration at +6019-5331794.

6. Data Sharing
Personal data may be shared to support the operation of the club, such as:
• Event management tools

7. Data Retention
Member data will be retained for the duration of membership and for a reasonable period thereafter, as necessary for compliance with legal and operational requirements. Once data is no longer needed, it will be securely deleted or anonymized.

8. Data Security
We implement appropriate security measures to protect personal data from unauthorized access, misuse, loss, or disclosure. These measures include encryption, secure servers, and access controls. However, no data transmission over the internet is completely secure, and we cannot guarantee the absolute security of personal data.

9. Member Rights
Members have the right to:
• Access and update their personal data
• Request corrections to inaccurate information
• Request deletion of their data, subject to legal limitations

10. Cookies and Tracking Technologies
The mobile application may use cookies or similar technologies to enhance user experience and collect usage data. Members can control cookie preferences through their device settings.

11. Changes to this Policy
We may update these terms from time to time. Any significant changes will be communicated through the application or by email. Members' continued use of the application will signify their acceptance of the revised terms.

12. Contact Information
For inquiries or concerns about these terms or the processing of personal data, please contact:
Bharat Club Malaysia
clubbharat@gmail.com
+6019 5331794
              ''',
              style: getTextRegular(
                colors: AppColors.cAppColors.shade700,
                size: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionButtons() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // ✅ Agree Button
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: ElevatedButton(
                onPressed: _isAtBottom
                    ? () {
                        Get.find<TermsAndConditionsController>().webView();
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isAtBottom
                      ? AppColors.cAppColors
                      : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  minimumSize: Size(double.infinity, 40.h),
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.5),
                ),
                child: Text(
                  'Agree',
                  style: getTextSemiBold(colors: AppColors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10.w),
              child: ElevatedButton(
                onPressed: _isAtBottom
                    ? () {
                        Get.offNamed(AppRoutes.loginScreen);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isAtBottom ? Colors.redAccent : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  minimumSize: Size(double.infinity, 40.h),
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.5),
                ),
                child: Text(
                  "Disagree",
                  style: getTextSemiBold(colors: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
