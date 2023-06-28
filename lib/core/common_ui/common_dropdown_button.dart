import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';

Widget dropdownField(
    {String hint = "",
    required DropdownModel selectedValue,
    required Function(DropdownModel value) onClick,
    EdgeInsetsGeometry? padding,
    required List<DropdownModel> list,
    bool? isExpanded,
    bool isMandatory = false,
    bool isShowRightButton = false,
    String? title,
    Widget? rightButtonDesign,
    bool isCheckValidation = false,
    Function()? onTap,
    String? validationMsg}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null)
        Text(title,
            style: lightTextTheme.bodyLarge?.copyWith(
              fontSize: 14.sp,
              fontFamily: CommonStrings.generalSans,
              fontWeight: FontWeight.w700,
              color: lightColorPalette.additionalSwatch1.shade900,
            )).paddingOnly(left: 1.5.w, bottom: 5.w),
      Container(
          height: 49.h,
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
          decoration: BoxDecoration(
            color: lightColorPalette.whiteColorPrimary.shade900,
            border: Border.all(
                style: BorderStyle.solid,
                //strokeAlign: 1.h,
                color: isCheckValidation == false
                    ? lightColorPalette.additionalSwatch1.shade800
                    : lightColorPalette.redDark,
                width: 1.w),
            borderRadius: BorderRadius.all(Radius.circular(6.r)),
          ),
          child: DropdownButton2<DropdownModel>(
            isDense: true,
            menuItemStyleData:
                MenuItemStyleData(padding: EdgeInsets.only(left: 16.w)),
            dropdownStyleData: DropdownStyleData(
                offset: const Offset(0, -18),
                elevation: 3,
                maxHeight: 300.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6.r),
                  color: lightColorPalette.whiteColorPrimary.shade900,
                )),
            isExpanded: isExpanded ?? false,
            underline: const SizedBox(),
            iconStyleData: IconStyleData(
              icon: Icon(Icons.arrow_drop_down,
                      color: lightColorPalette.additionalSwatch1.shade900,
                      size: 25.h)
                  .paddingOnly(right: 4.w),
            ),
            hint: Text(
              hint,
              style: lightTextTheme.bodyLarge?.copyWith(
                fontSize: 14.sp,
                fontFamily: CommonStrings.generalSans,
                fontWeight: FontWeight.w400,
                color: lightColorPalette.additionalSwatch1.shade700,
              ),
            ),
            value: selectedValue,
            items: list
                .map((DropdownModel model) => DropdownMenuItem<DropdownModel>(
                      value: model,
                      child: Text(
                        model.name,
                        style: lightTextTheme.bodyLarge?.copyWith(
                          fontSize: 14.sp,
                          fontFamily: CommonStrings.generalSans,
                          fontWeight: FontWeight.w400,
                          color: lightColorPalette.additionalSwatch1.shade900,
                        ),
                      ),
                    ))
                .toList(),
            onChanged: (DropdownModel? value) {
              onClick(value!);
            },
          )).paddingOnly(right: 1.w, left: 1.w),
      if (isCheckValidation)
        Text(validationMsg ?? AppStrings.thisFieldIsRequired.tr,
                style: lightTextTheme.bodyLarge?.copyWith(
                    color: Colors.red,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    fontFamily: CommonStrings.generalSans))
            .paddingOnly(left: 8.w)
    ],
  ).paddingOnly(left: 2.w, right: 2.w);
}

class DropdownModel extends Equatable {
  String id, name, status, type;
  bool isActive;
  DropdownModel(
      {this.id = "",
      this.name = "",
      this.status = "",
      this.type = "",
      this.isActive = true});
  @override
  String toString() => name;
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, status, type];
}
