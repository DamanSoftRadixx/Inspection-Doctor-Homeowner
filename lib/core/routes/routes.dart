import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/binding/forget_password_binding.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/binding/login_screen_binding.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/binding/verify_screen_binding.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/screens/forget_password_screen.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/screens/login_screen.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/screens/otp_verify_screen.dart';
import 'package:inspection_doctor_homeowner/features/signup/presentation/binding/signup_screen_binding.dart';
import 'package:inspection_doctor_homeowner/features/signup/presentation/screens/signup_screen.dart';
import 'package:inspection_doctor_homeowner/features/splash/screens/splashScreen.dart';

import '../../features/webview/binding/webview_binding.dart';
import '../../features/webview/view/webview_screen.dart';

class Routes {
  Routes._();

  static const String INITIAL = "/";
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

List<GetPage> AppPages() => [
      GetPage(
        name: Routes.INITIAL,
        page: () => const SplashScreen(),
        fullscreenDialog: true,
        // binding: NetworkBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.loginScreen,
        page: () => const LoginScreen(),
        fullscreenDialog: true,
        binding: LoginScreenBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.signupScreen,
        page: () => const SignupScreen(),
        fullscreenDialog: true,
        binding: SignupScreenBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.forgetScreen,
        page: () => const ForgetPasswordScreen(),
        fullscreenDialog: true,
        binding: ForgetScreenBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.otpVerifyScreen,
        page: () => const OTPVerifyScreen(),
        fullscreenDialog: true,
        binding: VerifyScreenBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.webViewScreen,
        page: () => const WebViewScreen(),
        binding: WebViewBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
    ];
