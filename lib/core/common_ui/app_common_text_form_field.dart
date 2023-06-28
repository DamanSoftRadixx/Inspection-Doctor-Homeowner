import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';

class AppTextFormField extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? labelText;
  final Function(String?)? onSaved;
  final TextInputType keyboardType;
  final dynamic focusedErrorBorder;
  final dynamic validator;
  final bool isCheckValidation;
  final TextInputAction textInputAction;
  final FloatingLabelBehavior floatingLabelBehavior;
  final String? validationMsg;
  final int? helperMaxLines, maxLines, maxLength, errorMaxLines;

  final TextStyle? helperStyle,
      labelStyle,
      style,
      hintStyle,
      prefixStyle,
      floatingLabelStyle;

  final String? helperText, counterText, hintText, prefixText, initialValue;

  final TextAlign textAlign;

  final Widget? prefix, prefixIcon, suffixIcon;

  final BoxConstraints? prefixIconConstraints;

  final Function()? onEditingComplete, onTap;
  final bool readOnly;
  final bool? showCursor;
  final bool? filled;
  final bool? obscureText;

  final TextCapitalization textCapitalization;
  final InputBorder? enabledBorder, focusedBorder;
  final TextDirection? hintTextDirection;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? errorBorder;
  final dynamic title;
  final dynamic errorBool;

  final Color? fillColor;
  final bool? enabled;

  const AppTextFormField(
      {Key? key,
      this.inputFormatters,
      this.onChanged,
      this.focusNode,
      this.controller,
      this.validationMsg,
      this.suffixIcon,
      this.obscureText,
      this.labelText,
      this.onSaved,
      this.showCursor,
      required this.keyboardType,
      this.textInputAction = TextInputAction.next,
      this.floatingLabelBehavior = FloatingLabelBehavior.never,
      this.maxLength,
      this.helperStyle,
      this.helperText,
      this.style,
      this.helperMaxLines,
      this.maxLines,
      this.counterText = "",
      this.errorMaxLines,
      this.labelStyle,
      this.textAlign = TextAlign.start,
      this.hintStyle,
      this.hintText,
      this.prefixStyle,
      this.prefixText,
      this.prefix,
      this.prefixIcon,
      this.prefixIconConstraints,
      this.floatingLabelStyle,
      this.onEditingComplete,
      this.initialValue,
      this.readOnly = false,
      this.validator,
      this.isCheckValidation = false,
      this.textCapitalization = TextCapitalization.none,
      this.enabledBorder,
      this.focusedBorder,
      this.hintTextDirection,
      this.contentPadding,
      this.onTap,
      this.fillColor,
      this.focusedErrorBorder,
      this.filled,
      this.errorBorder,
      this.title,
      this.errorBool,
      this.enabled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? ""),
        TextFormField(
          obscureText: obscureText ?? false,
          onTap: onTap,
          readOnly: readOnly,
          initialValue: initialValue,
          onEditingComplete: onEditingComplete,
          textCapitalization: textCapitalization,
          textAlign: textAlign,
          textInputAction: textInputAction,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters ?? [NoLeadingSpaceFormatter()],
          focusNode: focusNode,
          onChanged: onChanged,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
          controller: controller,
          showCursor: showCursor ?? true,
          obscuringCharacter: "•",
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: true,
          style: style ??
              lightTextTheme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  fontFamily: CommonStrings.vitnamPro,
                  fontWeight: FontWeight.w400,
                  color: lightColorPalette.additionalSwatch1.shade900),
          decoration: InputDecoration(
            floatingLabelStyle: floatingLabelStyle,
            //  floatingLabelBehavior: floatingLabelBehavior,
            contentPadding: contentPadding,
            prefixIconConstraints: prefixIconConstraints,
            isDense: true,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            fillColor:
                fillColor ?? lightColorPalette.whiteColorPrimary.shade900,
            filled: true,
            // hintTextDirection: hintTextDirection,
            prefix: prefix,
            prefixText: prefixText,

            prefixStyle: prefixStyle,
            errorMaxLines: errorMaxLines,
            helperMaxLines: helperMaxLines,
            helperStyle: helperStyle,
            helperText: helperText,
            hintText: hintText,
            hintStyle: hintStyle ??
                lightTextTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontFamily: CommonStrings.vitnamPro,
                    fontWeight: FontWeight.w300,
                    color: lightColorPalette.additionalSwatch1.shade700),
            counterText: counterText,
            labelText: labelText,
            labelStyle: labelStyle ??
                lightTextTheme.bodyMedium?.copyWith(
                    fontSize: 14.sp,
                    fontFamily: CommonStrings.vitnamPro,
                    fontWeight: FontWeight.w400,
                    color: lightColorPalette.additionalSwatch1.shade900),
            errorBorder: errorBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                    borderSide: BorderSide(
                        width: 1.0.w,
                        color: isCheckValidation
                            ? lightColorPalette.redDark
                            : lightColorPalette.additionalSwatch1.shade800)),
            enabledBorder: enabledBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                    borderSide: BorderSide(
                        width: 1.0.w,
                        color: isCheckValidation
                            ? lightColorPalette.redDark
                            : lightColorPalette.additionalSwatch1.shade800)),
            focusedBorder: focusedBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                    borderSide: BorderSide(
                        width: 1.0.w,
                        color: isCheckValidation
                            ? lightColorPalette.redDark
                            : lightColorPalette.additionalSwatch1.shade800)),
            focusedErrorBorder: focusedErrorBorder ??
                OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                    borderSide: BorderSide(
                        width: 1.0.w,
                        color: isCheckValidation
                            ? lightColorPalette.redDark
                            : lightColorPalette.additionalSwatch1.shade800)),
          ),
          onSaved: onSaved,
          validator: validator,
        ),
        if (isCheckValidation)
          Text(validationMsg ?? AppStrings.thisFieldIsRequired.tr,
                  style: lightTextTheme.bodyLarge?.copyWith(
                      color: Colors.red,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w600,
                      fontFamily: CommonStrings.vitnamPro))
              .paddingOnly(left: 8.w),
      ],
    );
  }
}
