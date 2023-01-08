import 'package:flutter/animation.dart';
import 'package:get/get.dart';

void showAppSnackbar(String title, String message) {
  Get.showSnackbar(GetSnackBar(
    backgroundColor: const Color(0xFF2768B1),
    title: title,
    message: message,
    duration: const Duration(seconds: 2),
  ));
}
