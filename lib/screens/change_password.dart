import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  UserController? userController;
  final TextEditingController oldPassword = TextEditingController();
  final TextEditingController newPassword = TextEditingController();

  @override
  void initState() {
    super.initState();
    userController = Get.find<UserController>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            "Change Password",
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.black)),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: userController!.obx(
          (state) {
            return ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                    controller: oldPassword,
                    decoration: const InputDecoration(
                        labelText: "Old Password", filled: true),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: TextFormField(
                    controller: newPassword,
                    decoration: const InputDecoration(
                        labelText: "New Password", filled: true),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                      onPressed: () {
                        userController!
                            .changePassword(oldPassword.text, newPassword.text);
                      },
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(),
                      )),
                ),
              ],
            );
          },
          onLoading: Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Theme.of(context).primaryColor],
                strokeWidth: 3,
                backgroundColor: Colors.white,
                pathBackgroundColor: Colors.white),
          ),
        ));
  }

  @override
  void dispose() {
    oldPassword.dispose();
    newPassword.dispose();
    super.dispose();
  }
}
