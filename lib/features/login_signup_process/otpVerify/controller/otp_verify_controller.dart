import 'package:get/get.dart';

class OtpVerifyController extends GetxController {
  RxString verifyCode = "".obs;
  RxBool isSubmitVisible = false.obs;
  RxBool isNeedResendOTP = false.obs;
}
