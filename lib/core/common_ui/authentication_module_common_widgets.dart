// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/asset.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_image_widget.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/custom_icon_button.dart';
// import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
// import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

// appBarWidget({Function()? onCancel, bool isShowCancel = false}) {
//   return Column(
//     children: [
//       SizedBox(
//         height: 50.h,
//       ),
//       if (isShowCancel)
//         Align(
//           alignment: Alignment.topRight,
//           child: CustomIconButton(
//             icon: AssetWidget(
//               asset: Asset(
//                 path: ImageResource.cross,
//                 type: AssetType.svg,
//               ),
//               color: lightColorPalette.additionalSwatch1.shade400,
//             ),
//             padding: EdgeInsets.zero,
//             onPressed: () {
//               if (onCancel != null) {
//                 onCancel();
//               } else {
//                 Get.back();
//               }
//             },
//           ),
//         ).paddingSymmetric(horizontal: 18.w),
//       if (!isShowCancel)
//         SizedBox(
//           height: 10.h,
//         ),
//       Align(
//         alignment: Alignment.topLeft,
//         child: CustomIconButton(
//           padding: EdgeInsets.zero,
//           icon: AssetWidget(
//             width: 250.w,
//             asset: Asset(
//               path: ImageResource.appLogo,
//               type: AssetType.svg,
//             ),
//             color: lightColorPalette.whiteColorPrimary.shade900,
//           ),
//           onPressed: () {},
//         ),
//       ).paddingSymmetric(horizontal: 15.w),
//       SizedBox(height: 15.h),
//     ],
//   );
// }
