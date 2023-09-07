import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/app_bar/common_appbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/asset_widget/common_image_widget.dart';

class ExpandedImageView extends StatelessWidget {
  const ExpandedImageView({
    super.key,
    required this.path,
  });

  final String path;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBarWithElevation(
            title: "",
            onPressBackButton: () {
              Get.back();
            }),
        body: AssetWidget(
          asset: Asset(type: AssetType.network, path: path),
        ));
  }
}
