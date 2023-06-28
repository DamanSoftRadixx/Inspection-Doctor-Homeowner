import 'package:get/get.dart';


commonSnackBar({required String title, required String message}){
  Get.snackbar("${title}", "${message}");
}