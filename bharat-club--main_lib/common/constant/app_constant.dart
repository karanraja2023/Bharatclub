
class AppConstants {
  ///colours select true main false clint
  static bool isMainColours = true;

  ///Web response Log
  static bool isWebLogToPrint = true;
  // Release -> true , UAT -> false
  static bool isLiveURLToUse = false;

  // One place to hide all credentials during production build upload
  static bool isClearLoginCredentials = false;

  // Shared Preference Encryption -> true , Normal -> false
  static bool isSharedPrefToEncrypt = true;

  // Enable Crashlytics -> true , Normal -> false
  static bool isCrashlyticsToEnable = true;

  // Enable Analytics -> true , Normal -> false
  static bool isAnalyticsToEnable = true;

  // Web API Encryption -> true , Normal -> false
  static bool isConnectionToEncrypt = false;

  // Mobile OS Platform
  static const String platformAndroid = "ANDROID";
  static const String platformIOS = "IOS";

  // Web API mode
  static const String webAPIStaging = "Staging";
  static const String webAPIProduction = "Production";

  // static const String appReleaseType = appDemo;

  // Build mode
  static const String buildModeDebug = "Debug";
  static const String buildModeRelease = "Release";

  //MyBella ChatBot
  static const String wChatBotIosAppKey =
      "MQydHiGtgZVMyN%2FVFifUblS5BFjTUb2QiN2Hmz9gAj4TwgDQvS50Gg%3D%3D";
  static const String wChatBotIosAccessKey =
      "hWQhvPaCz%2B0FoAQq56%2BEMtVtt%2FPHEYvRgYJRxvFaMKtmd7ogmcA%2F29BY0x9XSpec7CcYEMDzbgLWHQIwy0pRP7OmuM%2FcALmFYIff7fbikQGpR5KJPx3NiiJe%2BYIgR03lwPH9RupPdBYt9Ldjwsuk0Dgx4CfOQmbHE8IA0L0udBo%3D";
  static const String wChatBotAndroidAppKey =
      "MQydHiGtgZVMyN%2FVFifUblS5BFjTUb2QiN2Hmz9gAj4TwgDQvS50Gg%3D%3D";
  static const String wChatBotAndroidAccessKey =
      "hWQhvPaCz%2B0FoAQq56%2BEMtVtt%2FPHEYvRgYJRxvFaMKtmd7ogmcA%2F29BY0x9XSpec7CcYEMDzbgJ%2Brm37PeOrpc42vhw0rG%2FqxkaJHWJcZ%2F6myT%2FhbGvvXiJe%2BYIgR03lwPH9RupPdBYt9Ldjwsuk0Dgx4CfOQmbHE8IA0L0udBo%3D";

  // static late WordConstants mWordConstants;

  static String refreshLevy="";
}
