// import 'dart:convert';
// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/app_end_points.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_dropdown_button.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/string_extensions.dart';
// import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/login/models/navigation_model/signup_to_otp_model.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/login/provider/auth_provider.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/presentation/models/city_listing_response.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/presentation/models/country_listing_response.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/presentation/models/signup_model.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/presentation/models/state_listing_response.dart';

// import '../../../../../core/routes/routes.dart';

// class SignupScreenController extends GetxController {
//   AuthProvider authProvider = AuthProvider();

//   final FocusNode nodeText1 = FocusNode();

//   RxBool isAcceptTermAndCond = false.obs;

//   RxBool showPasswordError = false.obs;
//   RxBool showConfirmPasswordError = false.obs;
//   RxBool emailError = false.obs;
//   RxBool nameError = false.obs;

//   RxBool isAgeValidations = false.obs;
//   RxBool isGenderValidations = false.obs;
//   RxBool isCountryValidations = false.obs;
//   RxBool isstateValidations = false.obs;
//   RxBool iscityValidations = false.obs;
//   RxBool isDateValidations = false.obs;
//   RxBool isOfValidations = false.obs;
//   RxBool isBirthValidations = false.obs;
//   RxBool isLoading = false.obs;
//   var dobDay = "".obs, dobMonth = "".obs, dobYear = "".obs;

//   RxList<DropdownModel> ageList = <DropdownModel>[].obs;
//   RxList<DropdownModel> genderList = <DropdownModel>[].obs;
//   RxList<DropdownModel> dateList = <DropdownModel>[].obs;
//   RxList<DropdownModel> ofList = <DropdownModel>[].obs;
//   RxList<DropdownModel> birthList = <DropdownModel>[].obs;
//   RxList<DropdownModel> countryList = <DropdownModel>[].obs;
//   RxList<DropdownModel> stateList = <DropdownModel>[].obs;
//   RxList<DropdownModel> cityList = <DropdownModel>[].obs;
//   Rx<DropdownModel> selectedAgeDropDown = DropdownModel().obs;
//   Rx<DropdownModel> selectedGenderDropDown = DropdownModel().obs;
//   Rx<DropdownModel> selectedCityDropDown = DropdownModel().obs;
//   Rx<DropdownModel> selectedCountryDropDown = DropdownModel().obs;
//   Rx<DropdownModel> selectedStateDropDown = DropdownModel().obs;
//   Rx<DropdownModel> selectedDateDropDown = DropdownModel().obs;
//   Rx<DropdownModel> selectedOfDropDown = DropdownModel().obs;
//   Rx<DropdownModel> selectedBirthDropDown = DropdownModel().obs;

//   TextEditingController nameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController createPasswordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();

//   FocusNode nameFocusNode = FocusNode();
//   FocusNode emailFocusNode = FocusNode();
//   FocusNode createPasswordFocusNode = FocusNode();
//   FocusNode confirmPasswordFocusNode = FocusNode();

//   RxBool isVisibleCreatePassword = false.obs;
//   RxBool isVisibleConfirmPassword = false.obs;

//   @override
//   void onInit() {
//     initializeDropdowns();
//     getCountryListing();
//     super.onInit();
//   }

//   initializeDropdowns() {
//     selectedAgeDropDown.value = DropdownModel(
//         name: AppStrings.selectAge.tr, id: AppStrings.selectAge.tr);
//     selectedGenderDropDown.value = DropdownModel(
//         name: AppStrings.selectgender.tr, id: AppStrings.selectgender.tr);

//     genderList.value = [
//       DropdownModel(
//           name: AppStrings.selectgender.tr, id: AppStrings.selectgender.tr),
//       DropdownModel(name: AppStrings.male.tr, id: AppStrings.male.tr),
//       DropdownModel(name: AppStrings.female.tr, id: AppStrings.female.tr)
//     ];
//     ageList.add(DropdownModel(
//         name: AppStrings.selectAge.tr, id: AppStrings.selectAge.tr));
//     for (int i = 18; i <= 99; i++) {
//       ageList.add(DropdownModel(name: "$i", id: "$i"));
//     }
//   }

//   void createAccount() {
//     bool isValid = true;
//     if (emailController.text.isEmpty &&
//         createPasswordController.text.isEmpty &&
//         confirmPasswordController.text.isEmpty &&
//         selectedGenderDropDown.value.name == AppStrings.selectgender &&
//         selectedCountryDropDown.value.name == AppStrings.selectCountry &&
//         (dobMonth.value == "" || dobDay.value == "" || dobYear == "")) {
//       isValid = false;
//       // nameError.value = true;
//       emailError.value = true;
//       showPasswordError.value = true;
//       showConfirmPasswordError.value = true;
//       isAgeValidations.value = true;
//       isGenderValidations.value = true;
//       // isDateValidations.value = true;
//       // isOfValidations.value = true;
//       isBirthValidations.value = true;
//       isCountryValidations.value = true;
//       isstateValidations.value = true;
//       iscityValidations.value = true;
//       // nameError.refresh();
//       emailError.refresh();
//       showPasswordError.refresh();
//       showConfirmPasswordError.refresh();
//     }
//     /* if (nameController.text.isEmpty) {

//       isValid = false;
//       nameError.value = true;
//     }*/
//     if (emailController.text.isEmpty ||
//         !GetUtils.isEmail(emailController.text)) {
//       emailError.value = true;
//       isValid = false;
//     }
//     /*  if (selectedDateDropDown.value.name == AppStrings.selectDate.tr) {
//       isDateValidations.value = true;
//       isValid = false;
//       isDateValidations.refresh();
//     }*/
//     /* if (selectedOfDropDown.value.name == AppStrings.selectOf.tr) {
//       isOfValidations.value = true;
//       isValid = false;
//       isOfValidations.refresh();
//     }*/
//     if (dobDay.value == "" || dobMonth.value == "" || dobYear.value == "") {
//       isBirthValidations.value = true;
//       isValid = false;

//       isBirthValidations.refresh();
//     }
//     /*if (selectedAgeDropDown.value.name == AppStrings.selectAge.tr) {
//       isAgeValidations.value = true;
//       isValid = false;
//       isAgeValidations.refresh();
//     }*/
//     if (selectedGenderDropDown.value.name == AppStrings.selectgender.tr) {
//       isGenderValidations.value = true;
//       isValid = false;
//     }
//     if (selectedCountryDropDown.value.name == AppStrings.selectCountry.tr) {
//       isCountryValidations.value = true;
//       isValid = false;
//     }
//     if (selectedStateDropDown.value.name ==
//             AppStrings.selectStateorProviance.tr ||
//         selectedStateDropDown.value.name == "") {
//       isstateValidations.value = true;
//       isValid = false;
//     }
//     if (selectedCityDropDown.value.name == AppStrings.selectCity.tr ||
//         selectedCityDropDown.value.name == "") {
//       iscityValidations.value = true;
//       isValid = false;
//     }
//     if (createPasswordController.text.length < 8) {
//       showPasswordError.value = true;
//       isValid = false;
//     }
//     if (confirmPasswordController.text.isEmpty ||
//         confirmPasswordController.text.toString() !=
//             createPasswordController.text.toString()) {
//       showConfirmPasswordError.value = true;
//       isValid = false;
//     }
//     if (isValid) {
//       print("testtttApi");
//       FocusManager.instance.primaryFocus?.unfocus();
//       signupApi();
//     }
//   }

//   Future getCountryListing() async {
//     isLoading.value = true;
//     authProvider.getCountryListing().then((CountryListingResponse? value) {
//       isLoading.value = false;
//       print("values>>>>>>>>>>${jsonEncode(value)}");
//       value?.data
//           ?.map((e) => countryList
//               .add(DropdownModel(name: e.name.toString(), id: e.id.toString())))
//           .toList();
//       countryList.insert(
//           0, DropdownModel(name: AppStrings.selectCountry.tr, id: "0"));

//       selectedCountryDropDown.value =
//           DropdownModel(name: countryList.first.name, id: countryList.first.id);
//     }).catchError((onError) {
//       isLoading.value = false;
//     });
//   }

//   Future getStateListing(String countryId) async {
//     isLoading.value = true;
//     authProvider.getStateListing(countryId).then((StateListingResponse? value) {
//       print("stateList ${jsonEncode(value)}");
//       isLoading.value = false;
//       stateList.add(
//           DropdownModel(name: AppStrings.selectStateorProviance.tr, id: "0"));
//       value?.data
//           ?.map((e) => stateList
//               .add(DropdownModel(name: e.name.toString(), id: e.id.toString())))
//           .toList();

//       selectedStateDropDown.value =
//           DropdownModel(name: stateList.first.name, id: stateList.first.id);
//     }).catchError((onError) {
//       isLoading.value = false;
//     });
//   }

//   Future getCityListing(String countryId, String stateId) async {
//     isLoading.value = true;
//     authProvider
//         .getCityListing(countryId, stateId)
//         .then((CityListingResponse? value) {
//       print("cityList ${jsonEncode(value)}");
//       isLoading.value = false;
//       cityList.add(DropdownModel(name: AppStrings.selectCity.tr, id: "0"));
//       value?.data
//           ?.map((e) => cityList
//               .add(DropdownModel(name: e.name.toString(), id: e.id.toString())))
//           .toList();

//       selectedCityDropDown.value =
//           DropdownModel(name: cityList.first.name, id: cityList.first.id);
//     }).catchError((onError) {
//       isLoading.value = false;
//     });
//   }

//   Future<void> signupApi() async {
//     isLoading.value = true;
//     var age = calculateAge(DateTime(
//       dobYear.value.toIntConversion(),
//       dobMonth.value.toIntConversion(),
//       dobYear.value.toIntConversion(),
//     ));

//     print("age : $age");
//     Map<String, dynamic> dataBody = {
//       "age": age,
//       "city": selectedCityDropDown.value.id,
//       "confirm_password": confirmPasswordController.text,
//       "country": selectedCountryDropDown.value.id,
//       "email": emailController.text,
//       "gender": selectedGenderDropDown.value.name,
//       "name": nameController.text,
//       "password": createPasswordController.text,
//       "role_type": "writer",
//       "state": selectedStateDropDown.value.id,
//     };
//     SignupResponse? response = await authProvider.signupRequest(body: dataBody);
//     isLoading.value = false;
//     print("test 201${response?.code}");
//     if (response?.code == 201) {
//       print("test 201");
//       /*Prefs.write(Prefs.TOKEN,response?.accessToken);*/
//       goToOtpVerificationScreen();
//     } else {
//       print("print the signup");
//     }
//   }

//   goToOtpVerificationScreen() {
//     var arguments = SignupToOtpModel(
//         email: emailController.text, password: createPasswordController.text);
//     Get.toNamed(Routes.otpVerifyScreen,
//         arguments: {GetArgumentConstants.signupToOtpModel.tr: arguments});
//   }

//   bool passwordPattern(String value) {
//     String pattern =
//         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~%]).{8,}$';
//     RegExp regExp = RegExp(pattern);
//     return regExp.hasMatch(value.trim());
//   }

//   onPressedCustomInkwell() {
//     nameFocusNode.unfocus();
//     emailFocusNode.unfocus();
//     createPasswordFocusNode.unfocus();
//     confirmPasswordFocusNode.unfocus();
//   }

//   onChangedNameTextfield({required String value}) {
//     if (value.length > 2) {
//       nameError.value = false;
//     }
//     nameError.refresh();
//   }

//   onChangedEmailTextfield({required String value}) {
//     if (GetUtils.isEmail(emailController.text)) {
//       emailError.value = false;
//     }
//   }

//   onChangedCreatePasswordTextfield({required String value}) {
//     if (createPasswordController.text.length >= 8) {
//       showPasswordError.value = false;
//     }
//     showPasswordError.refresh();
//   }

//   onChangedConfirmPasswordTextfield({required String value}) {
//     if (confirmPasswordController.text == createPasswordController.text) {
//       showConfirmPasswordError.value = false;
//     }
//   }

//   onClickAgeDropdown({required DropdownModel value}) {
//     selectedAgeDropDown.value = value;
//     if (selectedAgeDropDown.value.name != AppStrings.selectAge) {
//       isAgeValidations.value = false;
//     }
//   }

//   onClickGenderDropdown({required DropdownModel value}) {
//     selectedGenderDropDown.value = value;
//     if (selectedGenderDropDown.value.name != AppStrings.selectgender.tr) {
//       isGenderValidations.value = false;
//     }
//   }

//   onClickCountryDropdown({required DropdownModel value}) {
//     selectedCountryDropDown.value =
//         DropdownModel(name: value.name, id: value.id);
//     if (selectedCountryDropDown.value.name != AppStrings.selectCountry.tr) {
//       isCountryValidations.value = false;
//     }

//     print("selecteddd${value.id}");

//     stateList.clear();
//     if (value.id != "0") {
//       log("LOGGER ${selectedCountryDropDown.value.id}");
//       getStateListing(selectedCountryDropDown.value.id);
//     }
//   }

//   onClickStateDropdown({required DropdownModel value}) {
//     selectedStateDropDown.value = DropdownModel(name: value.name, id: value.id);

//     if (selectedStateDropDown.value.name !=
//         AppStrings.selectStateorProviance.tr) {
//       isstateValidations.value = false;
//     }

//     cityList.clear();

//     if (value.id != "0") {
//       getCityListing(
//           selectedCountryDropDown.value.id, selectedStateDropDown.value.id);
//     }
//     /* controller.selectedStateDropDown.value = value;*/
//   }

//   onClickCityDropdown({required DropdownModel value}) {
//     selectedCityDropDown.value = value;
//     if (selectedCityDropDown.value.name != AppStrings.selectCity.tr) {
//       iscityValidations.value = false;
//     }
//   }

//   onTapPrivacyPolicy() {
//     Get.toNamed(Routes.webViewScreen, arguments: {
//       GetArgumentConstants.title.tr: AppStrings.privacyPolicy.tr,
//       GetArgumentConstants.url: EndPoints.privacyPolicy,
//     });
//   }

//   onTapTermAndConditions() {
//     Get.toNamed(Routes.webViewScreen, arguments: {
//       GetArgumentConstants.title.tr: AppStrings.termAndCondition.tr,
//       GetArgumentConstants.url.tr: EndPoints.termAndCondition.tr,
//     });
//   }

//   onPressConfirmPasswordEyeIcon() {
//     if (isVisibleConfirmPassword.value == false) {
//       isVisibleConfirmPassword.value = true;
//     } else {
//       isVisibleConfirmPassword.value = false;
//     }
//   }

//   onPressCreatePasswordEyeIcon() {
//     if (isVisibleCreatePassword.value == false) {
//       isVisibleCreatePassword.value = true;
//     } else {
//       isVisibleCreatePassword.value = false;
//     }
//   }

//   setDOBDay({required String value}) {
//     dobDay.value = value;
//     resetDobValidations();
//   }

//   setMonthDay({required String value}) {
//     dobMonth.value = value;

//     resetDobValidations();
//   }

//   setYearDay({required String value}) {
//     dobYear.value = value;
//     resetDobValidations();
//   }

//   resetDobValidations() {
//     if (dobDay.value != "" && dobMonth.value != "" && dobYear.value != "") {
//       isBirthValidations.value = false;
//       isBirthValidations.refresh();
//     }
//   }

//   String calculateAge(DateTime birthDate) {
//     DateTime currentDate = DateTime.now();
//     int age = currentDate.year - birthDate.year;
//     int month1 = currentDate.month;
//     int month2 = birthDate.month;
//     if (month2 > month1) {
//       age--;
//     } else if (month1 == month2) {
//       int day1 = currentDate.day;
//       int day2 = birthDate.day;
//       if (day2 > day1) {
//         age--;
//       }
//     }
//     return age.toString();
//   }
// }
