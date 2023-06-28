import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_appbar.dart';
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
                itemCount: languageList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: const Row(
                      children: [],
                    ),
                  );
                },
              ),
            ),
          ],
        ));
  }
}
