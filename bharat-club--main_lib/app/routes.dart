import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:organization/app/routes_name.dart';
import 'package:organization/data/mode/cms_page/event_response.dart';
import 'package:organization/data/mode/event_qr_scan/qr_details_request.dart';
import 'package:organization/data/mode/event_qr_scan/qr_details_response.dart';
import 'package:organization/screens/about_us/view/about_us_screen.dart';
import 'package:organization/screens/agree_page/view/agree_page.dart';
import 'package:organization/screens/change_password/view/change_password.dart';
import 'package:organization/screens/contact_us/view/contact_us.dart';
import 'package:organization/screens/event_details_one/view/event_details_one_screen.dart';
import 'package:organization/screens/event_details_one/view/event_details_two_screen.dart';
import 'package:organization/screens/events/view/event_screen.dart';
import 'package:organization/screens/forgot_password/view/forgot_password_view.dart';
import 'package:organization/screens/gallery/view/gallery_screen.dart';
import 'package:organization/screens/home/view/home_view.dart';
import 'package:organization/screens/login/view/login_view.dart';
import 'package:organization/screens/membership/view/membership_expiry.dart';
import 'package:organization/screens/membership/view/membership_screen.dart';
import 'package:organization/screens/privacy_policy/view/privacy_policy_view.dart';
import 'package:organization/screens/profile/view/edit_account_screen.dart';
import 'package:organization/screens/profile/view/edit_contact_profile.dart';
import 'package:organization/screens/profile/view/edit_information.dart';
import 'package:organization/screens/profile/view/profile_screen.dart';
import 'package:organization/screens/qr_code_scan/view/qr_code_generate.dart';
import 'package:organization/screens/qr_code_scan/view/qr_code_scan_screen.dart';
import 'package:organization/screens/qr_code_scan/view/qr_scan_success_screen.dart';
import 'package:organization/screens/splash_screen/view/splash_screen.dart';

class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.splashScreen, page: () => SplashScreen()),
    GetPage(
      name: AppRoutes.loginScreen,
      page: () => LoginScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.changePassword,
      page: () => ChangePasswordScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    // GetPage(
    //   name: AppRoutes.pinEntryPopup,
    //   page: () => PinEntryOverlay(),
    //   transition: Transition.rightToLeftWithFade,
    // ),
    GetPage(
      name: AppRoutes.forgot,
      page: () => ForgotPasswordScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.agreeToTerms,
      page: () => TermsAndConditionsPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => ProfileScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.contactUs,
      page: () => ContactUsListScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.editAccountScreen,
      page: () => EditAccountScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.editPersonOfContactScreen,
      page: () => EditPersonOfContactScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.events,
      page: () => EventScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.privacyPolicy,
      page: () => PrivacyPolicyPage(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.qrCodeScanScreen,
      page: () => ScanQrCodeScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.qrSuccessScreen,
      page: () => QrScanSuccessScreen(
        mqQrDetailResponse: Get.arguments as QrDetailsResponseDetails,
      ),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.eventDetailOneScreen,
      page: () =>
          EventDetailsOneScreen(mEventModule: Get.arguments as EventModule),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.qrScreen,
      page: () {
        final args = Get.arguments;
        print("QR Screen - Arguments received: $args");
        print("Arguments type: ${args.runtimeType}");

        if (args == null) {
          print("ERROR: Arguments are null!");
          return Container();
        }

        if (args is! QrDetailsRequest) {
          print(
            "ERROR: Arguments are not QrDetailsRequest: ${args.runtimeType}",
          );
          return Container();
        }

        return QrCodeGenerateScreen(mQrDetails: args);
      },
      transition: Transition.rightToLeftWithFade,
      binding: BindingsBuilder(() {}),
    ),
    GetPage(
      name: AppRoutes.eventDetailTwoScreen,
      page: () =>
          EventDetailsTwoScreen(mEventModule: Get.arguments as EventModule),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.editInformationScreen,
      page: () => EditProfileInformationScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.gallery,
      page: () => GalleryListScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.membership,
      page: () => MembershipDetailsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.aboutus,
      page: () => AboutUsScreen(),
      transition: Transition.rightToLeftWithFade,
    ),
    GetPage(
      name: AppRoutes.membershipExpired,
      page: () => MembershipExpiredPage(),
      transition: Transition.rightToLeftWithFade,
    ),
  ];
}
