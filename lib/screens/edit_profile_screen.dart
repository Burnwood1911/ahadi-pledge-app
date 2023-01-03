import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final UserController userController = Get.find<UserController>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController mname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

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
      body: Obx(() {
        fname.text = userController.user.value.fname ?? "";
        mname.text = userController.user.value.mname ?? "";
        lname.text = userController.user.value.lname ?? "";
        phone.text = userController.user.value.phone ?? "";
        email.text = userController.user.value.email ?? "";
        return userController.isLoading.value
            ? const Center(
                child: LoadingIndicator(
                    indicatorType: Indicator.ballClipRotatePulse,
                    colors: [Colors.blue],
                    strokeWidth: 3,
                    backgroundColor: Colors.white,
                    pathBackgroundColor: Colors.white),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      controller: fname,
                      decoration: const InputDecoration(
                          labelText: "First Name", filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      controller: mname,
                      decoration: const InputDecoration(
                          labelText: "Middle Name", filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      controller: lname,
                      decoration: const InputDecoration(
                          labelText: "Last Name", filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      controller: phone,
                      decoration: const InputDecoration(
                          labelText: "Phone", filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          labelText: "email", filled: true),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: ElevatedButton(
                        onPressed: () {
                          userController.updateUser(fname.text, mname.text,
                              lname.text, phone.text, email.text);
                        },
                        child: Text(
                          "Save",
                          style: GoogleFonts.poppins(),
                        )),
                  ),
                ],
              );
      }),
    );
  }
}
