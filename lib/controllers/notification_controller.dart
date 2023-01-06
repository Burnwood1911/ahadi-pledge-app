import 'package:ahadi_pledge/repos/user_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../di/service_locater.dart';
import '../main.dart';

class NotificationController extends GetxController {
  String? token;
  final userRepository = getIt.get<UserRepository>();

  @override
  void onInit() async {
    super.onInit();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('ic_launcher');
    var initialzationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initialzationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                color: Colors.blue,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: "@mipmap/ic_launcher",
              ),
            ));
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        // showDialog(
        //     // context: context,
        //     builder: (_) {
        //   return AlertDialog(
        //     title: Text(notification.title),
        //     content: SingleChildScrollView(
        //       child: Column(
        //         crossAxisAlignment: CrossAxisAlignment.start,
        //         children: [Text(notification.body)],
        //       ),
        //     ),
        //   );
        // });
      }
    });

    var token = await getToken();
    String? userLoginToken = GetStorage().read('token');
    if (userLoginToken != null) {
      userRepository.addFcmToken(token);
    }
  }

  Future<String> getToken() async {
    token = (await FirebaseMessaging.instance.getToken())!;
    return token!;
  }
}
