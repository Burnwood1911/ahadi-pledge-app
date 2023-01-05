import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    await Future.delayed(const Duration(seconds: 3),
        () => {controller = Get.find<AuthController>()});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const LoadingIndicator(
                  indicatorType: Indicator.ballClipRotatePulse,
                  colors: [Colors.blue],
                  strokeWidth: 3,
                  backgroundColor: Colors.white,
                  pathBackgroundColor: Colors.white),
              Text(
                "Loading Please Wait...",
                style: GoogleFonts.poppins(),
              )
            ],
          ),
        ));
  }
}
