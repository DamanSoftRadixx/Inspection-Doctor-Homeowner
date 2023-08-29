import 'dart:ui';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';

changeLanguage() async {
  var selectedLang =
      await Prefs.read(Prefs.selectedLangId) ?? LanguageEnum.english.name;
  var locale = Locale(selectedLang);
  Get.updateLocale(locale);
}
