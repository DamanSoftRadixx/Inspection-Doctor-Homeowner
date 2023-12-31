import 'dart:developer';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';

class NetworkCheck {
  Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  noInternetConnectionDialog() {
    // showCommonAlertSingleButtonDialog(
    //     title: AppStrings.strNoInternetConnection.tr,
    //     subHeader: AppStrings.strPleaseCheckYourInternetConnectivity.tr,
    //     okPressed: () {
    //       Get.back();
    //     },
    //     buttonTitle: AppStrings.ok);
    showNoInternetDialog();
  }

  Future<bool> hasNetwork() async {
    try {
      List<InternetAddress> result = await InternetAddress.lookup('google.com');
      log("Internet connection Status : $result");

      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (e) {
      log("Internet connection Error: $e");
      return false;
    }
  }
}
