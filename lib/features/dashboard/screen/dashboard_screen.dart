import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/features/dashboard/controller/dashboard_controller.dart';
import 'package:inspection_doctor_homeowner/features/dashboard/extension/dashboard_screen_extension.dart';

class DashBoardScreen extends GetView<DashboardController> {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          bottomNavigationBar: bottomWidget(),
          appBar: commonAppBarWithElevation(
              title: controller.getDashboardTitle(), isShowBackButton: false),
          body: SafeArea(
              child: Obx(() => Stack(
                    children: [
                      Column(
                        children: [
                          Expanded(child: tabScreens()),
                        ],
                      ),
                      CommonLoader(isLoading: controller.isLoading.value)
                    ],
                  ))),
        ));
  }
}
