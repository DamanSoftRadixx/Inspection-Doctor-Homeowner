import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonFunctionality {
  launchUrlOnBrowser({required String url}) async {
    try {
      if (await canLaunchUrl(
        Uri.parse(url),
      )) {
        print('launching Url');
        await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch url';
      }
    } catch (e) {
      print("Exception Error: $e");
    }
  }

  clearPrefAndLogout() {
    Prefs.erase();
    Get.offAllNamed(Routes.introScreen);
  }
}
