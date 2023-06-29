import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

// class AppTextFormField extends StatelessWidget {
//   final List<TextInputFormatter>? inputFormatters;
//   final Function(String)? onChanged;
//   final FocusNode? focusNode;
//   final TextEditingController? controller;
//   final String? labelText;
//   final Function(String?)? onSaved;
//   final TextInputType keyboardType;
//   final dynamic focusedErrorBorder;
//   final dynamic validator;
//   final bool isCheckValidation;
//   final TextInputAction textInputAction;
//   final FloatingLabelBehavior floatingLabelBehavior;
//   final String? validationMsg;
//   final int? helperMaxLines, maxLines, maxLength, errorMaxLines;

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
//   final bool isFoucs;

//   const AppTextFormField(
//       {Key? key,
//       this.inputFormatters,
//       this.onChanged,
//       this.focusNode,
//       this.controller,
//       this.validationMsg,
//       this.suffixIcon,
//       this.obscureText,
//       this.labelText,
//       this.onSaved,
//       this.showCursor,
//       required this.keyboardType,
//       this.textInputAction = TextInputAction.next,
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
//       this.isCheckValidation = false,
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
//       this.enabled,
//       required this.isFoucs})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         AppTextWidget(
//           text: title,
//           style: CustomTextTheme.normalText(
//             color: lightColorPalette.primaryDarkblue,
//           ),
//         ).paddingOnly(bottom: 3.h),
//         AnimatedContainer(
//           duration: const Duration(seconds: 5),
//           margin: const EdgeInsets.all(16),
//           decoration: isFoucs
//               ? const BoxDecoration(boxShadow: [BoxShadow(blurRadius: 6)])
//               : null,
//           child: TextFormField(
//             obscureText: obscureText ?? false,
//             onTap: onTap,
//             readOnly: readOnly,
//             initialValue: initialValue,
//             onEditingComplete: onEditingComplete,
//             textCapitalization: textCapitalization,
//             textAlign: textAlign,
//             textInputAction: textInputAction,
//             keyboardType: keyboardType,
//             inputFormatters: inputFormatters ?? [NoLeadingSpaceFormatter()],
//             focusNode: focusNode,
//             onChanged: onChanged,
//             maxLines: maxLines ?? 1,
//             maxLength: maxLength,
//             controller: controller,
//             showCursor: showCursor ?? true,
//             obscuringCharacter: "•",
//             autocorrect: false,
//             enableSuggestions: false,
//             enableInteractiveSelection: true,
//             style: style ??
//                 CustomTextTheme.normalText(
//                     color: lightColorPalette.primaryDarkblue),
//             decoration: InputDecoration(
//               floatingLabelStyle: floatingLabelStyle,
//               //  floatingLabelBehavior: floatingLabelBehavior,
//               contentPadding: contentPadding,
//               prefixIconConstraints: prefixIconConstraints,
//               isDense: true,
//               prefixIcon: prefixIcon,
//               suffixIcon: suffixIcon,
//               fillColor:
//                   fillColor ?? lightColorPalette.whiteColorPrimary.shade900,
//               filled: true,
//               // hintTextDirection: hintTextDirection,
//               prefix: prefix,
//               prefixText: prefixText,

//               prefixStyle: prefixStyle,
//               errorMaxLines: errorMaxLines,
//               helperMaxLines: helperMaxLines,
//               helperStyle: helperStyle,
//               helperText: helperText,
//               hintText: hintText,
//               hintStyle:
//hintStyle ??
//                   CustomTextTheme.normalText(
//                       color:
//                           lightColorPalette.primaryDarkblue.withOpacity(0.5)),
//               counterText: counterText,
//               labelText: labelText,
//               labelStyle: labelStyle ??
//                   CustomTextTheme.normalText(
//                       color: lightColorPalette.primaryDarkblue),
//               errorBorder: errorBorder ??
//                   OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
//                       borderSide: BorderSide(
//                           width: 1.0.w,
//                           color: isCheckValidation
//                               ? lightColorPalette.redDark
//                               : lightColorPalette.primaryBlue)),
//               enabledBorder: enabledBorder ??
//                   OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
//                       borderSide: BorderSide(
//                           width: 1.0.w,
//                           color: isCheckValidation
//                               ? lightColorPalette.redDark
//                               : lightColorPalette.primaryBlue)),
//               focusedBorder: focusedBorder ??
//                   OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
//                       borderSide: BorderSide(
//                           width: 1.0.w,
//                           color: isCheckValidation
//                               ? lightColorPalette.redDark
//                               : lightColorPalette.primaryBlue)),
//               focusedErrorBorder: focusedErrorBorder ??
//                   OutlineInputBorder(
//                       borderRadius: BorderRadius.all(Radius.circular(4.0.r)),
//                       borderSide: BorderSide(
//                           width: 1.0.w,
//                           color: isCheckValidation
//                               ? lightColorPalette.redDark
//                               : lightColorPalette.stroke)),
//             ),
//             onSaved: onSaved,
//             validator: validator,
//           ),
//         ),
//         if (isCheckValidation)
//           Text(
//             validationMsg ?? AppStrings.thisFieldIsRequired.tr,
//             style: CustomTextTheme.normalText(
//                 color: lightColorPalette.primaryDarkblue),
//           ).paddingOnly(left: 8.w),
//       ],
//     );
//   }
// }

Widget commonTextFieldWidget(
    {required TextEditingController controller,
    String? title,
    String? hint,
    FocusNode? focusNode,
    Function(String value)? onChanged,
    String? errorMsg,
    bool? isError,
    bool? readOnly,
    bool? autoFocus,
    TextInputType? keyboardType,
    TextInputAction? textInputAction}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (title != null && title != "")
        Padding(
          padding: const EdgeInsets.only(bottom: 1.0),
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
            text: title ?? "",
            textAlign: TextAlign.center,
            // TextStyle(fontSize: 16.sp),
          ),
        ),
      Container(
        width: 1.sw,
        height: 44.h,
        padding: EdgeInsets.only(top: 0.h),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            shape: BoxShape.rectangle,
            boxShadow: focusNode != null && focusNode.hasFocus
                ? [
                    BoxShadow(
                      blurRadius: 14,
                      color: lightColorPalette.primaryBlue.withOpacity(0.25),
                      offset: const Offset(0, 6),
                      spreadRadius: 0,
                    ),
                  ]
                : [],
            border: Border.all(color: lightColorPalette.primaryBlue, width: 1)),
        child: Center(
          child: TextFormField(
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            controller: controller,
            maxLines: 1,
            minLines: 1,
            onChanged: onChanged,
            expands: false,
            readOnly: readOnly ?? false,
            autofocus: autoFocus ?? false,
            focusNode: focusNode ?? FocusNode(),
            decoration: InputDecoration(
              isCollapsed: true,
              contentPadding: EdgeInsets.only(left: 15.0, right: 15.w),
              border: InputBorder.none,
              hintText: hint ?? "",
              hintStyle: CustomTextTheme.normalText(
                  color: lightColorPalette.primaryDarkblue.withOpacity(0.5)),
              // contentPadding: EdgeInsets.only(left:10.w,right: 10.w,top: 0.h),
            ),
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryDarkblue),
          ),
        ),
      ),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
          ),
        ),
      )
    ],
  );
}

commonPasswordText(
    {required final String title,
    required bool passwordVisible,
    final VoidCallback? onPress,
    required final TextEditingController controller,
    FocusNode? focusNode,
    String? errorMsg,
    bool? isError,
    String? hint,
    Function(String value)? onChanged,
    TextInputType? keyboardType,
    TextInputAction? textInputAction}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != "")
        Padding(
          padding: const EdgeInsets.only(bottom: 1.0),
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
            text: title ?? "",
            textAlign: TextAlign.center,
            // TextStyle(fontSize: 16.sp),
          ),
        ),
      Container(
        width: 1.sw,
        height: 44.h,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.r),
            shape: BoxShape.rectangle,
            boxShadow: focusNode != null && focusNode.hasFocus
                ? [
                    BoxShadow(
                      blurRadius: 14,
                      color: lightColorPalette.primaryBlue.withOpacity(0.25),
                      offset: const Offset(0, 6),
                      spreadRadius: 0,
                    ),
                  ]
                : [],
            border: Border.all(color: lightColorPalette.primaryBlue, width: 1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 8,
              child: TextFormField(
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                maxLines: 1,
                minLines: 1,
                expands: false,
                focusNode: focusNode ?? FocusNode(),
                controller: controller,
                obscureText: passwordVisible,
                onChanged: onChanged,
                decoration: InputDecoration(
                  hintStyle: CustomTextTheme.normalText(
                      color:
                          lightColorPalette.primaryDarkblue.withOpacity(0.5)),
                  border: InputBorder.none,
                  hintText: hint ?? "",
                  isCollapsed: true,
                  contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                ),
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryDarkblue),
              ),
            ),
            Flexible(
                flex: 1,
                child: CustomInkwell(
                  padding: EdgeInsets.zero,
                  onTap: onPress == null
                      ? null
                      : () {
                          onPress();
                        },
                  child: passwordVisible
                      ? AssetWidget(
                          asset: Asset(
                              type: AssetType.svg, path: ImageResource.hideEye),
                        )
                      : AssetWidget(
                          asset: Asset(
                              type: AssetType.svg, path: ImageResource.openEye),
                        ),
                )),
          ],
        ),
      ),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
          ),
        ),
      ),
    ],
  );
}

// commonPhoneText({
//   required final TextEditingController controller,
//   required final String title,
//   required String countryCode,
//   FocusNode? focusNode,
//   required void Function(Country) onSelect,
//   String? errorMsg,
//   bool? isError,
//   Function(String value)? onChanged,
// }) {
//   return Column(
//     mainAxisAlignment = MainAxisAlignment.center,
//     crossAxisAlignment = CrossAxisAlignment.start,
//     children = [
//       if (titleLarge != "")
//         Padding(
//           padding: const EdgeInsets.only(bottom: 1.0),
//           child: AppTextWidget(
//             style: lightTextTheme.titleLarge?.copyWith(
//               fontSize: 12.sp,
//               fontFamily: CommonStrings.sfProText,
//               fontWeight: FontWeight.w600,
//               color: lightColorPalette.additionalSwatch1.shade800,
//               letterSpacing: -0.12,
//             ),
//             text: titleLarge ?? "",
//             textAlign: TextAlign.center,
//             // TextStyle(fontSize: 16.sp),
//           ),
//         ),
//       Container(
//         width: 1.sw,
//         height: 44.h,
//         decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(6.r),
//             shape: BoxShape.rectangle,
//             boxShadow: focusNode != null && focusNode.hasFocus
//                 ? [
//                     BoxShadow(
//                       blurRadius: 0,
//                       color: lightColorPalette.primarySwatch.shade900,
//                       offset: const Offset(0, 4.5),
//                       spreadRadius: -2,
//                     ),
//                   ]
//                 : [],
//             border: Border.all(
//                 color: lightColorPalette.additionalSwatch1.shade900,
//                 width: 0.5)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             InkWell(
//               onTap: () {
//                 // dismissKeyboard();
//                 // showCountryPicker(
//                 //     context: context,
//                 //     showPhoneCode: true,
//                 //     onSelect: onSelect,

//                 //     /*   (Country country) {
//                 //         countryCode = country.phoneCode;
//                 //        */ /* print(controller.selectedCountryCode.value);*/ /*
//                 //       },*/
//                 //     countryListTheme: CountryListThemeData());
//               },
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Flexible(
//                     child: Text(
//                       countryCode.contains("+") ? countryCode : "+$countryCode",
//                       /*"+${countryCode}",*/
//                       style: focusNode != null && focusNode.hasFocus
//                           ? TextStyle(
//                               color: lightColorPalette.primarySwatch.shade900,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14.sp,
//                               letterSpacing: -0.4)
//                           : TextStyle(
//                               color: lightColorPalette.secondarySwatch.shade900,
//                               fontWeight: FontWeight.w500,
//                               fontSize: 14.sp,
//                               letterSpacing: -0.4),
//                     ).paddingSymmetric(horizontal: 15.w),
//                   ),
//                   VerticalDivider(
//                     thickness: 1.35,
//                     endIndent: 0,
//                     width: 3,
//                     indent: 0,
//                     color: lightColorPalette.secondarySwatch.shade900,
//                   ).paddingSymmetric(vertical: 12.h, horizontal: 0),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: TextFormField(
//                 controller: controller,
//                 focusNode: focusNode ?? FocusNode(),
//                 onChanged: onChanged,
//                 keyboardType: TextInputType.phone,
//                 inputFormatters: <TextInputFormatter>[
//                   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
//                 ],
//                 decoration: InputDecoration(
//                   border: InputBorder.none,
//                   isCollapsed: true,
//                   contentPadding: EdgeInsets.only(left: 10.0, right: 10.w),
//                   hintStyle: TextStyle(
//                     color: lightColorPalette.additionalSwatch1.shade900,
//                     fontWeight: FontWeight.w500,
//                     fontSize: 14.sp,
//                   ),

//                   // contentPadding: EdgeInsets.only(left:10.w,right: 10.w,bottom: 7.5.h,top: 0.h),
//                 ),
//                 style: focusNode != null && focusNode.hasFocus
//                     ? TextStyle(
//                         color: lightColorPalette.primarySwatch.shade900,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.sp,
//                         letterSpacing: -0.4)
//                     : TextStyle(
//                         color: lightColorPalette.secondarySwatch.shade900,
//                         fontWeight: FontWeight.w500,
//                         fontSize: 14.sp,
//                         letterSpacing: -0.4),
//               ),
//             ),
//           ],
//         ),
//       ),
//       Visibility(
//         visible: isError ?? false,
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: AppTextWidget(
//               text: errorMsg ?? "",
//               style: lightTextTheme.titleLarge?.copyWith(
//                 fontSize: 12.sp,
//                 fontFamily: CommonStrings.sfProText,
//                 fontWeight: FontWeight.w500,
//                 color: lightColorPalette.redSwatchPrimary.shade900,
//                 letterSpacing: -0.12,
//               )),
//         ),
//       ),
//       /*paddingOnly(left: 20.w, right: 20.w, top: 4.h),*/
//     ],
//   );
// }

// Widget dropdownField(
//     {String hint = "",
//     required DropdownModel selectedValue,
//     required Function(DropdownModel value) onClick,
//     EdgeInsetsGeometry? padding,
//     required List<DropdownModel> list,
//     bool? isExpanded,
//     bool isMandatory = false,
//     bool isShowRightButton = false,
//     String? title,
//     Widget? rightButtonDesign,
//     bool isCheckValidation = false,
//     Function()? onTap,
//     String? validationMsg}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       if (title != null && title != "")
//         Padding(
//           padding: const EdgeInsets.only(bottom: 1.0),
//           child: AppTextWidget(
//             style: lightTextTheme.titleLarge?.copyWith(
//               fontSize: 12.sp,
//               fontFamily: CommonStrings.sfProText,
//               fontWeight: FontWeight.w600,
//               color: lightColorPalette.additionalSwatch1.shade800,
//               letterSpacing: -0.12,
//             ),
//             text: title ?? "",
//             textAlign: TextAlign.center,
//             // TextStyle(fontSize: 16.sp),
//           ),
//         ),
//       Container(
//           width: 1.sw,
//           height: 44.h,
//           decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(6.r),
//               shape: BoxShape.rectangle,
//               border: Border.all(
//                   color: lightColorPalette.additionalSwatch1.shade900,
//                   width: 0.5)),
//           alignment: Alignment.center,
//           child: DropdownButton2<DropdownModel>(
//             isDense: true,
//             /* menuItemStyleData:
//                 MenuItemStyleData(padding: EdgeInsets.only(left: 24.w)),*/
//             dropdownStyleData: DropdownStyleData(
//                 offset: const Offset(0, -22),
//                 maxHeight: 300.h,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                           color: lightColorPalette.additionalSwatch1.shade900
//                               .withOpacity(0.4),
//                           spreadRadius: 4,
//                           blurRadius: 20,
//                           offset: const Offset(1, 1))
//                     ],
//                     borderRadius: BorderRadius.circular(6.r),
//                     shape: BoxShape.rectangle,
//                     border: Border.all(
//                         color: lightColorPalette.additionalSwatch1.shade900,
//                         width: 0.5))),
//             isExpanded: isExpanded ?? false,
//             underline: const SizedBox(),
//             customButton: Padding(
//               padding: EdgeInsets.only(right: 16.0.w, left: 16.0.w),
//               child: Row(
//                 children: [
//                   AppTextWidget(
//                     text: selectedValue.name,
//                     style: TextStyle(
//                       fontSize: 14.w,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: CommonStrings.sfProText,
//                       color: lightColorPalette.secondarySwatch.shade900,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                   const Spacer(),
//                   Padding(
//                     padding: EdgeInsets.only(left: 8.w),
//                     child: AssetWidget(
//                         asset: Asset(
//                             type: AssetType.svg,
//                             path: ImageResource.downArrowIcon)),
//                   )
//                 ],
//               ),
//             ),
//             iconStyleData: IconStyleData(
//               icon: Icon(Icons.arrow_drop_down,
//                       color: lightColorPalette.secondarySwatch.shade900,
//                       size: 25.h)
//                   .paddingOnly(right: 4.w),
//             ),
//             hint: Text(
//               hint,
//               style: TextStyle(
//                 color: lightColorPalette.additionalSwatch1.shade900,
//                 fontWeight: FontWeight.w500,
//                 fontSize: 14.sp,
//               ),
//             ),
//             buttonStyleData: ButtonStyleData(
//               padding: EdgeInsets.only(left: 2.w, right: 5.w),
//             ),
//             value: selectedValue.name == "" ? null : selectedValue,
//             selectedItemBuilder: (_) {
//               return list.map<Widget>((item) {
//                 return Row(
//                   children: [
//                     AppTextWidget(
//                       text: item.name.toString(),
//                       style: TextStyle(
//                         fontSize: 14.w,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: CommonStrings.sfProText,
//                         color: lightColorPalette.secondarySwatch.shade900,
//                       ),
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ],
//                 );
//               }).toList();
//             },
//             items: list
//                 .map((DropdownModel model) => DropdownMenuItem<DropdownModel>(
//                       value: model,
//                       child: DropdownMenuItem(
//                         value: model,
//                         child: StatefulBuilder(builder: (context, index) {
//                           return Padding(
//                             padding: EdgeInsets.only(right: 2.0.w, left: 5.0.w),
//                             child: Row(
//                               children: [
//                                 AppTextWidget(
//                                   text: model.name.toString(),
//                                   style: TextStyle(
//                                     fontSize: 14.w,
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: CommonStrings.sfProText,
//                                     color: lightColorPalette
//                                         .secondarySwatch.shade900,
//                                   ),
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                                 const Spacer(),
//                                 selectedValue.id == model.id
//                                     ? Padding(
//                                         padding: EdgeInsets.only(left: 8.w),
//                                         child: AssetWidget(
//                                             asset: Asset(
//                                                 type: AssetType.svg,
//                                                 path: ImageResource.rightIcon)),
//                                       )
//                                     : Container(),
//                               ],
//                             ),
//                           );
//                         }),
//                       ),
//                     ))
//                 .toList(),
//             onChanged: (DropdownModel? value) {
//               onClick(value!);
//             },
//           )),
//       if (isCheckValidation)
//         Text(validationMsg ?? AppStrings.thisFieldIsRequired.tr,
//                 style: lightTextTheme.bodyLarge?.copyWith(
//                     color: Colors.red,
//                     fontSize: 10.sp,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: CommonStrings.sfProText))
//             .paddingOnly(left: 8.w)
//     ],
//   );
// }

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
