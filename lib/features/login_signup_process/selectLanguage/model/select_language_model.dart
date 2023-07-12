import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';

class LanguageModel {
  String languageName;
  String icon;
  bool isSeleceted;
  LanguageModel({
    required this.languageName,
    required this.icon,
    required this.isSeleceted,
  });
}

List<LanguageModel> languageList = [
  LanguageModel(
      languageName: AppStrings.english.tr,
      icon: ImageResource.flagUSA,
      isSeleceted: true),
  LanguageModel(
      languageName: AppStrings.spanish.tr,
      icon: ImageResource.flagSpain,
      isSeleceted: false),
];
