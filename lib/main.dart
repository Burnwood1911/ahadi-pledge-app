import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/controllers/card_controller.dart';
import 'package:ahadi_pledge/controllers/community_controller.dart';
import 'package:ahadi_pledge/controllers/notification_controller.dart';
import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/screens/splash_screen.dart';
import 'package:ahadi_pledge/translations/codegen_loader.g.dart';
import 'package:easy_localization/easy_localization.dart';
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
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await setup();

  Get.lazyPut(() => AuthController(), fenix: true);
  Get.lazyPut(() => PledgeController(), fenix: true);
  Get.lazyPut(() => PaymentController(), fenix: true);
  Get.lazyPut(() => CommunityController(), fenix: true);
  Get.lazyPut(() => UserController(), fenix: true);
  Get.lazyPut(() => CardController(), fenix: true);
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

  runApp(EasyLocalization(
    path: 'assets/translations',
    supportedLocales: const [Locale('en'), Locale('sw')],
    fallbackLocale: const Locale('en'),
    assetLoader: const CodegenLoader(),
    child: const MyApp(),
  ));
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
  const MyApp({super.key});

  final MaterialColor mycolor = const MaterialColor(
    0xFF2768B1,
    <int, Color>{
      50: Color(0xFFE8F0F8),
      100: Color(0xFFC5DAEE),
      200: Color(0xFF9EC2E3),
      300: Color(0xFF77AAD7),
      400: Color(0xFF5A97CF),
      500: Color(0xFF3D85C6),
      600: Color(0xFF377DC0),
      700: Color(0xFF2F72B9),
      800: Color(0xFF2768B1),
      900: Color(0xFF1A55A4),
    },
  );

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      theme: ThemeData(primarySwatch: mycolor),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
