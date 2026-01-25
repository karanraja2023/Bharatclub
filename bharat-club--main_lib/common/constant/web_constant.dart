import 'package:organization/common/constant/app_constant.dart';

class WebConstants {
  // Standard Comparison Values
  static int statusCode200 = 200;
  static int statusCode400 = 400;
  static int statusCode422 = 422;

  static String statusMessageOK = "OK";
  static String statusMessageBadRequest = "Bad Request";
  static String statusMessageEntityError = "Unprocessable Entity Error";
  static String statusMessageTokenIsExpired = "Token is Expired";

  // Web response cases
  static String statusCode403Message =
      "{  \"error\" : true,\n  \"statusCode\" : 403,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unauthorized error\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode404Message =
      "{  \"error\" : true,\n  \"statusCode\" : 404,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to find the action URL\"},\n  \"responseTime\" : 1639548038\n  }";
  static String statusCode502Message =
      "{\r\n  \"error\": true,\r\n  \"statusCode\": 502,\r\n  \"statusMessage\": \"Bad Request\",\r\n  \"data\": {\r\n    \"message\": \"Server Error, Please try after sometime\"\r\n  },\r\n  \"responseTime\": 1639548038\r\n}";
  static String statusCode503Message =
      "{  \"error\" : true,\n  \"statusCode\" : 503,\n  \"statusMessage\" : \"Bad Request\",\n  \"data\" : {\"message\":\"Unable to process your request right now, Please try again later\"},\n  \"responseTime\" : 1639548038\n  }";

  /// Base URL
  static String baseUrlLive = "https://clubs.benchmarkit.my/clubeapi/api/v1/";
  static String baseUrlDev = "https://clubs.benchmarkit.my/clubeapi/api/v1/";
  static String baseURL = AppConstants.isLiveURLToUse
      ? baseUrlLive
      : baseUrlDev;
  static String baseUrlCommon = baseURL;
  static bool auth = false;

  /// Master - all Url
  static String actionRegistration = "user/register"; //post
  static String verifyQRUrl = "device-access/verify";

  static String actionLogin = "user/login"; //post
  static String actionProfile = "user/show"; //post
  static String actionDashboard = "user/dashboard"; //post
  static String actionProfileUpdate = "user/update";
  // ABOUT_US | EVENTS | NEWS | GALLERY | CONTACT//post
  static String actionCmsPage = "user/cmsPage"; //post
  static String actionUploadProfileImage = "user/uploadProfileImage"; //post
  static String actionUploadPayment = "user/upload"; //post
  static String actionJoinClubs = "user/clubs"; //post
  static String actionJoinClubSubmit = "user/clubsubmit"; //post
  static String actionEventSubmit = "user/participantsubmit"; //post
  static String actionMemberList = "user/memberList"; //post
  static String actionBannerList = "user/sponsor"; //post
  static String actionChangePassword = "user/changepassword"; //post
  static String actionWebUrl =
      "https://clubs.benchmarkit.my/registrationform"; //post
  static String actionAccountDeletion = "user/accountdeletion"; //post
  static String actionForgotPassword = "user/forgotpassword"; //post
  static String actionEventDetails = ""; //post
  static String actionPartipantSubmit = "user/participantsubmit"; //post
  static String actionQrScanDetails = "user/qrscan"; //post
  static String actionEventAttentace = "user/attendance"; //post
  static String actionMembershipType = "user/membershiptype"; //post
  static String actionSponsorEvent = "user/sponsorevent"; //post
}
