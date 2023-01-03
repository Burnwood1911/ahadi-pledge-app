// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
                  textStyle: TextStyle(color: Colors.black))),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.black),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 16,
            ),
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
                child: Icon(
                  Icons.person,
                  size: 50,
                ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Alex Paul Rossi",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 8,
            ),
            SizedBox(
              height: 24,
            ),
            Column(
              children: [
                ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Change Language"),
                    trailing: Icon(Icons.arrow_forward)),
                ListTile(
                    onTap: () => Get.to(() => EditProfileScreen()),
                    leading: Icon(Icons.edit),
                    title: Text("Edit Profile"),
                    trailing: Icon(Icons.arrow_forward)),
                ListTile(
                    onTap: () => Get.to(() => ChangePasswordScreen()),
                    leading: Icon(Icons.lock),
                    title: Text("Change Password"),
                    trailing: Icon(Icons.arrow_forward)),
                ListTile(
                    onTap: () {
                      controller.logout();
                    },
                    leading: Icon(Icons.logout),
                    title: Text("Logout"),
                    trailing: Icon(Icons.arrow_forward))
              ],
            )
          ],
        ),
      ),
    );
  }
}
