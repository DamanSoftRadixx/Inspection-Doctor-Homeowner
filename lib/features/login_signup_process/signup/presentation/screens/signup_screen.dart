import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/authentication_module_common_widgets.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/presentation/controller/signup_screen_controller.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/presentation/extension/signup_screen_extension.dart';

class SignupScreen extends GetView<SignupScreenController> {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColorPalette.primarySwatch.shade900,
        body: Obx(
          () => InkWell(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            appBarWidget(),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 15.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  createAnAccountTitleWidget(),
                                  emailTextfieldWidget(),
                                  passwordTextfieldWidget(),
                                  confirmPasswordTextfieldWidget(),
                                  SizedBox(height: 16.h),
                                  dateOfBirthDropdownWidget(),
                                  SizedBox(height: 16.h),
                                  genderDropdownWidget(),
                                  SizedBox(height: 16.h),
                                  countryDropdownWidget(),
                                  SizedBox(height: 16.h),
                                  stateDropdownWidget(),
                                  SizedBox(height: 16.h),
                                  cityDropdownWidget(),
                                  SizedBox(height: 16.h),
                                  termAndConditionWidget(),
                                  SizedBox(
                                    height: 24.h,
                                  ),

                                  // CommonButton(
                                  //   minWidth: double.infinity,
                                  //   commonButtonBottonText: AppStrings.continuebTN.tr,
                                  //   bgColor: lightColorPalette.secondarySwatch.shade900,
                                  //   radius: 8.r,
                                  //   style: lightTextTheme.headline3?.copyWith(
                                  //       fontSize: 16.sp,
                                  //       fontFamily: CommonStrings.vitnamPro,
                                  //       fontWeight: FontWeight.w500,
                                  //       color: lightColorPalette
                                  //           .whiteColorPrimary.shade900),
                                  //   onPress: () {
                                  //     controller.createAccount();
                                  //     // controller.isCheckLogin();
                                  //   },
                                  // ).paddingOnly(left: 3.w, right: 3.w),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    addSignupButton(),
                    SizedBox(
                      height: 30.h,
                    )
                  ],
                ),
                controller.isLoading.value == true
                    ? const CommonLoader()
                    : Container()
              ],
            ),
          ),
        ));
  }
}
