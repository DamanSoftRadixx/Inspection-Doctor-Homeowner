import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/features/InspectionsList/binding/inspections_list_binding.dart';
import 'package:inspection_doctor_homeowner/features/InspectionsList/screen/inspections_list_screen.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/binding/add_property_binding.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/screens/add_property_screen.dart';
import 'package:inspection_doctor_homeowner/features/dashboard/binding/dashboard_binding.dart';
import 'package:inspection_doctor_homeowner/features/dashboard/screen/dashboard_screen.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/binding/give_feedback_binding.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/screens/give_feedback_screen.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/report_view/binding/report_view_binding.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/report_view/screen/report_view.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/scheduled_property/binding/Inspection_detail_binding.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/scheduled_property/screen/Inspection_detail_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/choose_map/binding/choose_map_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/choose_map/view/choose_map_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/binding/forget_password_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/screens/forget_password_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/binding/login_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/screens/login_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/binding/otp_verify_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/screen/otp_verify.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/binding/price_listing_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/screens/price_listing_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/binding/reset_password_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/screens/reset_password_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/binding/signup_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/screens/signup_screen.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/binding/signup_screen_binding.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/screens/splashScreen.dart';
import 'package:inspection_doctor_homeowner/features/notification/binding/notification_binding.dart';
import 'package:inspection_doctor_homeowner/features/notification/screens/notification_screen.dart';
import 'package:inspection_doctor_homeowner/features/payments/add_card/binding/add_card_binding.dart';
import 'package:inspection_doctor_homeowner/features/payments/add_card/screens/add_card_screen.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/binding/payment_binding.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/screens/payment_screen.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/categoriesForm/binding/categories_form_binding.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/categoriesForm/screen/categories_form_screen.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/propertyDetail/binding/add_property_binding.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/propertyDetail/screens/property_detail_screen.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/binding/select_categories_binding.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/screen/select_categories_screen.dart';

class Routes {
  Routes._();

  static const String root = "/";
  static const String selectLanguage = "/selectLanguage";
  static const String entriesScreen = "/entries";
  static const String flowsScreen = "/flows";
  static const String settingsScreen = "/SettingsScreen";
  static const String loginScreen = "/loginScreen";
  static const String signupScreen = "/signupScreen";
  static const String forgetScreen = "/forgetScreen";
  static const String addCardScreen = "/addCardScreen";
  static const String otpVerifyScreen = "/otpVerifyScreen";
  static const String resetPassword = "/resetPassword";
  static const String chooseMap = "/chooseMap";

  //Dashboard
  static const String dashboard = "/dashboard";

  //Add Property
  static const String addPropertyScreen = "/addPropertyScreen";
  static const String propertyDetailScreen = "/propertyDetailScreen";
  static const String selectCategoriesScreen = "/selectCategoriesScreen";
  static const String inspectionsListScreen = "/inspectionsListScreen";

  static const String categoryFormScreen = "/categoryFormScreen";
  static const String inspectionDetailScreen = "/inspectionDetailScreen";
  static const String reportView = "/reportView";
  static const String giveFeedbackScreen = "/giveFeedbackScreen";
  static const String notificationScreen = "/notificationScreen";
  static const String paymentScreen = "/paymentScreen";
  static const String priceListingScreen = "/priceListingScreen";
  static const String addPaymentCardScreen = "/addPaymentCardScreen";
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
      GetPage(
        name: Routes.forgetScreen,
        page: () => const ForgetPasswordScreen(),
        fullscreenDialog: true,
        binding: ForgetPasswordBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.resetPassword,
        page: () => const ResetPasswordScreen(),
        fullscreenDialog: true,
        binding: ResetPasswordBinding(),
        transition: CommonStrings.transition,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.dashboard,
        page: () => const DashBoardScreen(),
        binding: DashboardBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.addPropertyScreen,
        page: () => const AddPropertyScreen(),
        binding: AddPropertyBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.propertyDetailScreen,
        page: () => const PropertyDetailScreen(),
        binding: PropertyDetailBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.chooseMap,
        page: () => const ChooseMapScreen(),
        binding: ChooseMapBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.selectCategoriesScreen,
        page: () => const SelectCategoriesScreen(),
        binding: SelectCategoriesBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.inspectionsListScreen,
        page: () => const InspectionsListScreen(),
        binding: InspectionsListBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.categoryFormScreen,
        page: () => const CategoryFormScreen(),
        binding: CategoryFormBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.inspectionDetailScreen,
        page: () => const InspectionDetailScreen(),
        binding: InspectionDetailBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.reportView,
        page: () => const ReportView(),
        binding: ReportViewBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.giveFeedbackScreen,
        page: () => const GiveFeedbackScreen(),
        binding: GiveFeedbackBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.notificationScreen,
        page: () => const NotificationScreen(),
        binding: NotificationBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.paymentScreen,
        page: () => const PaymentScreen(),
        binding: PaymentBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.priceListingScreen,
        page: () => const PriceListingScreen(),
        binding: PriceListingBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
      GetPage(
        name: Routes.addCardScreen,
        page: () => const AddPaymentCardScreen(),
        binding: AddCardBinding(),
        transition: CommonStrings.transition,
        fullscreenDialog: true,
        transitionDuration:
            const Duration(milliseconds: CommonStrings.transitionDuration),
      ),
    ];
