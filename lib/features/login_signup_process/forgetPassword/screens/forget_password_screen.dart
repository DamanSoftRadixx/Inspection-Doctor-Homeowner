import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/controller/forget_password_controller.dart';

class ForgetPasswordScreen extends GetView<ForgetPasswordController> {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
      appBar: showAppBar(),
      body: SafeArea(
        child: Obx(() => Stack(
              children: [
                SingleChildScrollView(
                  physics: const RangeMaintainingScrollPhysics(),
                  child: Column(
                    children: [
                      showHeadingText(),
                      showEmailField(),
                      showSendLinkButton(),
                      // showResendOTP(),
                    ],
                  ).paddingSymmetric(horizontal: 20.w),
                ),
                CommonLoader(isLoading: controller.isShowLoader.value)
              ],
            )),
      ),
    );
  }

  showResendOTP() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppTextWidget(
          style: CustomTextTheme.normalText(color: lightColorPalette.grey),
          text: AppStrings.dontYouReceivedLink.tr,
        ),
        CustomInkwell(
          padding: EdgeInsets.only(left: 3.w),
          onTap: () {},
          child: AppTextWidget(
            style: CustomTextTheme.normalTextWithWeight600(
                color: lightColorPalette.black),
            text: AppStrings.resendlink.tr,
          ),
        ),
      ],
    ).paddingOnly(top: 50.h);
  }

  showSendLinkButton() {
    return CommonButton(
        commonButtonBottonText: AppStrings.sendOTP.tr,
        onPress: () {
          controller.onTapSendLinkBotton();
        }).paddingOnly(top: 50.h);
  }

  AppBar showAppBar() {
    return commonAppBarWithElevation(
      onPressBackButton: () {
        Get.back();
      },
      title: AppStrings.forgotpassword.tr,
    );
  }

  Column showHeadingText() {
    return Column(
      children: [
        Center(
          child: AppTextWidget(
            text: AppStrings.donworryItOccurs.tr,
            style: CustomTextTheme.heading1(
              color: lightColorPalette.black,
            ),
          ),
        ).paddingOnly(top: 57.h, bottom: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: AppTextWidget(
                textAlign: TextAlign.center,
                text: AppStrings.forgetPleaseEnterEmail.tr,
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.grey),
              ).paddingSymmetric(horizontal: 30.w),
            ),
          ],
        ),
      ],
    );
  }

  Widget showEmailField() {
    return commonTextFieldWidget(
      isError: controller.emailError.value,
      errorMsg: controller.emailErrorMessage.value,
      focusNode: controller.emailFocusNode.value,
      controller: controller.emailController.value,
      title: AppStrings.email.tr,
      hint: AppStrings.email.tr,
      maxLength: 50,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
      ],
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: (value) {
        controller.onChangedEmailTextField(value: value);
      },
    ).paddingOnly(bottom: 11.h, top: 50.h);
  }
}
