import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

import '../../main.dart';
import '../constants/common_strings.dart';
import '../theme/app_color_palette.dart';
import '../utils/image_resources.dart';
import 'app_text_widget.dart';
import 'asset.dart';
import 'common_image_widget.dart';
import 'custom_icon_button.dart';

void main() => runApp(const MyApp());

class MyView extends StatelessWidget {
  const MyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter AlertDialog'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Alert Dialog'),
          onPressed: () {
            showCommonAlertWithTwoActionsDialo(
                title: 'Alert',
                subHeader: 'Alert the dialogue is open',
                okPressed: () {
                  Get.back();
                });
            // showCommonAlertSingleButtonDialog(title: 'Alert', subHeader: 'Alert the Dialogue box is ');

            //showGeneralDialogBox(title: 'Alert',message: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',onCancel: () {

            // },onConfirm: () {
            //
            // },
            // );
          },
        ),
      ),
    );
  }
}

Future<void> showCommonAlertWithTwoActionsDialog(
    {required String title,
    required String subHeader,
    required Function() okPressed}) async {
  // Get.back(closeOverlays: true);
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    // Get.dialog(cupertino_dialog.CupertinoAlertDialog(
    //   title: Center(
    //     child: AppTextWidget(
    //       text: title,
    //       style: Theme
    //           .of(Get.context!)
    //           .textTheme
    //           .bodyLarge!
    //           .copyWith(
    //           fontSize: 16.sp,
    //           color: lightColorPalette.additionalSwatch1.shade900,
    //           fontWeight: FontWeight.w600,
    //           fontFamily: CommonStrings.vitnamPro),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //
    //   content: AppTextWidget(
    //     text: subHeader,
    //     style: Theme
    //         .of(Get.context!)
    //         .textTheme
    //         .bodyMedium!
    //         .copyWith(
    //         fontSize: 13.sp,
    //         color: lightColorPalette.additionalSwatch1.shade900,
    //         fontWeight: FontWeight.w300,
    //         fontFamily: CommonStrings.vitnamPro),
    //     textAlign: TextAlign.center,
    //   ),
    //   actions: <CupertinoDialogAction>[
    //     CupertinoDialogAction(
    //       onPressed: () {
    //         okPressed();
    //       },
    //       child:
    //       AppTextWidget(
    //         text: AppStrings.strOk.tr,
    //         style: Theme
    //             .of(Get.context!)
    //             .textTheme
    //             .bodyLarge!
    //             .copyWith(
    //             fontSize: 17.sp,
    //             color: lightColorPalette.additionalSwatch1.shade900,
    //             fontWeight: FontWeight.w400,
    //             fontFamily: CommonStrings.vitnamPro),
    //         textAlign: TextAlign.start,
    //       ),
    //     ),
    //     CupertinoDialogAction(
    //       onPressed: () {
    //         Get.back();
    //       },
    //       child:
    //       AppTextWidget(
    //         text: AppStrings.createGuidedCancelButton.tr,
    //         style: Theme
    //             .of(Get.context!)
    //             .textTheme
    //             .bodyLarge!
    //             .copyWith(
    //             fontSize: 17.sp,
    //             color: lightColorPalette.additionalSwatch1.shade900,
    //             fontWeight: FontWeight.w400,
    //             fontFamily: CommonStrings.vitnamPro),
    //         textAlign: TextAlign.start,
    //       ),
    //     )
    //   ],
    // ),
    //
    //
    //   //      ),
    //   // ],
    //   //  )
    // );
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r)),
        ),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextWidget(
                text: title,
                style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontSize: 18.sp,
                    color: lightColorPalette.additionalSwatch1.shade900,
                    fontWeight: FontWeight.w600,
                    fontFamily: CommonStrings.vitnamPro),
                textAlign: TextAlign.center,
              ),
              CustomIconButton(
                icon: AssetWidget(
                  color: lightColorPalette.additionalSwatch1.shade900,
                  asset: Asset(path: ImageResource.cross, type: AssetType.svg),
                ),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
        content: AppTextWidget(
            text: subHeader,
            style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                fontSize: 13.sp,
                color: lightColorPalette.additionalSwatch1.shade900,
                fontWeight: FontWeight.w300,
                fontFamily: CommonStrings.vitnamPro)),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: lightColorPalette.primarySwatch.shade900),
                  borderRadius: BorderRadius.circular(8.r)),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
              backgroundColor: lightColorPalette.primarySwatch.shade900,
            ),
            child: Text(
              AppStrings.ok.tr,
              style: TextStyle(
                fontSize: 16.sp,
                color: lightColorPalette.additionalSwatch1.shade900,
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              Get.back();
            },
          ).paddingOnly(right: 10.w),
        ],
      ),
      barrierDismissible: false,
    );
  }
}

Future<void> showCommonAlertWithTwoActionsDialo(
    {required String title,
    required String subHeader,
    required Function() okPressed}) async {
  // Get.back(closeOverlays: true);
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    // Get.dialog(cupertino_dialog.CupertinoAlertDialog(
    //   title: Center(
    //     child: AppTextWidget(
    //       text: title,
    //       style: Theme
    //           .of(Get.context!)
    //           .textTheme
    //           .bodyLarge!
    //           .copyWith(
    //           fontSize: 16.sp,
    //           color: lightColorPalette.additionalSwatch1.shade900,
    //           fontWeight: FontWeight.w600,
    //           fontFamily: CommonStrings.vitnamPro),
    //       textAlign: TextAlign.center,
    //     ),
    //   ),
    //
    //   content: AppTextWidget(
    //     text: subHeader,
    //     style: Theme
    //         .of(Get.context!)
    //         .textTheme
    //         .bodyMedium!
    //         .copyWith(
    //         fontSize: 13.sp,
    //         color: lightColorPalette.additionalSwatch1.shade900,
    //         fontWeight: FontWeight.w300,
    //         fontFamily: CommonStrings.vitnamPro),
    //     textAlign: TextAlign.center,
    //   ),
    //   actions: <CupertinoDialogAction>[
    //     CupertinoDialogAction(
    //       onPressed: () {
    //         okPressed();
    //       },
    //       child:
    //       AppTextWidget(
    //         text: AppStrings.strOk.tr,
    //         style: Theme
    //             .of(Get.context!)
    //             .textTheme
    //             .bodyLarge!
    //             .copyWith(
    //             fontSize: 17.sp,
    //             color: lightColorPalette.additionalSwatch1.shade900,
    //             fontWeight: FontWeight.w400,
    //             fontFamily: CommonStrings.vitnamPro),
    //         textAlign: TextAlign.start,
    //       ),
    //     ),
    //     CupertinoDialogAction(
    //       onPressed: () {
    //         Get.back();
    //       },
    //       child:
    //       AppTextWidget(
    //         text: AppStrings.createGuidedCancelButton.tr,
    //         style: Theme
    //             .of(Get.context!)
    //             .textTheme
    //             .bodyLarge!
    //             .copyWith(
    //             fontSize: 17.sp,
    //             color: lightColorPalette.additionalSwatch1.shade900,
    //             fontWeight: FontWeight.w400,
    //             fontFamily: CommonStrings.vitnamPro),
    //         textAlign: TextAlign.start,
    //       ),
    //     )
    //   ],
    // ),
    //
    //
    //   //      ),
    //   // ],
    //   //  )
    // );
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r)),
        ),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextWidget(
                text: title,
                style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontSize: 18.sp,
                    color: lightColorPalette.additionalSwatch1.shade900,
                    fontWeight: FontWeight.w600,
                    fontFamily: CommonStrings.vitnamPro),
                textAlign: TextAlign.center,
              ),
              CustomIconButton(
                icon: AssetWidget(
                  color: lightColorPalette.additionalSwatch1.shade900,
                  asset: Asset(path: ImageResource.cross, type: AssetType.svg),
                ),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
        content: AppTextWidget(
            text: subHeader,
            style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                fontSize: 13.sp,
                color: lightColorPalette.additionalSwatch1.shade900,
                fontWeight: FontWeight.w300,
                fontFamily: CommonStrings.vitnamPro)),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r)),
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 25.w),
              backgroundColor: lightColorPalette.primarySwatch.shade900,
            ),
            child: Text(
              "the cancel button",
              style: TextStyle(color: Colors.white, fontSize: 14.sp),
            ),
            onPressed: () {
              Get.back();
            },
          ).paddingOnly(right: 10.w),
        ],
      ),
      barrierDismissible: false,
    );
  }
}

Future<void> showCommonAlertSingleButtonDialog(
    {required String title,
    required String subHeader,
    Function()? okPressed}) async {
  // Get.back(closeOverlays: true);
  if (Get.isDialogOpen == null || Get.isDialogOpen == false) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: lightColorPalette.primarySwatch.shade900),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24.r),
              topRight: Radius.circular(24.r)),
        ),
        title: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppTextWidget(
                text: title,
                style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
                    fontSize: 18.sp,
                    color: lightColorPalette.additionalSwatch1.shade900,
                    fontWeight: FontWeight.w600,
                    fontFamily: CommonStrings.vitnamPro),
                textAlign: TextAlign.center,
              ),
              CustomIconButton(
                icon: AssetWidget(
                  color: lightColorPalette.additionalSwatch1.shade900,
                  asset: Asset(path: ImageResource.cross, type: AssetType.svg),
                ),
                onPressed: () {
                  Get.back();
                },
              )
            ],
          ),
        ),
        content: AppTextWidget(
            text: subHeader,
            style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
                fontSize: 13.sp,
                color: lightColorPalette.additionalSwatch1.shade900,
                fontWeight: FontWeight.w300,
                fontFamily: CommonStrings.vitnamPro)),
      ),
      barrierDismissible: false,
    );

    void showGeneralDialogBox(
        {String? title,
        String? message,
        VoidCallback? onConfirm,
        VoidCallback? onCancel}) {
      Get.dialog(
        AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24), topRight: Radius.circular(24)),
          ),
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title!),
                CustomIconButton(
                  icon: AssetWidget(
                    asset:
                        Asset(path: ImageResource.cross, type: AssetType.svg),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                )
              ],
            ),
          ),
          content: Text(message!),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                backgroundColor: lightColorPalette.primarySwatch.shade900,
              ),
              child: const Text(
                "Yes",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              onPressed: () {
                Get.back();
              },
            ).paddingOnly(right: 10.w),
          ],
        ),
        barrierDismissible: false,
      );
    }

// showGetDialogDynamicHeight({required String title, required String message,
//   required Function() onTapRightButton,bool isShowCancelButton = true,Function()? onTapLeftButton}) async{
//   FocusManager.instance.primaryFocus?.unfocus();
//   await Get.closeCurrentSnackbar();
//   var isOpenDialog = Get.isDialogOpen ?? false;
//   if(!isOpenDialog){
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(4*5)),
//         ),
//         content: Wrap(
//             children: <Widget>[
//               Center(
//                 child: Text('title'),
//               ),
//               SizedBox(
//                 height: 4*10,
//               ),
//               Center(
//                 child: Text('message'),
//               ),
//               Container(
//                 height:4*7,
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: 4*7, right: 4*5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if(isShowCancelButton) Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           if(onTapLeftButton != null) onTapLeftButton!();
//                           Get.back();
//                         },
//                         child: Container(
//                           height: 4*10,
//                           padding: EdgeInsets.symmetric(horizontal: 3*4),
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.black),
//                               borderRadius: BorderRadius.circular(9*2)),
//                           child: Center(
//                             child: Text('cancelConst'),
//                           ),
//                         ),
//                       ),
//                     ),
//                     if(isShowCancelButton)  SizedBox(width: 5*4,),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           onTapRightButton();
//                           Get.back();
//                         },
//                         child: Container(
//                           height: 3*10,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               border: Border.all(color: Colors.black),
//                               borderRadius: BorderRadius.circular(4*2)),
//                           child: Center(
//                             child: Text('rightButtonTitle',
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height:4*2,
//               ),
//             ]),
//       ),
//     );
//   }
// }

// showGetDialogDynamicHeight({required String title, required String message,
//   required Function() onTapRightButton,,bool isShowCancelButton = true,Function()? onTapLeftButton}) async{
//   FocusManager.instance.primaryFocus?.unfocus();
//   await Get.closeCurrentSnackbar();
//   var isOpenDialog = Get.isDialogOpen ?? false;
//   if(!isOpenDialog){
//     Get.dialog(
//       AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(SizeConfig.blockSizeHorizontal*5)),
//         ),
//         content: Wrap(
//             children: <Widget>[
//               Center(
//                 child: text(title,
//                     size: SizeConfig.blockSizeHorizontal*5,
//                     color: colorNavyBlue,
//                     fontWeight: FontWeight.w700),
//               ),
//               SizedBox(
//                 height: SizeConfig.blockSizeHorizontal*10,
//               ),
//               Center(
//                 child: text(message,
//                     size: SizeConfig.blockSizeHorizontal*4,
//                     color: colorNavyBlue,
//                     lines: 10,
//                     fontWeight: FontWeight.w500),
//               ),
//               Container(
//                 height: SizeConfig.blockSizeHorizontal*7,
//               ),
//               Container(
//                 margin: EdgeInsets.only(left: SizeConfig.blockSizeHorizontal*7, right: SizeConfig.blockSizeHorizontal*5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     if(isShowCancelButton) Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           FocusManager.instance.primaryFocus?.unfocus();
//                           if(onTapLeftButton != null) onTapLeftButton!();
//                           Get.back();
//                         },
//                         child: Container(
//                           height: SizeConfig.blockSizeHorizontal*10,
//                           padding: EdgeInsets.symmetric(horizontal: SizeConfig.blockSizeHorizontal*4),
//                           decoration: BoxDecoration(
//                               color: colorWhite,
//                               border: Border.all(color: colorPrimary),
//                               borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal*2)),
//                           child: Center(
//                             child: text(cancelConst,
//                                 color: colorPrimary,
//                                 size: SizeConfig.blockSizeHorizontal*3.8,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                     ),
//                     if(isShowCancelButton)  SizedBox(width: SizeConfig.blockSizeHorizontal*4,),
//                     Expanded(
//                       child: GestureDetector(
//                         onTap: () {
//                           onTapRightButton();
//                           Get.back();
//                         },
//                         child: Container(
//                           height: SizeConfig.blockSizeHorizontal*10,
//                           decoration: BoxDecoration(
//                               color: colorPrimary,
//                               border: Border.all(color: colorPrimary),
//                               borderRadius: BorderRadius.circular(SizeConfig.blockSizeHorizontal*2)),
//                           child: Center(
//                             child: text(rightButtonTitle,
//                                 color: colorWhite,
//                                 size: SizeConfig.blockSizeHorizontal*3.8,
//                                 fontWeight: FontWeight.w500),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: SizeConfig.blockSizeHorizontal*2,
//               ),
//             ]),
//       ),
//     );
//   }
// }

// void showDialog()
// {
//   Get.dialog(
//       Column(
//         children: [
//           Row(
//             children: [
//               AppTextWidget(
//                   text: "Alert",
//                   style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: CommonStrings.vitnamPro),
//                   textAlign: TextAlign.start),
//               CustomIconButton(
//                 icon: Icon(
//                   Icons.cancel,
//                   color: lightColorPalette.additionalSwatch1.shade900,
//                 ),
//                 onPressed: () {
//                   Get.back();
//                 },
//               )
//             ],
//           ),
//           const Divider(
//             color: Colors.black,
//             thickness: 1,
//           )
//         ],
//       ).paddingOnly(bottom: 10.h)
//
//   );
// }

// void _showDialog(BuildContext context) {
//   Get.dialog(
//       AlertDialog(
//     shape: RoundedRectangleBorder(borderRadius:BorderRadius.all(Radius.circular(8.r))),
//     title: Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Expanded(
//               flex: 10,
//               child: AppTextWidget(
//                   text: "Pop Up Message",
//                   style: Theme.of(Get.context!).textTheme.bodyLarge!.copyWith(
//                       fontSize: 16.sp,
//                       fontWeight: FontWeight.w500,
//                       fontFamily: CommonStrings.vitnamPro),
//                   textAlign: TextAlign.start),
//             ),
//             CustomIconButton(
//               icon: Icon(
//                 Icons.cancel,
//                 color: lightColorPalette.additionalSwatch1.shade900,
//               ),
//               onPressed: () {
//                 Get.back();
//               },
//             )
//           ],
//         ),
//         const Divider(
//           color: Colors.black,
//           thickness: 1,
//         )
//       ],
//     ),
//
//     content: AppTextWidget(
//         text: "You are awesome!",
//         style: Theme.of(Get.context!).textTheme.bodyMedium!.copyWith(
//             fontSize: 13.sp,
//             fontWeight: FontWeight.w400,
//             fontFamily: CommonStrings.vitnamPro),
//         textAlign: TextAlign.center),
//     actions: [
//       Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           TextButton(
//             style: TextButton.styleFrom(
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.r),
//                 ),
//                 backgroundColor: lightColorPalette.primarySwatch.shade900),
//             child: AppTextWidget(
//                 text: "Ok",
//                 style: lightTextTheme.bodyText1?.copyWith(
//                     color: lightColorPalette.whiteColorPrimary.shade900,
//                     fontFamily: CommonStrings.vitnamPro)),
//             onPressed: () {
//               Get.back();
//             },
//           ),
//         ],
//       ).paddingOnly(right: 10.w),
//     ],
//   )
//   );
//
// }

// customDialogBox(BuildContext context) {
//   return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             backgroundColor: Colors.red,
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(32.0))),
//             contentPadding: EdgeInsets.only(top: 10.0),
//             content: Stack(
//               children: <Widget>[
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     mainAxisSize: MainAxisSize.min,
//                     children: <Widget>[
//                       SizedBox(
//                         height: 20.0,
//                       ),
//                       Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(10.0),
//                             child: new Text("Sorry please try \n again tomorrow", style:TextStyle(fontSize: 30.0,color: Colors.white)),
//                           )//
//                       ),
//
//                       SizedBox(
//                         height: 20.0,
//                         width: 5.0,
//                       ),
//                       Divider(
//                         color: Colors.grey,
//                         height: 4.0,
//                       ),
//
//                       InkWell(
//                         child: Container(
//                           padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
//                           decoration: BoxDecoration(
//                             color:Colors.white,
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(32.0),
//                                 bottomRight: Radius.circular(32.0)),
//                           ),
//                           child:  Text(
//                             "OK",
//                             style: TextStyle(color: Colors.blue,fontSize: 25.0),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                         onTap:(){
//                           Navigator.pop(context);
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 Positioned(
//                   top: 0.0,
//                   right: 0.0,
//                   child: FloatingActionButton(
//                     child: Image.asset("assets/red_cross.png"),
//                     onPressed: (){
//                       Navigator.pop(context);
//                     },
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80)),
//                     backgroundColor: Colors.white,
//                     mini: true,
//                     elevation: 5.0,
//                   ),
//                 ),
//               ],
//             )
//         );
//       });
  }
}
