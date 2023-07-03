import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
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
      TextInputAction? textInputAction}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      if (title != null && title != "")
        AppTextWidget(
          style: CustomTextTheme.normalText(
            color: lightColorPalette.primaryDarkblue,
          ),
          text: title ?? "",
          textAlign: TextAlign.center,
        ).paddingOnly(bottom: 3.0.h),
      GestureDetector(
        onTap: () {
          focusNode.requestFocus();
        },
        child: Container(
          width: 1.sw,
          height: 44.h,
          padding: EdgeInsets.only(top: 0.h),
          decoration: decoration(isSelected: focusNode.hasFocus),
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
              focusNode: focusNode,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.only(left: 15.0, right: 15.w),
                border: InputBorder.none,
                hintText: hint ?? "",
                hintStyle: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryDarkblue.withOpacity(0.5)),
              ),
              style: CustomTextTheme.normalText(
                  color: lightColorPalette.primaryDarkblue),
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
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
          ),
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
      TextInputAction? textInputAction}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != "")
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
            text: title ?? "",
            textAlign: TextAlign.center,
            // TextStyle(fontSize: 16.sp),
          ),
        ),
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
                  focusNode: focusNode,
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
                          type: AssetType.svg,
                          path: ImageResource.hideEye),
                    )
                        : AssetWidget(
                      asset: Asset(
                          type: AssetType.svg,
                          path: ImageResource.openEye),
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
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget commonPhoneText({
  required final TextEditingController controller,
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
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (title != "")
        Padding(
          padding: EdgeInsets.only(bottom: 3.h),
          child: AppTextWidget(
            style: CustomTextTheme.normalText(
                color: lightColorPalette.primaryDarkblue),
            text: title,
            textAlign: TextAlign.center,
          ),
        ),
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
                  countryListTheme: const CountryListThemeData(),
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
                                color: lightColorPalette.primaryDarkblue))
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
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,

                  isCollapsed: true,
                  contentPadding: EdgeInsets.only(left: 10.0, right: 10.w),
                  hintStyle: CustomTextTheme.normalText(
                      color:
                          lightColorPalette.primaryDarkblue.withOpacity(0.5)),

                  // contentPadding: EdgeInsets.only(left:10.w,right: 10.w,bottom: 7.5.h,top: 0.h),
                ),
                style: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryDarkblue),
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
            style: CustomTextTheme.normalText(
              color: lightColorPalette.primaryDarkblue,
            ),
          ),
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
}){
  return GestureDetector(
    onTap: (){
      focusNode.requestFocus();
    },
    child: Container(
      width: 1.sw,
      height: 32.h,
      decoration: decorationSearchTextField(isSelected: focusNode.hasFocus),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 12.w,),
          AssetWidget(
            asset: Asset(type: AssetType.svg, path: ImageResource.searchIcon),
          ),
          Expanded(
            child: TextFormField(
              controller: controller,
              maxLines: 1,
              minLines: 1,
              onChanged: onChanged,
              expands: false,
              focusNode: focusNode,
              decoration: InputDecoration(
                isCollapsed: true,
                contentPadding: EdgeInsets.only(left: 8.0, right: 15.w),
                border: InputBorder.none,
                hintText: searchHint,
                hintStyle: CustomTextTheme.normalText(
                    color: lightColorPalette.primaryDarkblue.withOpacity(0.5)),
              ),
              style: CustomTextTheme.normalText(
                  color: lightColorPalette.primaryDarkblue),
            ),
          )

        ],
      ),
    ),
  );
}

