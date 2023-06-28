

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_strings.dart';

class ForgetScreenController extends GetxController{
  TextEditingController emailController = TextEditingController();
  RxBool errorBool=false.obs;
  RxString emailErrorMessage = AppStrings.emailError.tr.obs;

 FocusNode emailFocusNode=FocusNode();


  void resetPassword(){
    if(emailController.text.isEmpty){
      errorBool.value=true;
      emailErrorMessage.value = AppStrings.emailError.tr;
    }else if(!GetUtils.isEmail(emailController.text)){
      errorBool.value=true;
      emailErrorMessage.value = AppStrings.emailError.tr;
    }else{
      FocusManager.instance.primaryFocus?.unfocus();
      Get.back();
    }
  }


}