import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

const double _kSize = 80;

class CommonLoader extends StatelessWidget {
  final bool isLoading;

  const CommonLoader({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Container(
        color: lightColorPalette.transparentColor,
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
              color: lightColorPalette.black,
              size: _kSize,
            ),
          ),
        ),
      ),
    );
  }
}
