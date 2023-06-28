

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomIconButton extends StatelessWidget {
  final Widget icon;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  // final VoidCallback onPressed;
  final void Function()? onPressed;

  const CustomIconButton(
      {Key? key,
        required this.icon,
        this.iconSize,
        required this.onPressed,
        this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
        data: const CupertinoThemeData(primaryColor: Colors.transparent),
        child: CupertinoButton.filled(
          borderRadius: BorderRadius.zero,
          minSize: iconSize,
          padding: padding ?? EdgeInsets.all(12.w),
          //onPressed: () => onPressed(),
          onPressed: onPressed,
          child: icon,
        ));
  }
}