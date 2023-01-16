import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  UserController? controller;
  @override
  void initState() {
    super.initState();
    controller = Get.find<UserController>();
    controller?.fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        title: Text(
          LocaleKeys.edit_profile_text.tr(),
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: controller!.obx((state) {
        return ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller!.fname,
                decoration: InputDecoration(
                    labelText: LocaleKeys.first_name_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller!.mname,
                decoration: InputDecoration(
                    labelText: LocaleKeys.second_name_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller!.lname,
                decoration: InputDecoration(
                    labelText: LocaleKeys.last_name_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller!.phone,
                decoration: InputDecoration(
                    labelText: LocaleKeys.phone_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: controller!.email,
                decoration: InputDecoration(
                    labelText: LocaleKeys.email_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  onPressed: () {
                    controller!.updateUser(
                        controller!.fname.text,
                        controller!.mname.text,
                        controller!.lname.text,
                        controller!.phone.text,
                        controller!.email.text);
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
                          controller!.fetchUser();
                        },
                        child: const Text("Try Again")),
                  ],
                ),
              ))),
    );
  }
}
