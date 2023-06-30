import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/binding/login_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/screens/login_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/binding/otp_verify_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/screen/otp_verify.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/binding/select_language_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/screens/select_language.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/binding/signup_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/screens/signup_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/binding/signup_screen_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/screens/splashScreen.dart';

class Routes {
  Routes._();

  static const String root = "/";
  static const String selectLanguage = "/selectLanguage";
  static const String dashboard = "/dashboard";
  static const String entriesScreen = "/entries";
  static const String flowsScreen = "/flows";
  static const String settingsScreen = "/SettingsScreen";
  static const String languageScreen = "/LanguageSelectionScreen";

  static const String guidedJournalContentScreen =
      "/guidedJournalContentScreen";
  static const String loginScreen = "/loginScreen";
  static const String guidedJournalDetails = "/guidedJournalDetails";
  static const String signupScreen = "/signupScreen";
  static const String forgetScreen = "/forgetScreen";
  static const String addCardScreen = "/addCardScreen";
  static const String otpVerifyScreen = "/otpVerifyScreen";
  static const String webViewScreen = "/webViewScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String introScreen = "/introScreen";
}

List<GetPage> appPages() => [
      GetPage(
        name: Routes.root,
        page: () => const SplashScreen(),
        fullscreenDialog: true,
        binding: SplashScreenBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.selectLanguage,
        page: () => const SelectLanguageScreen(),
        fullscreenDialog: true,
        binding: SelectLanguageBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        fullscreenDialog: true,
        binding: LoginBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.signupScreen,
        page: () => const SignupScreen(),
        fullscreenDialog: true,
        binding: SignupBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.otpVerifyScreen,
        page: () => const OtpVerifyScreen(),
        fullscreenDialog: true,
        binding: OtpVerifyBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
    ];
