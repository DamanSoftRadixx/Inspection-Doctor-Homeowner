class EndPoints {
  static const String baseUrl = "https://reqres.in/api";
  static const String register = "auth/register";
  static const String countryListing = "country";
  static const String stateListing = "state";
  static const String cityListing = "city";
  static const String login = "auth/login";
  static const String myGuidedJournalListing = "writer/myGuidedList";
  static const String privacyPolicy = "https://flutterflow.io/";
  static const String termAndCondition = "https://flutterflow.io/";
  static const String notificationListing = "writer/notification";
  static const String security = "writer/security";
  static const String myGuidedSave = "writer/myGuidedSave";

  static const String mailVerification = "auth/mailverification";
  static const String resendEmailOtp = "auth/resendEmailOtp";
  static const String autoSaveData = "writer/autoSaveData";
  static const String journalListing = "writer/autoSaveDataList";
  static const String getJournalDetailById = "writer/autoSaveGetDataByID";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
