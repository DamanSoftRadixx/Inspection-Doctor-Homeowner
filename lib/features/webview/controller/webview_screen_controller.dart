import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/string_extensions.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../core/network_utility/controller/network_controller.dart';

class WebViewScreenController extends GetxController {
  var appBarTitle = "".obs;
  var url = "".obs;
  var networkController = Get.put(NetworkController());
  RxBool showLoader = false.obs;

  @override
  void onInit() {
    getArguments();
    showLoader.value = true;
    showLoader.refresh();
    super.onInit();
  }

  setLoader({required bool isShow}) {
    showLoader.value = isShow;
    showLoader.refresh();
  }

  getArguments() {
    var arguments = Get.arguments;
    if (arguments != null) {
      appBarTitle.value = arguments[GetArgumentConstants.title.tr]
              .toString()
              .toStringConversion() ??
          "";
      url.value = arguments[GetArgumentConstants.url.tr]
              .toString()
              .toStringConversion() ??
          "";
    }
  }

  WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          // Update loading bar.
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
}
