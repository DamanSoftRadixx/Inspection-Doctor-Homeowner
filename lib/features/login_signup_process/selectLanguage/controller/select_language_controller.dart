import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/model/select_language_model.dart';

class SelectLanguageController extends GetxController {
  RxList<LanguageModel> languageListObs = <LanguageModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit

    languageListObs.value = languageList;
    super.onInit();
  }

  void onTapCheckBox(LanguageModel value) {
    for (int i = 0; i < languageListObs.length; i++) {
      languageListObs[i].isSeleceted = false;
    }

    value.isSeleceted = true;
    languageListObs.refresh();
  }

  void onTapContinueButton() {
    // var contain =
    //     languageListObs.where((element) => element.isSeleceted == true);
    // if (contain.isNotEmpty) {
    //   Get.toNamed(Routes.loginScreen);
    // } else {
    //   showCommonAlertWithTwoActionsDialog(
    //       title: AppStrings.alert,
    //       subHeader: ErrorMessages.pleaseSelectAppLanguage,
    //       rightButtonTitle: AppStrings.ok,
    //       yesPressed: () {
    //         Get.back();
    //       },
    //       noPressed: () {
    //         Get.back();
    //       });
    // }

    Get.toNamed(Routes.loginScreen);
  }
}
