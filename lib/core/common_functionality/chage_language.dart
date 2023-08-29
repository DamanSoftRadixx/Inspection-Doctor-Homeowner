import 'dart:ui';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';

changeLanguage() async {
  var selectedLang = await Prefs.read(Prefs.selectedLangId);

  if (selectedLang == LanguageEnum.english.langunageId) {
    var locale = const Locale("en");
    Get.updateLocale(locale);
  } else if (selectedLang == LanguageEnum.spanish.langunageId) {
    var locale = const Locale("sp");
    Get.updateLocale(locale);
  }
}

