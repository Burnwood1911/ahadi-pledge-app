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
  @override
  void initState() {
    super.initState();
    userController.fetchUser();
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
      body: userController.obx((state) {
        return ListView(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: userController.fname,
                decoration: InputDecoration(
                    labelText: LocaleKeys.first_name_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: userController.mname,
                decoration: InputDecoration(
                    labelText: LocaleKeys.second_name_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: userController.lname,
                decoration: InputDecoration(
                    labelText: LocaleKeys.last_name_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: userController.phone,
                decoration: InputDecoration(
                    labelText: LocaleKeys.phone_text.tr(), filled: true),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 18.0, right: 18.0, top: 18.0),
              child: TextFormField(
                controller: userController.email,
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
                    userController.updateUser(
                        userController.fname.text,
                        userController.mname.text,
                        userController.lname.text,
                        userController.phone.text,
                        userController.email.text);
                  },
                  child: Text(
                    LocaleKeys.save_text.tr(),
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
          onEmpty: const Center(
            child: Text("No user Data"),
          ),
          onError: ((error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(error!),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          userController.fetchUser();
                        },
                        child: const Text("Try Again")),
                  ],
                ),
              ))),
    );
  }
}
