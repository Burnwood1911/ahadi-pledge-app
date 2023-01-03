// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/controllers/community_controller.dart';
import 'package:ahadi_pledge/controllers/payment_controller.dart';
import 'package:ahadi_pledge/controllers/pledge_controller.dart';
import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await setup();

  Get.lazyPut(() => AuthController());
  Get.lazyPut(() => PledgeController(), fenix: true);
  Get.lazyPut(() => PaymentController(), fenix: true);
  Get.lazyPut(() => CommunityController(), fenix: true);
  Get.lazyPut(() => UserController(), fenix: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
