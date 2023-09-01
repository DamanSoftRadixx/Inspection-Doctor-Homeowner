import 'package:country_picker/country_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

Widget commonTextFieldWidget(
    {required TextEditingController controller,
    String? title,
    String? hint,
    required FocusNode focusNode,
    Function(String value)? onChanged,
    String? errorMsg,
    bool? isError,
    bool? readOnly,
    bool? autoFocus,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    int? maxLength,
    TextCapitalization? textCapitalization,
    List<TextInputFormatter>? inputFormatters,
    double? height,
    int? maxLines,
    bool? isShowStar = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (title != null && title != "")
        Row(
          children: [
            AppTextWidget(
              style: CustomTextTheme.normalText(
                color: lightColorPalette.black,
              ),
              text: title ?? "",
              textAlign: TextAlign.center,
            ),
            isShowStar == true
                ? AppTextWidget(
                    style: CustomTextTheme.normalText(
                      color: lightColorPalette.redDark,
                    ),
                    text: "*",
                    textAlign: TextAlign.center,
                  )
                : const SizedBox()
          ],
        ).paddingOnly(bottom: 3.0.h),
      GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: Container(
          width: 1.sw,
          // height: height ?? 44.h,
          constraints:
              BoxConstraints(minHeight: 44.h, maxHeight: height ?? 44.h),
          padding: EdgeInsets.only(top: 0.h),
          decoration: decoration(isSelected: focusNode.hasFocus),
          child: Center(
            child: TextFormField(
              inputFormatters: inputFormatters ?? const [],
              textCapitalization: textCapitalization ?? TextCapitalization.none,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              controller: controller,
              maxLines: maxLines ?? 1,
              minLines: 1,
              maxLength: maxLength ?? 300,
              onChanged: onChanged,
              expands: false,
              readOnly: readOnly ?? false,
              autofocus: autoFocus ?? false,
              focusNode: focusNode,
              decoration: InputDecoration(
                isCollapsed: true,
                counterText: "",
                contentPadding: EdgeInsets.only(left: 15.0, right: 15.w),
                border: InputBorder.none,
                hintText: hint ?? "",
                hintStyle: CustomTextTheme.normalText(
                    color: lightColorPalette.black.withOpacity(0.5)),
              ),
              style: CustomTextTheme.normalText(color: lightColorPalette.black),
            ),
          ),
        ),
      ),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.bottomTabs(
              color: lightColorPalette.redDark,
            ),
          ).paddingOnly(top: 5.h),
        ),
      )
    ],
  );
}

Widget commonPasswordText(
    {required final String title,
    required bool passwordVisible,
    final VoidCallback? onPress,
    required final TextEditingController controller,
    required FocusNode focusNode,
    String? errorMsg,
    bool? isError,
    String? hint,
    Function(String value)? onChanged,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    bool? isShowStar = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != "")
        Row(
          children: [
            AppTextWidget(
              style: CustomTextTheme.normalText(
                color: lightColorPalette.black,
              ),
              text: title ?? "",
              textAlign: TextAlign.center,
            ),
            isShowStar == true
                ? AppTextWidget(
                    style: CustomTextTheme.normalText(
                      color: lightColorPalette.redDark,
                    ),
                    text: "*",
                    textAlign: TextAlign.center,
                  )
                : const SizedBox()
          ],
        ).paddingOnly(bottom: 3.0.h),
      GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: Container(
          width: 1.sw,
          height: 44.h,
          decoration: decoration(isSelected: focusNode.hasFocus),
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
                  maxLength: 50,
                  focusNode: focusNode,
                  controller: controller,
                  obscureText: passwordVisible,
                  onChanged: onChanged,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.deny(RegExp(r'[ ]')),
                  ],
                  decoration: InputDecoration(
                    hintStyle: CustomTextTheme.normalText(
                        color: lightColorPalette.black.withOpacity(0.5)),
                    border: InputBorder.none,
                    counterText: "",
                    hintText: hint ?? "",
                    isCollapsed: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w),
                  ),
                  style: CustomTextTheme.normalText(
                      color: lightColorPalette.black),
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
                    child: AssetWidget(
                      color: lightColorPalette.black,
                      asset: Asset(
                          type: AssetType.svg,
                          path: passwordVisible
                              ? ImageResource.hideEye
                              : ImageResource.openEye),
                    ),
                  )),
            ],
          ),
        ),
      ),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.bottomTabs(
              color: lightColorPalette.redDark,
            ),
          ).paddingOnly(top: 5.h),
        ),
      ),
    ],
  );
}

Widget commonPhoneText(
    {required final TextEditingController controller,
    required final String title,
    required String countryCode,
    FocusNode? focusNode,
    required void Function(Country) onSelect,
    String? errorMsg,
    bool? isError,
    Function(String value)? onChanged,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    String? hint,
    bool? isShowStar = false}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != "")
        Row(
          children: [
            AppTextWidget(
              style: CustomTextTheme.normalText(
                color: lightColorPalette.black,
              ),
              text: title ?? "",
              textAlign: TextAlign.center,
            ),
            isShowStar == true
                ? AppTextWidget(
                    style: CustomTextTheme.normalText(
                      color: lightColorPalette.redDark,
                    ),
                    text: "*",
                    textAlign: TextAlign.center,
                  )
                : const SizedBox()
          ],
        ).paddingOnly(bottom: 3.0.h),
      Container(
        width: 1.sw,
        height: 44.h,
        decoration: decoration(isSelected: focusNode?.hasFocus ?? false),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomInkwell(
              padding: EdgeInsets.zero,
              onTap: () {
                dismissKeyboard();
                showCountryPicker(
                  context: Get.context!,
                  showPhoneCode: true,
                  onSelect: onSelect,
                  countryListTheme: CountryListThemeData(
                    bottomSheetHeight: .80.sh,
                    // inputDecoration: InputDecoration(
                    //   hintText: AppStrings.loginEmail,
                    //   border: OutlineInputBorder(
                    //       borderRadius:
                    //           BorderRadius.all(Radius.circular(12.0.r)),
                    //       borderSide: BorderSide(
                    //           color: lightColorPalette
                    //               .additionalSwatch1.shade800)),
                    //   focusedBorder: OutlineInputBorder(
                    //       borderRadius:
                    //           BorderRadius.all(Radius.circular(12.0.r)),
                    //       borderSide: BorderSide(
                    //           color: lightColorPalette
                    //               .additionalSwatch1.shade800)),
                    //   enabledBorder: OutlineInputBorder(
                    //       borderRadius:
                    //           BorderRadius.all(Radius.circular(12.0.r)),
                    //       borderSide: BorderSide(
                    //           color: lightColorPalette
                    //               .additionalSwatch1.shade800)),
                    // ),
                  ),
                );
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                            countryCode.contains("+")
                                ? countryCode
                                : "+$countryCode",
                            style: CustomTextTheme.normalText(
                                color: lightColorPalette.black))
                        .paddingOnly(left: 15.w, top: 1.h),
                  ),
                ],
              ),
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                focusNode: focusNode ?? FocusNode(),
                onChanged: onChanged,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                maxLength: 15,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: hint,
                  isCollapsed: true,
                  counterText: "",
                  contentPadding:
                      EdgeInsets.only(left: 10.0, right: 10.w, top: 2.h),
                  hintStyle: CustomTextTheme.normalText(
                      color: lightColorPalette.black.withOpacity(0.5)),
                ),
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.black),
              ),
            ),
          ],
        ),
      ),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.bottomTabs(
              color: lightColorPalette.redDark,
            ),
          ).paddingOnly(top: 5.h),
        ),
      ), /*paddingOnly(left: 20.w, right: 20.w, top: 4.h),*/
    ],
  );
}

Widget commonSearchFieldWidget({
  required TextEditingController controller,
  Function(String value)? onChanged,
  required FocusNode focusNode,
  required String searchHint,
}) {
  return GestureDetector(
    onTap: () {
      focusNode.requestFocus();
    },
    child: Container(
      width: 1.sw,
      height: 34.h,
      decoration: decorationSearchTextField(isSelected: focusNode.hasFocus),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 12.w,
          ),
          AssetWidget(
            color: lightColorPalette.grey,
            asset: Asset(
              type: AssetType.svg,
              path: ImageResource.searchIcon,
            ),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              maxLines: 1,
              minLines: 1,
              onChanged: onChanged,
              expands: false,
              focusNode: focusNode,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter(RegExp("[a-zA-Z0-9]"), allow: true),
              ],
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 15.w),
                border: InputBorder.none,
                hintText: searchHint,
                hintStyle: CustomTextTheme.normalText(
                    color: lightColorPalette.black.withOpacity(0.3)),
              ),
              style: CustomTextTheme.normalText(color: lightColorPalette.black),
            ),
          )
        ],
      ),
    ),
  );
}

Widget commonDateFieldWidget({
  required String selectedText,
  required Function() onTap,
  required FocusNode focusNode,
}) {
  return GestureDetector(
    onTap: () {
      focusNode.requestFocus();
    },
    child: Container(
      width: 1.sw,
      height: 32.h,
      decoration: decorationDateTextField(isSelected: selectedText != ""),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: TextFormField(
              controller: TextEditingController(text: selectedText),
              maxLines: 1,
              textAlign: TextAlign.center,
              minLines: 1,
              readOnly: true,
              onTap: () {
                onTap();
              },
              expands: false,
              focusNode: focusNode,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 8.w),
                border: InputBorder.none,
                hintText: "00:00",
                hintStyle: CustomTextTheme.normalText2(
                    color: lightColorPalette.black.withOpacity(0.5)),
              ),
              style:
                  CustomTextTheme.normalText2(color: lightColorPalette.black),
            ),
          )
        ],
      ),
    ),
  );
}

// Widget dropdownField(
//     {String? hint,
//     required DropdownModel selectedValue,
//     required Function(DropdownModel value) onClick,
//     EdgeInsetsGeometry? padding,
//     required List<DropdownModel> list,
//     bool? isExpanded,
//     bool isMandatory = false,
//     bool isShowRightButton = false,
//     String? title,
//     Widget? rightButtonDesign,
//     bool isError = false,
//     Function()? onTap,
//     String? errorMsg,
//     bool? isDisable,
//     bool hasFocus = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       if (title != null && title != "")
//         Padding(
//           padding: EdgeInsets.only(bottom: 3.h),
//           child: AppTextWidget(
//             style: CustomTextTheme.normalText(color: lightColorPalette.black),
//             text: title,
//             textAlign: TextAlign.center,
//           ),
//         ),
//       Container(
//           width: 1.sw,
//           height: 46.h,
//           decoration: decoration(isSelected: hasFocus),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButton2<DropdownModel>(
//               // isDense: true,
//               /* menuItemStyleData:
//                   MenuItemStyleData(padding: EdgeInsets.only(left: 24.w)),*/
//               dropdownStyleData: DropdownStyleData(
//                 // elevation: 3,
//                 offset: const Offset(0, -5.59),
//                 maxHeight: 300.h,
//                 decoration: BoxDecoration(
//                   color: lightColorPalette.whiteColorPrimary.shade900,
//                   boxShadow: [
//                     BoxShadow(
//                         color: lightColorPalette.black.withOpacity(0.10),
//                         spreadRadius: 2,
//                         blurRadius: 20,
//                         offset: const Offset(1, 1))
//                   ],
//                   borderRadius: BorderRadius.circular(10.r),
//                   shape: BoxShape.rectangle,
//                   border: Border.all(
//                       color: lightColorPalette.grey.withOpacity(0.3),
//                       width: 0.3),
//                 ),
//               ),
//               isExpanded: isExpanded ?? false,
//               underline: const SizedBox(),
//               customButton: Padding(
//                 padding: EdgeInsets.only(right: 16.0.w, left: 16.0.w),
//                 child: Row(
//                   children: [
//                     selectedValue.name == ""
//                         ? AppTextWidget(
//                             text: hint ?? "",
//                             style: CustomTextTheme.normalText(
//                                 color:
//                                     lightColorPalette.black.withOpacity(0.5)),
//                           )
//                         : AppTextWidget(
//                             text: selectedValue.name,
//                             style: CustomTextTheme.normalText(
//                                 color: lightColorPalette.black),
//                             overflow: TextOverflow.ellipsis,
//                           ),
//                     const Spacer(),
//                     Padding(
//                       padding: EdgeInsets.only(left: 8.w),
//                       child: Center(
//                         child: AssetWidget(
//                             asset: Asset(
//                                 type: AssetType.svg,
//                                 path: ImageResource.downArrow)),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               iconStyleData: IconStyleData(
//                 icon: Center(
//                   child: Icon(Icons.arrow_drop_down,
//                           color: lightColorPalette.black, size: 25.h)
//                       .paddingOnly(right: 4.w),
//                 ),
//               ),
//               hint: AppTextWidget(
//                 text: hint ?? "",
//                 style: CustomTextTheme.normalText(
//                     color: lightColorPalette.black.withOpacity(0.5)),
//               ),
//               buttonStyleData: ButtonStyleData(
//                 padding: EdgeInsets.only(left: 2.w, right: 5.w),
//               ),
//               value: selectedValue.name == "" ? null : selectedValue,
//               selectedItemBuilder: (_) {
//                 return list.map<Widget>((item) {
//                   return Row(
//                     children: [
//                       AppTextWidget(
//                         text: item.name.toString(),
//                         style: TextStyle(
//                           fontSize: 14.w,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: CommonStrings.generalSans,
//                           color: lightColorPalette.black,
//                         ),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ],
//                   );
//                 }).toList();
//               },
//               menuItemStyleData: MenuItemStyleData(
//                 padding: const EdgeInsets.symmetric(horizontal: 0.0),
//                 customHeights: getCustomItemsHeights(items: list),
//               ),
//               items: addDividersAfterItems(
//                   items: list, selectedValue: selectedValue),
//               onChanged: (DropdownModel? value) {
//                 onClick(value!);
//               },
//             ),
//           )),
//       Visibility(
//         visible: isError ?? false,
//         child: Align(
//           alignment: Alignment.topLeft,
//           child: AppTextWidget(
//             text: errorMsg ?? "",
//             style: CustomTextTheme.bottomTabs(
//               color: lightColorPalette.redDark,
//             ),
//           ).paddingOnly(top: 5.h),
//         ),
//       ),
//     ],
//   );
// }

Widget dropdownField(
    {String? hint,
    required DropdownModel selectedValue,
    required Function(DropdownModel value) onClick,
    EdgeInsetsGeometry? padding,
    required List<DropdownModel> list,
    bool? isExpanded,
    bool isMandatory = false,
    bool isShowRightButton = false,
    String? title,
    Widget? rightButtonDesign,
    bool isError = false,
    Function()? onTap,
    String? errorMsg,
    bool? isDisable,
    bool hasFocus = false,
    bool? isShowStar = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null && title != "")
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: Row(
            children: [
              AppTextWidget(
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.black),
                text: title,
                textAlign: TextAlign.center,
              ),
              isShowStar == true
                  ? AppTextWidget(
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.redDark,
                      ),
                      text: "*",
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      Container(
          width: 1.sw,
          height: 44.h,
          decoration: decoration(isSelected: hasFocus),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<DropdownModel>(
              // isDense: true,
              /* menuItemStyleData:
                  MenuItemStyleData(padding: EdgeInsets.only(left: 24.w)),*/
              dropdownStyleData: DropdownStyleData(
                // elevation: 3,
                offset: const Offset(0, -5.59),
                maxHeight: 300.h,
                decoration: BoxDecoration(
                  color: lightColorPalette.whiteColorPrimary.shade900,
                  boxShadow: [
                    BoxShadow(
                        color: lightColorPalette.black.withOpacity(0.10),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: const Offset(1, 1))
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: lightColorPalette.grey.withOpacity(0.3),
                      width: 0.3),
                ),
              ),
              isExpanded: isExpanded ?? false,
              underline: const SizedBox(),
              customButton: Padding(
                padding: EdgeInsets.only(right: 16.0.w, left: 16.0.w),
                child: Row(
                  children: [
                    selectedValue.name == ""
                        ? AppTextWidget(
                            text: hint ?? "",
                            style: CustomTextTheme.normalText(
                                color:
                                    lightColorPalette.black.withOpacity(0.5)),
                          )
                        : Row(
                            children: [
                              selectedValue.icon != ""
                                  ? AssetWidget(
                                          asset: Asset(
                                              type: AssetType.svg,
                                              path: selectedValue.icon))
                                      .paddingOnly(right: 5.w)
                                  : const SizedBox(),
                              AppTextWidget(
                                text: selectedValue.name,
                                style: CustomTextTheme.normalText(
                                    color: lightColorPalette.black),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Center(
                        child: AssetWidget(
                            asset: Asset(
                                type: AssetType.svg,
                                path: ImageResource.downArrow)),
                      ),
                    )
                  ],
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Center(
                  child: Icon(Icons.arrow_drop_down,
                          color: lightColorPalette.black, size: 25.h)
                      .paddingOnly(right: 4.w),
                ),
              ),
              hint: AppTextWidget(
                text: hint ?? "",
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.black.withOpacity(0.5)),
              ),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(left: 2.w, right: 5.w),
              ),
              value: selectedValue.name == "" ? null : selectedValue,
              selectedItemBuilder: (_) {
                return list.map<Widget>((item) {
                  return Row(
                    children: [
                      AppTextWidget(
                        text: item.name.toString(),
                        style: TextStyle(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: CommonStrings.generalSans,
                          color: lightColorPalette.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                }).toList();
              },
              menuItemStyleData: MenuItemStyleData(
                padding: const EdgeInsets.symmetric(horizontal: 0.0),
                customHeights: getCustomItemsHeights(items: list),
              ),
              items: addDividersAfterItems(
                  items: list,
                  selectedValue: selectedValue,
                  isDisable: isDisable),
              onChanged: (DropdownModel? value) {
                onClick(value!);
              },
            ),
          )),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.bottomTabs(
              color: lightColorPalette.redDark,
            ),
          ).paddingOnly(top: 5.h),
        ),
      ),
    ],
  );
}

Widget multiDropdownField(
    {String? hint,
    required DropdownModel selectedValue,
    required Function(DropdownModel value) onClick,
    EdgeInsetsGeometry? padding,
    required List<DropdownModel> list,
    bool? isExpanded,
    bool isMandatory = false,
    bool isShowRightButton = false,
    String? title,
    Widget? rightButtonDesign,
    bool isError = false,
    Function()? onTap,
    String? errorMsg,
    bool hasFocus = false,
    required RxList<DropdownModel> selectedItems,
    bool? isShowStar = false}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != null && title != "")
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: Row(
            children: [
              AppTextWidget(
                style:
                    CustomTextTheme.normalText(color: lightColorPalette.black),
                text: title,
                textAlign: TextAlign.center,
              ),
              isShowStar == true
                  ? AppTextWidget(
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.redDark,
                      ),
                      text: "*",
                      textAlign: TextAlign.center,
                    )
                  : const SizedBox()
            ],
          ),
        ),
      Container(
          width: 1.sw,
          height: 46.h,
          decoration: decoration(isSelected: hasFocus),
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<DropdownModel>(
              dropdownStyleData: DropdownStyleData(
                // elevation: 3,
                offset: const Offset(0, -5.59),
                maxHeight: 300.h,
                decoration: BoxDecoration(
                  color: lightColorPalette.whiteColorPrimary.shade900,
                  boxShadow: [
                    BoxShadow(
                        color: lightColorPalette.black.withOpacity(0.10),
                        spreadRadius: 2,
                        blurRadius: 20,
                        offset: const Offset(1, 1))
                  ],
                  borderRadius: BorderRadius.circular(10.r),
                  shape: BoxShape.rectangle,
                  border: Border.all(
                      color: lightColorPalette.grey.withOpacity(0.3),
                      width: 0.3),
                ),
              ),
              isExpanded: isExpanded ?? false,
              underline: const SizedBox(),
              customButton: Padding(
                padding: EdgeInsets.only(right: 16.0.w, left: 16.0.w),
                child: Row(
                  children: [
                    selectedValue.name == ""
                        ? AppTextWidget(
                            text: hint ?? "",
                            style: CustomTextTheme.normalText(
                                color:
                                    lightColorPalette.black.withOpacity(0.5)),
                          )
                        : AppTextWidget(
                            text: selectedValue.name,
                            style: CustomTextTheme.normalText(
                                color: lightColorPalette.black),
                            overflow: TextOverflow.ellipsis,
                          ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(left: 8.w),
                      child: Center(
                        child: AssetWidget(
                            asset: Asset(
                                type: AssetType.svg,
                                path: ImageResource.downArrow)),
                      ),
                    )
                  ],
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Center(
                  child: Icon(Icons.arrow_drop_down,
                          color: lightColorPalette.black, size: 25.h)
                      .paddingOnly(right: 4.w),
                ),
              ),
              hint: AppTextWidget(
                text: hint ?? "",
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.black.withOpacity(0.5)),
              ),
              buttonStyleData: ButtonStyleData(
                padding: EdgeInsets.only(left: 2.w, right: 5.w),
              ),
              value: selectedValue.name == "" ? null : selectedValue,
              selectedItemBuilder: (_) {
                return list.map<Widget>((item) {
                  return Row(
                    children: [
                      AppTextWidget(
                        text: item.name.toString(),
                        style: TextStyle(
                          fontSize: 14.w,
                          fontWeight: FontWeight.w500,
                          fontFamily: CommonStrings.generalSans,
                          color: lightColorPalette.black,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  );
                }).toList();
              },
              items: list.map((item) {
                return DropdownMenuItem(
                  value: item,
                  //disable default onTap to avoid closing menu when selecting an item
                  enabled: false,
                  child: Obx(() => InkWell(
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          onClick(item);
                        },
                        child: Row(
                          children: [
                            AppTextWidget(
                              text: item.name.toString(),
                              style: CustomTextTheme.normalText(
                                  color: selectedValue.id == item.id
                                      ? lightColorPalette.black
                                      : lightColorPalette.black),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            selectedItems.value.contains(item)
                                ? AssetWidget(
                                    color: Colors.green,
                                    asset: Asset(
                                        type: AssetType.svg,
                                        path: ImageResource.selectedCheckbox),
                                  )
                                : AssetWidget(
                                    asset: Asset(
                                        type: AssetType.svg,
                                        path: ImageResource.unSelectedCheckbox),
                                  )
                          ],
                        ),
                      )),
                );
              }).toList(),
              onChanged: (DropdownModel? value) {},
            ),
          )),
      Visibility(
        visible: isError ?? false,
        child: Align(
          alignment: Alignment.topLeft,
          child: AppTextWidget(
            text: errorMsg ?? "",
            style: CustomTextTheme.bottomTabs(
              color: lightColorPalette.redDark,
            ),
          ).paddingOnly(top: 5.h),
        ),
      ),
    ],
  );
}

class DropdownModel extends Equatable {
  String id, name, status, type, stateId, startTime, endTime, icon;
  bool isActive;
  DropdownModel(
      {this.id = "",
      this.name = "",
      this.status = "",
      this.type = "",
      this.stateId = "",
      this.startTime = "",
      this.endTime = "",
      this.isActive = true,
      this.icon = ""});
  @override
  String toString() => name;
  @override
  // TODO: implement props
  List<Object?> get props => [id, name, status, type];
}

// List<DropdownMenuItem<DropdownModel>> addDividersAfterItems(
//     {required List<DropdownModel> items,
//     required DropdownModel selectedValue}) {
//   List<DropdownMenuItem<DropdownModel>>? menuItems = [];
//   for (final DropdownModel item in items) {
//     menuItems.addAll(
//       [
//         DropdownMenuItem<DropdownModel>(
//           value: item,
//           child: Row(
//             children: [
//               AppTextWidget(
//                 text: item.name.toString(),
//                 style: CustomTextTheme.normalText(
//                     color: selectedValue.id == item.id
//                         ? lightColorPalette.black
//                         : lightColorPalette.black),
//                 overflow: TextOverflow.ellipsis,
//               ),
//               const Spacer(),
//               selectedValue.id == item.id
//                   ? AssetWidget(
//                       color: Colors.green,
//                       asset: Asset(
//                           type: AssetType.svg, path: ImageResource.checked),
//                     )
//                   : AssetWidget(
//                       asset: Asset(
//                           type: AssetType.svg, path: ImageResource.unCheck),
//                     ),
//             ],
//           ).paddingSymmetric(horizontal: 15.w),
//         ),
//         //If it's last item, we will not add Divider after it.
//         if (item != items.last)
//           const DropdownMenuItem<DropdownModel>(
//             enabled: false,
//             child: Divider(),
//           ),
//       ],
//     );
//   }
//   return menuItems;
// }

List<double> getCustomItemsHeights({required List<DropdownModel> items}) {
  final List<double> itemsHeights = [];
  for (int i = 0; i < (items.length * 2) - 1; i++) {
    if (i.isEven) {
      itemsHeights.add(32);
    }
    //Dividers indexes will be the odd indexes
    if (i.isOdd) {
      itemsHeights.add(4);
    }
  }
  return itemsHeights;
}

Widget commonDatePicker(
    {required final String title,
    FocusNode? focusNode,
    String? errorMsg,
    bool? isError,
    String? hint,
    bool? isShowStar = false,
    required dynamic Function(DateTime) onPicked,
    String? selectedDate}) {
  return GestureDetector(
    onTap: () {
      showDatePickerDialog(onPicked: onPicked, firstDated: DateTime.now());
    },
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != "")
          Padding(
            padding: EdgeInsets.only(bottom: 3.h),
            child: Row(
              children: [
                AppTextWidget(
                  style: CustomTextTheme.normalText(
                      color: lightColorPalette.black),
                  text: title,
                  textAlign: TextAlign.center,
                ),
                isShowStar == true
                    ? AppTextWidget(
                        style: CustomTextTheme.normalText(
                          color: lightColorPalette.redDark,
                        ),
                        text: "*",
                        textAlign: TextAlign.center,
                      )
                    : const SizedBox()
              ],
            ),
          ),
        Container(
          width: 1.sw,
          height: 44.h,
          decoration: decoration(isSelected: focusNode?.hasFocus ?? false),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: selectedDate != ""
                    ? AppTextWidget(
                        style: CustomTextTheme.normalText(
                            color: lightColorPalette.black),
                        text: getMMDDYYYYFormetFromString(
                            date: selectedDate ?? ""),
                        textAlign: TextAlign.start,
                      ).paddingOnly(left: 15.w)
                    : AppTextWidget(
                        style: CustomTextTheme.normalText(
                            color: lightColorPalette.black.withOpacity(0.5)),
                        text: title,
                        textAlign: TextAlign.start,
                      ).paddingOnly(left: 15.w),
              ),
              CustomInkwell(
                padding: EdgeInsets.zero,
                onTap: () => showDatePickerDialog(
                    onPicked: onPicked, firstDated: DateTime.now()),
                child: AssetWidget(
                  color: lightColorPalette.grey,
                  asset: Asset(
                    type: AssetType.svg,
                    path: ImageResource.calendar,
                  ),
                ),
              ).paddingOnly(right: 10.w),
            ],
          ),
        ),
        Visibility(
          visible: isError ?? false,
          child: Align(
            alignment: Alignment.topLeft,
            child: AppTextWidget(
              text: errorMsg ?? "",
              style: CustomTextTheme.bottomTabs(
                color: lightColorPalette.redDark,
              ),
            ).paddingOnly(top: 5.h),
          ),
        ), /*paddingOnly(left: 20.w, right: 20.w, top: 4.h),*/
      ],
    ),
  );
}

void showDatePickerDialog(
    {required Function(DateTime date) onPicked, DateTime? firstDated}) {
  var currentDate = DateTime.now();
  var firstDate = firstDated ?? DateTime(currentDate.year - 100);
  var lastDate = DateTime(currentDate.year + 100);

  showDatePicker(
          context: Get.context!,
          initialDate:
              currentDate, //which date will display when user open the picker
          firstDate:
              firstDate, //what will be the previous supported year in picker
          lastDate: lastDate) //what will be the up to supported date in picker
      .then((pickedDate) {
    //then usually do the future job
    if (pickedDate == null) {
      //if user tap cancel then this function will stop
      return;
    }
    onPicked(pickedDate);
  });
}

List<DropdownMenuItem<DropdownModel>> multiSelection(
    {required List<DropdownModel> items,
    required DropdownModel selectedValue,
    required List<DropdownModel> selectedItems}) {
  List<DropdownMenuItem<DropdownModel>>? menuItems = [];

  for (final DropdownModel item in items) {
    final isSelected = selectedItems.contains(item);
    menuItems.addAll(
      [
        DropdownMenuItem<DropdownModel>(
          value: item,
          child: StatefulBuilder(builder: (context, menuSetState) {
            return InkWell(
              onTap: () {
                isSelected
                    ? selectedItems.remove(item)
                    : selectedItems.add(item);

                menuSetState(() {});

                //This rebuilds the StatefulWidget to update the button's text

                //This rebuilds the dropdownMenu Widget to update the check mark
              },
              child: Row(
                children: [
                  AppTextWidget(
                    text: item.name.toString(),
                    style: CustomTextTheme.normalText(
                        color: selectedValue.id == item.id
                            ? lightColorPalette.black
                            : lightColorPalette.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  isSelected
                      ? AssetWidget(
                          color: Colors.green,
                          asset: Asset(
                              type: AssetType.svg,
                              path: ImageResource.selectedCheckbox),
                        )
                      : AssetWidget(
                          asset: Asset(
                              type: AssetType.svg,
                              path: ImageResource.unSelectedCheckbox),
                        )
                ],
              ).paddingSymmetric(horizontal: 15.w),
            );
          }),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<DropdownModel>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return menuItems;
}

List<DropdownMenuItem<DropdownModel>> addDividersAfterItems(
    {required List<DropdownModel> items,
    required DropdownModel selectedValue,
    bool? isDisable}) {
  List<DropdownMenuItem<DropdownModel>>? menuItems = [];
  for (final DropdownModel item in items) {
    menuItems.addAll(
      [
        DropdownMenuItem<DropdownModel>(
          value: item,
          child: Row(
            children: [
              item.icon != ""
                  ? AssetWidget(
                          asset: Asset(type: AssetType.svg, path: item.icon))
                      .paddingOnly(right: 5.w)
                  : const SizedBox(),
              AppTextWidget(
                text: item.name.toString(),
                style: CustomTextTheme.normalText(
                    color: selectedValue.id == item.id
                        ? lightColorPalette.black
                        : isDisable == true
                            ? lightColorPalette.grey
                            : lightColorPalette.black),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              selectedValue.id == item.id
                  ? AssetWidget(
                      color: Colors.green,
                      asset: Asset(
                          type: AssetType.svg, path: ImageResource.checked))
                  : Container(),
            ],
          ).paddingSymmetric(horizontal: 15.w),
        ),
        //If it's last item, we will not add Divider after it.
        if (item != items.last)
          const DropdownMenuItem<DropdownModel>(
            enabled: false,
            child: Divider(),
          ),
      ],
    );
  }
  return menuItems;
}
