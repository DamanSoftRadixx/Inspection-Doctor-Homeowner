class EndPoints {
  static const String baseUrl = "http://api.cidusa.net/";

  static const String register = "auth/signup";
  static const String login = "auth/login";
  static const String getLanguages = "auth/public-dropdown/get-languages";
  static const String getRoles = "auth/get-roles";
  static const String resendOtp = "user/resend-otp";
  static const String otpVerification = "user/otp-verification";
  static const String forgotPassword = "auth/forgot-password";
  static const String resetPassword = "user/reset-password";



  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
