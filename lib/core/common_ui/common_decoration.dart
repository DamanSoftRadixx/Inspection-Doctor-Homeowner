import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

showInputDecoration({required BuildContext context, required bool errorBool}) {
  return InputDecoration(
    isDense: true,
    contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 12.w),
    counterText: "",
    hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
        color: lightColorPalette.additionalSwatch1.shade800,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: CommonStrings.vitnamPro),
    focusedBorder:
        errorBool == true ? formFieldErrorDecoration() : formFocusDecoration(),
    border: errorBool == true
        ? formFieldErrorDecoration()
        : formFieldAcceptDecoration(),
    enabledBorder: errorBool == true
        ? formFieldErrorDecoration()
        : formFieldAcceptDecoration(),
    disabledBorder: errorBool == true
        ? formFieldErrorDecoration()
        : formFieldAcceptDecoration(),
    focusedErrorBorder: errorBool == true
        ? formFieldErrorDecoration()
        : formFieldAcceptDecoration(),
    fillColor: lightColorPalette.whiteColorPrimary.shade900,
    filled: true,
  );
}

formFieldAcceptDecoration() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.r),
    borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: lightColorPalette.additionalSwatch1.shade800),
  );
}

formFieldErrorDecoration() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.r),
    borderSide: BorderSide(
        width: 1, style: BorderStyle.solid, color: lightColorPalette.redDark),
  );
}

formFocusDecoration() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(6.r),
    borderSide: BorderSide(
        width: 1,
        style: BorderStyle.solid,
        color: lightColorPalette.additionalSwatch1.shade800),
  );
}
