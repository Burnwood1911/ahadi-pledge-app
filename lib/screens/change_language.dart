import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart' hide Trans;

class ChangeLanguageScreen extends StatelessWidget {
  const ChangeLanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.change_language_text.tr(),
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.black))),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(8)),
                onPressed: () async {
                  await context.setLocale(const Locale('en'));
                  Get.updateLocale(const Locale('en'));
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/gb.png",
                      height: 100,
                      width: 100,
                    ),
                    const Text("English"),
                  ],
                )),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                style:
                    ElevatedButton.styleFrom(padding: const EdgeInsets.all(8)),
                onPressed: () async {
                  await context.setLocale(const Locale('sw'));
                  Get.updateLocale(const Locale('sw'));
                },
                child: Column(
                  children: [
                    Image.asset(
                      "assets/tz.png",
                      height: 100,
                      width: 100,
                    ),
                    const Text("Swahili"),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
