import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

Widget commonNoDataWidget(){

  return Container(
    width: 1.sw,
    height: 1.sh,
    child: Center(child: Text(AppStrings.noDataFound.tr)),
  );


}