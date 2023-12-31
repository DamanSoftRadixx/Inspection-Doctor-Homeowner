class EndPoints {
  // static const String baseUrl = "http://api.cidusa.net/";
  // static const String baseUrl = "https://api-stage.cidusa.net/";
  static const String baseUrl = "https://api-dev.cidusa.net/";

  static const String register = "auth/signup";
  static const String login = "auth/login";
  static const String socialSignup = "auth/social-signup";
  static const String getLanguages = "auth/public-dropdown/get-languages";
  static const String getRoles = "auth/get-roles";
  static const String resendOtp = "user/resend-otp";
  static const String otpVerification = "user/otp-verification";
  static const String forgotPassword = "auth/forgot-password";
  static const String resetPassword = "user/reset-password";

  static const String getCounties = "user/get-counties";
  static const String addProperty = "property/add-property";
  static const String propertyList = "property/property/list";
  static const String uploadDoc = "auth/media-upload";

  static const String updateProperty = "property/update-property";
  static const String deleteProperty = "property/delete-property";
  static const String logOut = "auth/logout";
  static const String categorySubcategory = "categorySubcategory/all";
  static const String inspectionCreate = "homeowner/inspection-create";
  static const String scheduleInspectionList =
      "homeowner/schedule-inspection-list";
  static const String scheduleInspectionDetail =
      "homeowner/schedule-inspection-details";
  static const String inspectionReschedule = "homeowner/inspection-reschedule";
  static const String stateList = "user/get-states";
  static const String viewReport = "inspector/view-report";
  static const String addFeedBack = "inspector/add-feedback/";

  static String mapKey = "AIzaSyBYNsU2aU0_SpFhAeQQxKA1744aDM1Gs2I";
  static const String notification = "user/notification-list";
  static const String editNotification = "user/edit/notification/";
  static const String categoryList = "inspector/category-list";

  static const String createCard = "stripe/create-card";
  static const String cardList = "stripe/card-list";
  static String googleMapUrl =
      "https://maps.googleapis.com/maps/api/place/details/json?";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
