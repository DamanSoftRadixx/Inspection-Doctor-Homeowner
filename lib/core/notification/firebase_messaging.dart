import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';

class Notifications {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future init() async {
    getFirebaseToken();
    initializeLocalNotifications();
    setupInteractedMessage();
  }

  static initializeLocalNotifications() async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: (id, title, body, payload) {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse? notificationResponse) async {
      // tapped method, when app is in foreground

      debugPrint('notification payload: ${notificationResponse?.payload}');
      var payload = notificationResponse?.payload ?? "";
      if (payload != "") {
        RemoteMessage data = RemoteMessage.fromMap(jsonDecode(payload));
        onPressNotificationItem(message: data);
      }
    });

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static getFirebaseToken() {
    FirebaseMessaging firebaseMessaging =
        FirebaseMessaging.instance; // Change here
    firebaseMessaging.requestPermission(
        sound: true, announcement: true, alert: true, badge: true);

    firebaseMessaging.getToken().then((token) {
      Prefs.write(GetArgumentConstants.deviceToken, token);
    });

    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      Prefs.write(GetArgumentConstants.deviceToken, fcmToken);
    }).onError((err) {
      if (kDebugMode) {}
      // Error getting token.
    });
  }

  static void showNotification(RemoteMessage message) {
    //show foreground notification
    flutterLocalNotificationsPlugin.show(
        message.notification.hashCode,
        message.notification?.title ?? "",
        message.notification?.body ?? "",
        payload: jsonEncode(message.toMap()),
        NotificationDetails(
            android: AndroidNotificationDetails(channel.id, channel.name,
                importance: Importance.max,
                enableVibration: true,
                playSound: true,
                priority: Priority.high),
            iOS: const DarwinNotificationDetails(
                presentSound: true,
                presentBadge: true,
                presentAlert: true,
                threadIdentifier: "Homeowner",
                sound: "default")));
  }

  static setupInteractedMessage() async {
    // Also handle any interaction when the app is in the background via a
    // Stream listener
    // This will be called when we tapped on notification, for background.
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      RemoteNotification? notification = event.notification;

      onPressNotificationItem(message: event);
    });

    //Got a message whilst in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showNotification(message);
    });

    // FirebaseMessaging.onBackgroundMessage(onBackgroundMessageCallback);

    //When app is terminated state, and we want to handle the notification tap
    handleNotificationTapForTerminatedState();
  }

  static onPressNotificationItem({required RemoteMessage message}) async {
    print("Response of message is :${message.data}");
    snackbar(message.data.toString());
    String inspectionId = message.data["inspection_id"];
    if (inspectionId != "") {
      Get.toNamed(Routes.inspectionDetailScreen,
              arguments: {GetArgumentConstants.inspectionId: inspectionId})
          ?.then((value) {});
    }
  }

  static handleNotificationTapForTerminatedState() {
    Notifications.appComesFromTerminatedState();
  }

  static appComesFromTerminatedState() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      Notifications.onPressNotificationItem(message: initialMessage);
    }
  }
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'inspection_doctor', // id
    'Inspection Doctor', // title
    importance: Importance.max);
