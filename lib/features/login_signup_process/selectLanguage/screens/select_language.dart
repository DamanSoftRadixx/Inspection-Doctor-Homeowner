import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/controller/select_language_controller.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/model/select_language_model.dart';

class SelectLanguageScreen extends GetView<SelectLanguageController> {
  const SelectLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColorPalette.backgroundColor,
        appBar: commonAppBar(),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 5.h),
                itemCount: languageList.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  LanguageModel value = languageList[index];
                  return Container(
                    margin: EdgeInsets.only(left: 20.w, top: 20.h, right: 20.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: lightColorPalette.stroke)),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            AssetWidget(
                              asset:
                                  Asset(type: AssetType.svg, path: value.icon),
                              boxFit: BoxFit.fitWidth,
                            ).paddingOnly(right: 7.5.w),
                            AppTextWidget(
                              text: value.languageName,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    color: lightColorPalette.primaryDarkblue,
                                  ),
                            ),
                          ],
                        ),
                        InkWell(
                          child: AppTextWidget(
                              text: value.languageName,
                              style: LightTextTheme.heading_1(
                                  color: lightColorPalette.primaryDarkblue)),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
