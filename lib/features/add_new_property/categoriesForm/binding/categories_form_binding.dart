import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/categoriesForm/controller/categories_form_controller.dart';

class CategoryFormBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryFormController>(() => CategoryFormController());
  }
}
