import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';

class HomeController extends GetxController {

  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  onPressAddPropertyButton(){
    Get.toNamed(Routes.addPropertyScreen);
  }

}
