import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/profile/controlller/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
          body: WillPopScope(
            onWillPop: () async => false,
            child: SafeArea(
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      dismissKeyboard();
                    },
                  ),
                  CommonLoader(isLoading: controller.isShowLoader.value)
                ],
              ),
            ),
          ),
        ));
  }
}
