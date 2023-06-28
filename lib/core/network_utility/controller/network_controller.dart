// import 'dart:async';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
// import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

// class NetworkController extends GetxController {
//   var connectionStatus = 0.obs;
//   final _connectivity = Connectivity();
//   StreamSubscription<ConnectivityResult>? _connectivitySubscription;

//   @override
//   void onInit() {
//     intConnectivity();
//     _connectivitySubscription =
//         _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//     super.onInit();
//   }

//   intConnectivity() async {
//     ConnectivityResult? connectivityResult;
//     try {
//       connectivityResult = await _connectivity.checkConnectivity();
//       _updateConnectionStatus(connectivityResult);
//     } on PlatformException catch (e) {
//       print(e.toString());
//     }
//   }

//   _updateConnectionStatus(ConnectivityResult result) async {
//     print("connectivityResult : $result");

//     /* if(await NetworkCheck().hasNetwork()){
//       connectionStatus.value = 1;
//     }else{
//       connectionStatus.value = 0;
//     }
//     print("connectionStatus.value : ${connectionStatus.value}");*/
//     switch (result) {
//       case ConnectivityResult.wifi:
//         connectionStatus.value = 1;
//         break;
//       case ConnectivityResult.mobile:
//         connectionStatus.value = 1;
//         break;
//       case ConnectivityResult.none:
//         connectionStatus.value = 0;
//         break;
//       default:
//         Get.snackbar(AppStrings.strNoInternetConnection,
//             AppStrings.strPleaseCheckYourInternetConnectivity);
//         break;
//     }
//     connectionStatus.refresh();
//   }

//   noInternetConnectionDialog() {
//     showCommonAlertSingleButtonDialog(
//       title: AppStrings.strNoInternetConnection,
//       subHeader: AppStrings.strPleaseCheckYourInternetConnectivity,
//     );
//   }

//   @override
//   void onClose() {
//     _connectivitySubscription?.cancel();
//     super.onClose();
//   }
// }
