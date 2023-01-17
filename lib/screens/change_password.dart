import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController? oldPassword;
  TextEditingController? newPassword;
  GlobalKey<FormState>? _formKey;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    oldPassword = TextEditingController();
    newPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          title: Text(
            LocaleKeys.change_password_text.tr(),
            style: GoogleFonts.poppins(
                textStyle: const TextStyle(color: Colors.black)),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.white,
        body: userController.obx(
          (state) {
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      controller: oldPassword,
                      decoration: InputDecoration(
                          labelText: LocaleKeys.old_password_text.tr(),
                          filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This Field Cant Be Blank";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: TextFormField(
                      controller: newPassword,
                      decoration: InputDecoration(
                          labelText: LocaleKeys.new_password_text.tr(),
                          filled: true),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "This Field Cant Be Blank";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 18.0, right: 18.0, top: 18.0),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor),
                        onPressed: () {
                          if (_formKey!.currentState!.validate()) {
                            userController.changePassword(
                                oldPassword!.text, newPassword!.text);
                            _formKey!.currentState!.reset();
                          }
                        },
                        child: Text(
                          LocaleKeys.save_text.tr(),
                          style: GoogleFonts.poppins(),
                        )),
                  ),
                ],
              ),
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
    oldPassword?.dispose();
    newPassword?.dispose();
    super.dispose();
  }
}
