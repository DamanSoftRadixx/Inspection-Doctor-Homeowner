import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inspection_doctor_homeowner/core/app/app.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/translator/local_translation.dart';

import 'core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  // ApiHitter.shared.changeTimeoutTime(timeoutMinutes: 90);
  runApp(const AppContainer(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            title: 'Homeowner',
            translations: LocalString(),
            locale: const Locale('en', 'US'),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.dark,
            getPages: appPages(),
            initialRoute: Routes.root,
            theme: ThemeData(
              // useMaterial3: true,
              primarySwatch: Colors.blue,
              fontFamily: CommonStrings.generalSans,
            ),
          );
        });
  }
}
