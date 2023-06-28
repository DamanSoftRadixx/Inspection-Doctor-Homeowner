// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/app_common_text_form_field.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/authentication_module_common_widgets.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_button.dart';
// import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
// import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
// import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
// import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/login/controller/forget_password_controller.dart';

// import '../../../../../../core/utils/enum.dart';

// class ForgetPasswordScreen extends GetView<ForgetScreenController> {
//   const ForgetPasswordScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: lightColorPalette.primarySwatch.shade900,
//         body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
//           Obx(() => InkWell(
//                 onTap: () {
//                   FocusScope.of(context).requestFocus(FocusNode());
//                 },
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       appBarWidget(isShowCancel: true),
//                       Container(
//                         padding: EdgeInsets.symmetric(horizontal: 15.w),
//                         child: Column(
//                           children: [
//                             Align(
//                               alignment: Alignment.topLeft,
//                               child: AppTextWidget(
//                                 text: AppStrings.resetPassword.tr,
//                                 style: lightTextTheme.bodyLarge?.copyWith(
//                                   fontSize: 24.sp,
//                                   color: lightColorPalette
//                                       .whiteColorPrimary.shade900,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 0.h,
//                             ),
//                             AppTextFormField(
//                               focusNode: controller.emailFocusNode,
//                               filled: true,
//                               errorBool: controller.errorBool.value,
//                               fillColor:
//                                   lightColorPalette.whiteColorPrimary.shade900,
//                               controller: controller.emailController,
//                               isCheckValidation: controller.errorBool.value,
//                               validationMsg: controller.emailErrorMessage.value,
//                               keyboardType: TextInputType.emailAddress,
//                               showCursor: true,
//                               hintText: AppStrings.hintEmail.tr.trim(),
//                               onChanged: (value) {
//                                 if (GetUtils.isEmail(value)) {
//                                   controller.errorBool.value = false;
//                                 }
//                               },
//                             ),
//                             SizedBox(
//                               height: 24.h,
//                             ),
//                             addResetScreenButton()
//                             // CommonButton(
//                             //   minWidth: 1.sw,
//                             //   commonButtonBottonText: AppStrings.resetPassword.tr,
//                             //   bgColor: lightColorPalette.secondarySwatch.shade900,
//                             //   radius: 8.r,
//                             //   style: lightTextTheme.headline3?.copyWith(
//                             //       fontSize: 16.sp,
//                             //       fontFamily: CommonStrings.generalSans,
//                             //       fontWeight: FontWeight.w500,
//                             //       color:
//                             //           lightColorPalette.whiteColorPrimary.shade900),
//                             //   onPress: () {
//                             //     controller.resetPassword();
//                             //   },
//                             // ).paddingOnly(top: 30.h),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ))
//         ]));
//   }

//   addResetScreenButton() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         CommonButton(
//           commonButtonBottonText: AppStrings.back.tr,
//           bgColor: lightColorPalette.whiteColorPrimary.shade900,
//           minWidth: 100.w,
//           style: lightTextTheme.bodyLarge?.copyWith(
//               fontSize: 14.sp,
//               fontFamily: CommonStrings.generalSans,
//               fontWeight: FontWeight.w600,
//               color: lightColorPalette.additionalSwatch1.shade600),
//           isIconEnable: true,
//           // image: ImageResource.backArrow,
//           type: ShowImagePositionAt.left,
//           onPress: () {
//             Get.back();
//           },
//         ),
//         CommonButton(
//           commonButtonBottonText: AppStrings.submit.tr,
//           bgColor: lightColorPalette.secondarySwatch.shade900,
//           minWidth: 100.w,
//           style: lightTextTheme.bodyLarge?.copyWith(
//               fontSize: 14.sp,
//               fontFamily: CommonStrings.generalSans,
//               fontWeight: FontWeight.w600,
//               color: lightColorPalette.whiteColorPrimary.shade900),
//           isIconEnable: true,
//           // image: ImageResource.forwardArrow,
//           type: ShowImagePositionAt.right,
//           onPress: () {
//             controller.resetPassword();
//           },
//         ),
//       ],
//     ).paddingOnly(left: 2.w, right: 2.w);
//   }
// }
