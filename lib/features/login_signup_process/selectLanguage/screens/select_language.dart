// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/EmptyWidget/empty_widget.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
// import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
// import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
// import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
// import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/controller/select_language_controller.dart';
// import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/models/network_model/select_language_model.dart';

// class SelectLanguageScreen extends GetView<SelectLanguageController> {
//   const SelectLanguageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: lightColorPalette.backgroundColor,
//         appBar: commonAppBarWithElevation(
//             title: AppStrings.selectLanguage.tr, isShowBackButton: false),
//         body: Obx(() => SafeArea(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   controller.languageList.isNotEmpty
//                       ? Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             Expanded(
//                               child: ListView.builder(
//                                 padding: EdgeInsets.only(top: 5.h),
//                                 itemCount: controller.languageList.length,
//                                 shrinkWrap: true,
//                                 itemBuilder: (BuildContext context, int index) {
//                                   Language value =
//                                       controller.languageList[index];
//                                   return GestureDetector(
//                                     onTap: () {
//                                       controller.onTapCheckBox(value);
//                                     },
//                                     child: languageBoxShow(value),
//                                   );
//                                 },
//                               ),
//                             ),
//                             CommonButton(
//                                     commonButtonBottonText: AppStrings.continueBtn,
//                                     onPress: () {
//                                       controller.onTapContinueButton();
//                                     })
//                                 .paddingOnly(
//                                     bottom: 17.h, left: 20.w, right: 20.w)
//                           ],
//                         )
//                       : const EmptyWidget(),
//                   CommonLoader(isLoading: controller.isShowLoader.value)
//                 ],
//               ),
//             )));
//   }

//   languageBoxShow(Language value) {
//     return Obx(() => Container(
//           margin: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
//           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
//           decoration: decoration(isSelected: false),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   AssetWidget(
//                     asset: Asset(
//                         type: AssetType.svg,
//                         path: value.name == LanguageEnum.english.value
//                             ? ImageResource.flagUSA
//                             : value.name == LanguageEnum.spanish.value
//                                 ? ImageResource.flagSpain
//                                 : ""),
//                     boxFit: BoxFit.fitWidth,
//                   ).paddingOnly(right: 7.5.w),
//                   AppTextWidget(
//                     text: value.name ?? "",
//                     style: CustomTextTheme.buttonText(
//                       color: lightColorPalette.black,
//                     ),
//                   ),
//                 ],
//               ),
//               AssetWidget(
//                 asset: Asset(
//                     type: AssetType.svg,
//                     path: value.name == controller.selectedLanguage.value.name
//                         ? ImageResource.checked
//                         : ImageResource.unCheck),
//                 boxFit: BoxFit.fitWidth,
//               )
//             ],
//           ),
//         ));
//   }
// }
