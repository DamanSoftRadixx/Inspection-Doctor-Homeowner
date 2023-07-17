import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:get/get.dart';

logoutFunctionality(){

  if(Get.currentRoute != Routes.loginScreen){
    Prefs.erase();
    Get.offAllNamed(Routes.loginScreen);
  }

}