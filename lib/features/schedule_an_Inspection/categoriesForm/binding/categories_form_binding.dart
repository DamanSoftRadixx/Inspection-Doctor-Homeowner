import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/categoriesForm/controller/categories_form_controller.dart';

class CategoryFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryFormController>(() => CategoryFormController());
  }
}
