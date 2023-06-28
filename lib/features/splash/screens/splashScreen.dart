import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_image_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

import '../../../core/common_ui/asset.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    navigateToNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightColorPalette.primarySwatch.shade900,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
                alignment: Alignment.center,
                child: AssetWidget(
                  asset:
                      Asset(type: AssetType.svg, path: ImageResource.appLogo),
                  height: 90.h,
                  width: 300.w,
                ))
          ],
        ));
  }

  Future navigateToNext() async {
    Future.delayed(const Duration(seconds: 2), () {
      var token = Prefs.read(Prefs.TOKEN);
      token == null
          ? Get.offNamed(Routes.introScreen)
          : Get.offNamed(Routes.dashboard);
    });
  }
}
