import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/common_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_button/custom_icon_button.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';

class ImagePickerUtils {
  static showMyCameraGalleryDialog(Function(XFile, String? type) filePicked) {
    Get.bottomSheet(
        isDismissible: true,
        Wrap(children: [
          Container(
              decoration: BoxDecoration(
                color: lightColorPalette.whiteColorPrimary.shade900,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20.r),
                    topRight: Radius.circular(20.r)),
              ),
              child: Column(children: [
                AssetWidget(
                        asset: Asset(
                            path: ImageResource.bottomIcon,
                            type: AssetType.svg),
                        isCircular: false)
                    .paddingOnly(top: 10.h, bottom: 27.h),
                AppTextWidget(
                    text: AppStrings.uploadPhoto.tr,
                    style: CustomTextTheme.heading2(
                        color: lightColorPalette.black)),
                CommonButton(
                    commonButtonBottonText: AppStrings.takePhoto.tr,
                    onPress: () async {
                      if (await checkForCameraPermissions()) {
                        Get.back();
                        XFile? file = await openCamera();
                        if (file != null) {
                          filePicked(file, "camera");
                        }
                      }
                    }).paddingOnly(bottom: 5.h, top: 22.h),
                CommonButton(
                    bgColor: lightColorPalette.whiteColorPrimary.shade900,
                    border: BorderSide(color: lightColorPalette.black),
                    commonButtonBottonText: AppStrings.uploadFromDevice.tr,
                    style: CustomTextTheme.buttonText(
                      color: lightColorPalette.black,
                    ),
                    onPress: () async {
                      if (await checkForPhotosPermissions()) {
                        Get.back();
                        XFile? file = await openGallery();
                        if (file != null) {
                          filePicked(file, "gallery");
                        }
                      }
                    }),
                CustomInkwell(
                  padding: EdgeInsets.zero,
                  onTap: () {
                    Get.back();
                  },
                  child: AppTextWidget(
                          style: CustomTextTheme.normalTextWithWeight600(
                              color: lightColorPalette.grey),
                          text: AppStrings.close.tr)
                      .paddingOnly(top: 22.5.h, bottom: 41.5.h),
                )
              ]).paddingSymmetric(horizontal: 20.w))
        ]));
  }

  static Future<XFile?> openGallery() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  static Future<XFile?> openCamera() async {
    ImagePicker imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    return pickedFile;
  }
}
