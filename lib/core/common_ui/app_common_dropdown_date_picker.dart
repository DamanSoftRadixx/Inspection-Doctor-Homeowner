// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
// import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
// import 'package:inspection_doctor_homeowner/core/custom_libraries/date_picker_dropdown/date_picker_dropdown.dart';
// import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

// class AppDateTimeDropdown extends StatelessWidget {
//   final List<TextInputFormatter>? inputFormatters;
//   final Function(String) onSelectDay;
//   final Function(String) onSelectMonth;
//   final Function(String) onSelectYear;
//   final String? labelText;
//   final Function(String?)? onSaved;
//   final TextInputType keyboardType;
//   final dynamic focusedErrorBorder;
//   final dynamic validator;
//   final FloatingLabelBehavior floatingLabelBehavior;
//   final String? validationMsg;
//   final int? helperMaxLines, maxLines, maxLength, errorMaxLines;
//   final bool isCheckYearValidation;
//   final bool isCheckMonthValidation;
//   final isCheckDayValidation;

//   final TextStyle? helperStyle,
//       labelStyle,
//       style,
//       hintStyle,
//       prefixStyle,
//       floatingLabelStyle;

//   final String? helperText, counterText, hintText, prefixText, initialValue;

//   final TextAlign textAlign;

//   final Widget? prefix, prefixIcon, suffixIcon;

//   final BoxConstraints? prefixIconConstraints;

//   final Function()? onEditingComplete, onTap;
//   final bool readOnly;
//   final bool? showCursor;
//   final bool? filled;
//   final bool? obscureText;

//   final TextCapitalization textCapitalization;
//   final InputBorder? enabledBorder, focusedBorder;
//   final TextDirection? hintTextDirection;
//   final EdgeInsetsGeometry? contentPadding;
//   final InputBorder? errorBorder;
//   final dynamic title;
//   final dynamic errorBool;

//   final Color? fillColor;
//   final bool? enabled;

//   const AppDateTimeDropdown(
//       {Key? key,
//       this.inputFormatters,
//       required this.onSelectYear,
//       required this.onSelectMonth,
//       required this.onSelectDay,
//       this.validationMsg,
//       this.suffixIcon,
//       this.obscureText,
//       this.labelText,
//       this.onSaved,
//       this.showCursor,
//       required this.keyboardType,
//       this.floatingLabelBehavior = FloatingLabelBehavior.never,
//       this.maxLength,
//       this.helperStyle,
//       this.helperText,
//       this.style,
//       this.helperMaxLines,
//       this.maxLines,
//       this.counterText = "",
//       this.errorMaxLines,
//       this.labelStyle,
//       this.textAlign = TextAlign.start,
//       this.hintStyle,
//       this.hintText,
//       this.prefixStyle,
//       this.prefixText,
//       this.prefix,
//       this.prefixIcon,
//       this.prefixIconConstraints,
//       this.floatingLabelStyle,
//       this.onEditingComplete,
//       this.initialValue,
//       this.readOnly = false,
//       this.validator,
//       this.isCheckDayValidation = false,
//       this.isCheckYearValidation = false,
//       this.isCheckMonthValidation = false,
//       this.textCapitalization = TextCapitalization.none,
//       this.enabledBorder,
//       this.focusedBorder,
//       this.hintTextDirection,
//       this.contentPadding,
//       this.onTap,
//       this.fillColor,
//       this.focusedErrorBorder,
//       this.filled,
//       this.errorBorder,
//       this.title,
//       this.errorBool,
//       this.enabled})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         // Text(title ?? ""),
//         DatePickerDropdown(
//           inputDecoration: InputDecoration(
//             floatingLabelStyle: floatingLabelStyle,
//             //  floatingLabelBehavior: floatingLabelBehavior,
//             contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 13.h),

//             prefixIconConstraints: prefixIconConstraints,
//             isDense: true,
//             prefixIcon: prefixIcon,
//             suffixIcon: suffixIcon,
//             fillColor:
//                 fillColor ?? lightColorPalette.whiteColorPrimary.shade900,
//             filled: true,
//             // hintTextDirection: hintTextDirection,
//             prefix: prefix,
//             prefixText: prefixText,
//             prefixStyle: prefixStyle,
//             errorMaxLines: errorMaxLines,
//             helperMaxLines: helperMaxLines,
//             helperStyle: helperStyle,
//             helperText: helperText,
//             hintText: hintText,
//             hintStyle: hintStyle ??
//                 lightTextTheme.bodyMedium?.copyWith(
//                     fontSize: 14.sp,
//                     fontFamily: CommonStrings.generalSans,
//                     fontWeight: FontWeight.w400,
//                     color: lightColorPalette.additionalSwatch1.shade700),
//             counterText: counterText,
//             labelText: labelText,
//             labelStyle: labelStyle ??
//                 lightTextTheme.bodyMedium?.copyWith(
//                     fontSize: 14.sp,
//                     fontFamily: CommonStrings.generalSans,
//                     fontWeight: FontWeight.w400,
//                     color: lightColorPalette.additionalSwatch1.shade700),
//           ),
//           isDropdownHideUnderline: true, // optional
//           isFormValidator: true, // optional
//           startYear: 1900, // optional
//           endYear: 2020, // optional
//           width: 10, // optional
//           // selectedDay: 14, // optional
//           onChangedDay: (value) {
//             onSelectDay(value ?? "");
//           },
//           onChangedMonth: (value) {
//             onSelectMonth(value ?? "");
//           },
//           onChangedYear: (value) {
//             onSelectYear(value ?? "");
//           },
//           hintTextStyle: hintStyle ??
//               lightTextTheme.bodyMedium?.copyWith(
//                   fontSize: 14.sp,
//                   fontFamily: CommonStrings.generalSans,
//                   fontWeight: FontWeight.w400,
//                   color: lightColorPalette.additionalSwatch1.shade700),
//           yearFlex: 4,
//           monthFlex: 5,
//           dayFlex: 4,
//           hintMonth: "Of",
//           hintDay: "Date",
//           hintYear: "Birth",
//           isCheckDayValidation: isCheckDayValidation,
//           isCheckMonthValidation: isCheckMonthValidation,
//           isCheckYearValidation: isCheckYearValidation,
//           //boxDecoration: BoxDecoration(
//           // border: Border.all(color: Colors.grey, width: 1.0)), // optional
//           // showDay: false,// optional
//           // dayFlex: 2,// optional
//           // locale: "zh_CN",// optional
//           // hintDay: 'Day', // optional
//           // hintMonth: 'Month', // optional
//           // hintYear: 'Year', // optional
//           textStyle: style ??
//               lightTextTheme.bodyMedium?.copyWith(
//                   fontSize: 14.sp,
//                   fontFamily: CommonStrings.generalSans,
//                   fontWeight: FontWeight.w400,
//                   color: lightColorPalette.additionalSwatch1.shade900),
//         ),
//         if (isCheckDayValidation ||
//             isCheckMonthValidation ||
//             isCheckYearValidation)
//           Text(validationMsg ?? AppStrings.thisFieldIsRequired.tr,
//                   style: lightTextTheme.bodyLarge?.copyWith(
//                       color: Colors.red,
//                       fontSize: 10.sp,
//                       fontWeight: FontWeight.w600,
//                       fontFamily: CommonStrings.generalSans))
//               .paddingOnly(left: 7.w),
//       ],
//     ).paddingSymmetric(horizontal: 2.w);
//   }
// }
