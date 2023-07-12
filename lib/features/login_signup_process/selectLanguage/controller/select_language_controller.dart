import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/model/get_role_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/model/select_language_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/provider/select_language_provider.dart';

class SelectLanguageController extends GetxController {
  SelectLanguageProvider selectLanguageProvider = SelectLanguageProvider();

  RxList<Language> languageList = <Language>[].obs;
  Rx<Language> selectedLanguage = Language().obs;

  RxBool isShowLoader = false.obs;

  @override
  void onInit() {
    getLangauge();

    super.onInit();
  }

  void onTapCheckBox(Language value) {
    selectedLanguage.value = value;
    selectedLanguage.refresh();
    Prefs.write(Prefs.selectedLangId, selectedLanguage.value.id);
  }

  void onTapContinueButton() {
    Get.toNamed(Routes.loginScreen, arguments: {
      GetArgumentConstants.selectedLanguage: selectedLanguage.value
    });
  }

  getLangauge() async {
    isShowLoader.value = true;
    GetLangaugeResponseModel response =
        await selectLanguageProvider.getLanguages() ??
            GetLangaugeResponseModel();

    if (response.success == true && response.data?.languages != []) {
      languageList.clear();
      languageList.addAll(response.data?.languages ?? []);
      selectedLanguage.value = languageList.first;
      getRole();
      isShowLoader.value = false;
    } else {
      isShowLoader.value = false;
    }
  }

  getRole() async {
    GetRolesResponse response =
        await selectLanguageProvider.getRoles() ?? GetRolesResponse();

    if (response.success == true) {
      response.data?.roles?.map((e) {
        if (e.name == RoleTypeEnum.homeowner.value) {
          Prefs.write(Prefs.homeownerRollId, e.id);
        }
      }).toList();
    }
  }
}
