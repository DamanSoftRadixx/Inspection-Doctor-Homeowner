import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

DateTime? loginClickTime;

bool isRedundentClick(DateTime currentTime) {
  if (loginClickTime == null) {
    loginClickTime = currentTime;
    print("first click");
    return false;
  }
  // print('diff is ${currentTime.difference(loginClickTime!).inSeconds}');
  if (currentTime.difference(loginClickTime!).inMilliseconds < 500) {
    //set this difference time in seconds
    return true;
  }
  loginClickTime = currentTime;
  return false;
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      final String trimedText = newValue.text.trimLeft();

      return TextEditingValue(
        text: trimedText,
        selection: TextSelection(
          baseOffset: trimedText.length,
          extentOffset: trimedText.length,
        ),
      );
    }

    return newValue;
  }
}

void showResponseData(var data, {required String type}) {
  String json = jsonEncode(data);
  log("********************** $type response start **********************");
  log("$type $json");
  log("********************** $type  response end **********************");
}

Widget disableScreen({required bool isDisable}) {
  return isDisable
      ? Container(color: lightColorPalette.transparentColor)
      : const SizedBox();
}

String getAddressFormat(PropertyListData property) {
  return "${property.street}, ${property.city}, ${property.state}, ${property.zipCode}";
}

Future<bool> checkForCameraPermissions() async {
  PermissionStatus permissionGranted = await Permission.camera.status;
  print("_permissionGranted : $permissionGranted ");

  if (permissionGranted == PermissionStatus.permanentlyDenied) {
    await goToSettingDialog();

    permissionGranted = await Permission.camera.status;
    print("After dialog _permissionGranted : $permissionGranted ");

    if (permissionGranted == PermissionStatus.granted) {
      return true;
    }
    return false;
  } else if (permissionGranted == PermissionStatus.granted) {
    return true;
  } else if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await Permission.camera.request();
    if (permissionGranted == PermissionStatus.granted) {
      return true;
    } else if (permissionGranted == PermissionStatus.permanentlyDenied) {
      await goToSettingDialog();

      permissionGranted = await Permission.camera.status;
      print("After dialog _permissionGranted : $permissionGranted ");

      if (permissionGranted == PermissionStatus.granted) {
        return true;
      }

      return false;
    }
  }

  return false;
}

Future<bool> checkForPhotosPermissions() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    int sdkInt = androidInfo.version.sdkInt;

    if (sdkInt < 33) {
      PermissionStatus permissionGranted = Platform.isIOS
          ? await Permission.photos.status
          : await Permission.storage.status;

      print("_permissionGranted : $permissionGranted ");

      Permission.manageExternalStorage.request();

      if (permissionGranted == PermissionStatus.permanentlyDenied) {
        await goToSettingDialog();

        permissionGranted = Platform.isIOS
            ? await Permission.photos.status
            : await Permission.storage.status;
        print("After dialog _permissionGranted : $permissionGranted ");

        if (permissionGranted == PermissionStatus.granted ||
            permissionGranted == PermissionStatus.limited) {
          return true;
        }

        return false;
      } else if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.limited) {
        return true;
      } else if (permissionGranted == PermissionStatus.denied) {
        permissionGranted = Platform.isIOS
            ? await Permission.photos.request()
            : await Permission.storage.request();
        if (permissionGranted == PermissionStatus.granted ||
            permissionGranted == PermissionStatus.limited) {
          return true;
        } else if (permissionGranted == PermissionStatus.permanentlyDenied) {
          await goToSettingDialog();

          permissionGranted = Platform.isIOS
              ? await Permission.photos.request()
              : await Permission.storage.request();
          print("After dialog _permissionGranted : $permissionGranted ");

          if (permissionGranted == PermissionStatus.granted ||
              permissionGranted == PermissionStatus.limited) {
            return true;
          }

          return false;
        }
      }
    } else {
      return true;
    }
  } else {
    PermissionStatus permissionGranted = Platform.isIOS
        ? await Permission.photos.status
        : await Permission.storage.status;

    print("_permissionGranted : $permissionGranted ");

    Permission.manageExternalStorage.request();

    if (permissionGranted == PermissionStatus.permanentlyDenied) {
      await goToSettingDialog();

      permissionGranted = Platform.isIOS
          ? await Permission.photos.status
          : await Permission.storage.status;
      print("After dialog _permissionGranted : $permissionGranted ");

      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.limited) {
        return true;
      }

      return false;
    } else if (permissionGranted == PermissionStatus.granted ||
        permissionGranted == PermissionStatus.limited) {
      return true;
    } else if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = Platform.isIOS
          ? await Permission.photos.request()
          : await Permission.storage.request();
      if (permissionGranted == PermissionStatus.granted ||
          permissionGranted == PermissionStatus.limited) {
        return true;
      } else if (permissionGranted == PermissionStatus.permanentlyDenied) {
        await goToSettingDialog();

        permissionGranted = Platform.isIOS
            ? await Permission.photos.request()
            : await Permission.storage.request();
        print("After dialog _permissionGranted : $permissionGranted ");

        if (permissionGranted == PermissionStatus.granted ||
            permissionGranted == PermissionStatus.limited) {
          return true;
        }

        return false;
      }
    }
  }

  return false;
}

goToSettingDialog() async {
  return await showCommonAlertWithTwoActionsDialog(
      title: AppStrings.permissionDenied,
      leftButtonTitle: AppStrings.cancel,
      rightButtonTitle: AppStrings.openSettings,
      subHeader: AppStrings.accessWasPreviouslyDenied,
      noPressed: () {
        Get.back();
      },
      yesPressed: () {
        openAppSettings();
        Get.back();
      });
}

Widget somethingWentWrongWidget({required String text, required String image}) {
  return SizedBox(
    width: Get.width,
    height: Get.height / 1.5,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        image != ""
            ? Image.asset(
                image,
                height: 200.h,
              ).paddingOnly(bottom: 40.h)
            : const SizedBox(),
        AppTextWidget(
          style: CustomTextTheme.categoryText(
            color: lightColorPalette.redDark,
          ),
          text: text,
        )
      ],
    ),
  );
}

launchUrlOnBrowser({required String url}) async {
  try {
    if (await canLaunchUrl(
      Uri.parse(url),
    )) {
      print('launching Url');
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch url';
    }
  } catch (e) {
    print("Exception Error: $e");
  }
}
