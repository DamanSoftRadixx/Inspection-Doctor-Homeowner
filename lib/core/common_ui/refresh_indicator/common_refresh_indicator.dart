import 'package:flutter/material.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CommonRefreshIndicator extends StatelessWidget {
  final RefreshController controller;
  final Function() onRefresh;
  final Function()? onLoading;
  final Widget child;

  const CommonRefreshIndicator(
      {Key? key,
      required this.controller,
      required this.onRefresh,
      required this.child,
      this.onLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: controller,
      enablePullUp: true,
      onRefresh: () {
        onRefresh();
      },
      physics: const BouncingScrollPhysics(),
      header: WaterDropMaterialHeader(
        backgroundColor: lightColorPalette.primaryBlue,
        color: lightColorPalette.whiteColorPrimary.shade900,
      ),
      onLoading: onLoading,
      child: child,
    );
  }
}
