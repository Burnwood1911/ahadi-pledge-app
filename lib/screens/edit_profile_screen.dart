import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class EditProfileScreen extends GetView<UserController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          "Edit Profile",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: controller.obx((state) {
        return ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller.fname,
                decoration: const InputDecoration(
                    labelText: "First Name", filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller.mname,
                decoration: const InputDecoration(
                    labelText: "Middle Name", filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller.lname,
                decoration:
                    const InputDecoration(labelText: "Last Name", filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller.phone,
                decoration:
                    const InputDecoration(labelText: "Phone", filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller.email,
                decoration:
                    const InputDecoration(labelText: "email", filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: ElevatedButton(
                  onPressed: () {
                    controller.updateUser(
                        controller.fname.text,
                        controller.mname.text,
                        controller.lname.text,
                        controller.phone.text,
                        controller.email.text);
                  },
                  child: Text(
                    "Save",
                    style: GoogleFonts.poppins(),
                  )),
            ),
          ],
        );
      },
          onLoading: const Center(
            child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotatePulse,
                colors: [Colors.blue],
                strokeWidth: 3,
                backgroundColor: Colors.white,
                pathBackgroundColor: Colors.white),
          ),
          onError: ((error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Something went wrong"),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          controller.fetchUser();
                        },
                        child: const Text("Try Again")),
                  ],
                ),
              ))),
    );
  }
}
