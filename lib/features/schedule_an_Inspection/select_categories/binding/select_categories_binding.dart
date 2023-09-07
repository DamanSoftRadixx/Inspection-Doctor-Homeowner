import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/controller/select_categories_controller.dart';

class SelectCategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedCategoriesController>(
        () => SelectedCategoriesController());
  }
}
