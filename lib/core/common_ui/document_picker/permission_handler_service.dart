import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerPermissionService {
  Future<int> handleCameraPermission() async {
    PermissionStatus cameraPermissionStatus = await Permission.camera.request();
    if (cameraPermissionStatus == PermissionStatus.granted) {
      return 0;
    } else if (cameraPermissionStatus == PermissionStatus.permanentlyDenied) {
      return 1;
    } else {
      return 2;
    }
  }

  Future<int> handlePhotosPermission() async {
    PermissionStatus photosPermissionStatus = isIos
        ? await Permission.photos.request()
        : await Permission.storage.request();

    if (photosPermissionStatus == PermissionStatus.granted) {
      return 0;
    } else if (photosPermissionStatus == PermissionStatus.permanentlyDenied) {
      return 1;
    } else {
      return 2;
    }
  }

  static showCameraPermissionDialogue() async {
    OkCancelResult result = await showOkCancelAlertDialog(
      context: Get.context!,
      title: "Permission Denied",
      message:
          "Access was previously denied, Please grant Camera access from the Settings.",
      okLabel: "Go to Settings",
      cancelLabel: "Cancel",
      style: AdaptiveStyle.iOS,
      isDestructiveAction: false,
    );

    if (result == OkCancelResult.ok) {
      openAppSettings();
    }
  }

  static showGalleryPermissionDialogue() async {
    OkCancelResult result = await showOkCancelAlertDialog(
      context: Get.context!,
      title: "Permission Denied",
      message:
          "Access was previously denied, Please grant access from the Settings.",
      okLabel: "Go to Settings",
      cancelLabel: "Cancel",
      style: AdaptiveStyle.iOS,
      isDestructiveAction: false,
    );

    if (result == OkCancelResult.ok) {
      openAppSettings();
    }
  }
}
