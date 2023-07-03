// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// 
// import 'package:inspection_doctor_homeowner/core/common_ui/common_image_widget.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_loader.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/custom_icon_button.dart';
// import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
// import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
// import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// import '../controller/webview_screen_controller.dart';

// class WebViewScreen extends GetView<WebViewScreenController> {
//   const WebViewScreen({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Obx(
//             () => Column(
//               children: [
//                 appBarWidget(),
//                 /*CommonAppBar(
//                     title: controller.appBarTitle.value,
//                     onBackPress: () {
//                       Get.back();
//                     }),*/
//                 Expanded(
//                   child: webViewWidget(),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   webViewWidget() {
//     return Stack(
//       children: [
//         WebViewWidget(
//           // initialUrl: controller.url.value,
//           // javascriptMode: JavascriptMode.unrestricted,
//           // onWebViewCreated: (WebViewController webViewController) {
//           //   controller.webViewController = webViewController;
//           //   print("onWebViewCreated");
//           // },
//           // onPageStarted: (data) {
//           //   print("onPageStarted");
//           // },
//           // onProgress: (data) {
//           //   print("onProgress");
//           // },
//           // onPageFinished: (data) {
//           //   print("onPageFinished");
//           //   controller.showLoader.value = false;
//           //   controller.showLoader.refresh();
//           // },
//           controller: controller.webViewController,
//         ),
//         // controller.showLoader.value
//         //     ? Center(
//         //         child: CircularProgressIndicator(
//         //             color: lightColorPalette.primarySwatch.shade900))
//         //     : Container()
//         controller.showLoader.value ? const CommonLoader() : Container()
//       ],
//     );
//   }

//   appBarWidget() {
//     return Container(
//       width: 1.sw,
//       color: lightColorPalette.primarySwatch.shade900,
//       child: Column(
//         children: [
//           SizedBox(
//             height: isIos ? 42.h : 46.h,
//           ),
//           // Row(
//           //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //   crossAxisAlignment: CrossAxisAlignment.center,
//           //   children: [
//           //     Align(
//           //         alignment: Alignment.center,
//           //         child: AssetWidget(
//           //           asset:
//           //               Asset(type: AssetType.svg, path: ImageResource.appLogo),
//           //         )),
//           //     Align(
//           //       alignment: Alignment.topRight,
//           //       child: CustomIconButton(
//           //         icon: AssetWidget(
//           //           asset: Asset(
//           //             path: ImageResource.cross,
//           //             type: AssetType.svg,
//           //           ),
//           //           color: lightColorPalette.additionalSwatch1.shade400,
//           //         ),
//           //         padding: EdgeInsets.zero,
//           //         onPressed: () {
//           //           Get.back();
//           //         },
//           //       ),
//           //     ).paddingSymmetric(horizontal: 0.w)
//           //   ],
//           // ).paddingOnly(
//           //   left: 15.w,
//           //   right: 15.w,
//           // ),
//         ],
//       ),
//     );
//   }
// }
