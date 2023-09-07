import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_loader/common_loader.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/payment/controller/payment_controller.dart';
import 'package:inspection_doctor_homeowner/features/payment/extensions/no_card_added_box.dart';

class PaymentScreen extends GetView<PaymentController> {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: () async => controller.isShowLoader.value ? false : true,
        child: Scaffold(
            backgroundColor: lightColorPalette.whiteColorPrimary.shade900,
            appBar: commonAppBarWithElevation(
                title: AppStrings.payments.tr,
                onPressBackButton: () {
                  controller.isShowLoader.value ? () {} : Get.back();
                }),
            body: InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () {
                dismissKeyboard();
              },
              child: SafeArea(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        noCardAddedYetWidget(isNoCard: false),
                      ],
                    ),
                    CommonLoader(isLoading: controller.isShowLoader.value)
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
