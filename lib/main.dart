import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:inspection_doctor_homeowner/core/app/app.dart';
import 'package:inspection_doctor_homeowner/core/constants/common_strings.dart';
import 'package:inspection_doctor_homeowner/core/notification/firebase_messaging.dart';
import 'package:inspection_doctor_homeowner/core/translator/local_translation.dart';

import 'core/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_R3eBVbkdHfttbv7Rf8lP4ewH';

  await Stripe.instance.applySettings();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  await Firebase.initializeApp();
  FirebaseMessaging.instance.requestPermission();
  await Notifications.init();
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
            title: 'Construction Inspection',
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
