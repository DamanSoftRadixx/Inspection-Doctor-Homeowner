import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/controller/select_categories_controller.dart';

class SelectCategoriesBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectedCategoriesController>(
        () => SelectedCategoriesController());
  }
}
