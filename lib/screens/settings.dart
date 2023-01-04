import 'package:ahadi_pledge/controllers/auth_controller.dart';
import 'package:ahadi_pledge/screens/change_password.dart';
import 'package:ahadi_pledge/screens/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsScreen extends GetView<AuthController> {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Settings",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(color: Colors.black))),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Alex Paul Rossi",
              style: GoogleFonts.poppins(
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 24,
            ),
            Column(
              children: [
                const ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Change Language"),
                    trailing: Icon(Icons.arrow_forward)),
                ListTile(
                    onTap: () => Get.to(() => const EditProfileScreen()),
                    leading: const Icon(Icons.edit),
                    title: const Text("Edit Profile"),
                    trailing: const Icon(Icons.arrow_forward)),
                ListTile(
                    onTap: () => Get.to(() => const ChangePasswordScreen()),
                    leading: const Icon(Icons.lock),
                    title: const Text("Change Password"),
                    trailing: const Icon(Icons.arrow_forward)),
                ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    leading: const Icon(Icons.logout),
                    title: const Text("Logout"),
                    trailing: const Icon(Icons.arrow_forward))
              ],
            )
          ],
        ),
      ),
    );
  }
}
