// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/controllers/community_controller.dart';
import 'package:ahadi_pledge/controllers/notification_controller.dart';
import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await setup();

  // GetStorage().remove("token");

  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => PledgeController());
  Get.lazyPut(() => PaymentController());
  Get.lazyPut(() => CommunityController());
  Get.lazyPut(() => UserController(), fenix: true);
  Get.put(NotificationController(), permanent: true);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  MyApp({super.key});

  MaterialColor mycolor = MaterialColor(
    0xFF000000,
    <int, Color>{
      50: Color(0xFFE0E0E0),
      100: Color(0xFFB3B3B3),
      200: Color(0xFF808080),
      300: Color(0xFF4D4D4D),
      400: Color(0xFF262626),
      500: Color(0xFF000000),
      600: Color(0xFF000000),
      700: Color(0xFF000000),
      800: Color(0xFF000000),
      900: Color(0xFF000000),
    },
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(primarySwatch: mycolor),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
