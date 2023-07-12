class EndPoints {
  static const String baseUrl = "http://api.cidusa.net/";
  static const String register = "auth/admin-signup";
  static const String login = "auth/adminLogin";
  static const String getLanguages = "auth/public-dropdown/get-languages";
  static const String getRoles = "auth/get-roles";

  // receiveTimeout
  static const int receiveTimeout = 15000;

  // connectTimeout
  static const int connectionTimeout = 15000;
}
