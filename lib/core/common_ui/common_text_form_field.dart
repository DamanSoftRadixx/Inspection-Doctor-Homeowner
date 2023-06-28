import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

class CommonEmailTextFieldWidget extends StatelessWidget {
  final TextEditingController? controller;
  final FocusNode? node;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChange;
  final InputDecoration decoration;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final bool? showColorBorder;
  final String? initialValue;
  final bool? enabled;
  final bool? readOnly;
  final bool? isCenter;
  final int? maxLength;

  const CommonEmailTextFieldWidget({
    Key? key,
    this.controller,
    this.node,
    this.initialValue,
    required this.keyboardType,
    required this.textInputAction,
    required this.decoration,
    this.showColorBorder,
    this.validator,
    this.onChange,
    this.enabled,
    this.maxLength,
    this.readOnly = false,
    this.onTap,
    this.isCenter = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: initialValue,
        maxLines: 1,
        autocorrect: false,
        enableSuggestions: false,
        onTap: () {},
        textAlign: TextAlign.left,
        controller: controller,
        focusNode: node,
        maxLength: maxLength,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            RegExp('[a-zA-Z0-9@._]'),
          ),
        ],
        onChanged: onChange,
        enabled: true,
        style: Theme.of(context).textTheme.displayMedium?.copyWith(
            color: lightColorPalette.additionalSwatch1.shade900,
            fontWeight: FontWeight.w400,
            fontSize: 17.sp,
            fontFamily: CommonStrings.generalSans),
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        decoration: decoration);
  }
}
