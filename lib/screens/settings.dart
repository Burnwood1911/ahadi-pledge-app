import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/screens/change_language.dart';
import 'package:ahadi_pledge/screens/change_password.dart';
import 'package:ahadi_pledge/screens/edit_profile_screen.dart';
import 'package:ahadi_pledge/screens/login.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

class SettingsScreen extends GetView<AuthController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          title: Text(LocaleKeys.settings_text.tr(),
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.black))),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const Center(
              //   child: CircleAvatar(
              //     radius: 45,
              //     backgroundColor: Colors.black,
              //     child: Icon(
              //       Icons.person,
              //       size: 50,
              //     ),
              //   ),
              // ),

              // Text(
              //   "Alex Paul Rossi",
              //   style: GoogleFonts.poppins(
              //       textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              // ),
              const SizedBox(
                height: 8,
              ),
              const SizedBox(
                height: 24,
              ),
              Column(
                children: [
                  ListTile(
                      onTap: () => Get.to(() => const ChangeLanguageScreen()),
                      leading: const Icon(Icons.language),
                      title: Text(LocaleKeys.change_language_text.tr()),
                      trailing: const Icon(Icons.arrow_forward)),
                  ListTile(
                      onTap: () => Get.to(() => const EditProfileScreen()),
                      leading: const Icon(Icons.edit),
                      title: Text(LocaleKeys.edit_profile_text.tr()),
                      trailing: const Icon(Icons.arrow_forward)),
                  ListTile(
                      onTap: () => Get.to(() => const ChangePasswordScreen()),
                      leading: const Icon(Icons.lock),
                      title: Text(LocaleKeys.change_password_text.tr()),
                      trailing: const Icon(Icons.arrow_forward)),
                  ListTile(
                      onTap: () async {
                        await GetStorage().remove("token");
                        Get.offAll(() => AuthScreen());
                      },
                      leading: const Icon(Icons.logout),
                      title: Text(LocaleKeys.logout_text.tr()),
                      trailing: const Icon(Icons.arrow_forward))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
