import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';

class CommonAppBar extends StatelessWidget {
  String title;
  Function() onBackPress;
  Color? color;
  List<Widget>? actions;

  CommonAppBar(
      {Key? key,
      required this.title,
      required this.onBackPress,
      this.color,
      this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      color: color ?? lightColorPalette.primarySwatch.shade900,
      child: Column(
        children: [
          SizedBox(
            height: isIos ? 42.h : 46.h,
          ),
          Row(
            children: [
              Expanded(
                  flex: 1,
                  child: CustomIconButton(
                      onPressed: onBackPress,
                      icon: Icon(
                        Icons.arrow_back,
                        color: lightColorPalette.whiteColorPrimary.shade900,
                      ))),
              Expanded(
                  flex: 4,
                  child: Center(
                    child: AppTextWidget(
                      text: title,
                      style: lightTextTheme.displayLarge?.copyWith(
                          fontSize: 18.sp,
                          fontFamily: CommonStrings.vitnamPro,
                          fontWeight: FontWeight.w600,
                          color: lightColorPalette.whiteColorPrimary.shade900),
                      textAlign: TextAlign.center,
                    ),
                  )),
              const Expanded(flex: 1, child: SizedBox()),
            ],
          )
        ],
      ),
    );
  }
}
