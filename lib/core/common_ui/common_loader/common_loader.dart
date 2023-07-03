import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

class CommonLoader extends StatelessWidget {
  const CommonLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Card(
        color: lightColorPalette.backgroundColor,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}
