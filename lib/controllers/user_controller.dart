import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/repos/user_repo.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

class UserController extends GetxController {
  final userRepository = getIt.get<UserRepository>();
  static UserController instance = Get.find<UserController>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController mname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  RxBool isLoading = RxBool(false);
  Rx<User?> user = Rx<User?>(null);
  RxString error = RxString("");

  Future<void> fetchUser() async {
    isLoading(true);
    final result = await userRepository.fetchUser();
    result.when((userData) {
      user.value = userData;
      setValues();
    }, (error) {});
    isLoading(false);
  }

  Future<void> updateUser(String fname, String mname, String lname,
      String phone, String email) async {
    isLoading(true);
    final result =
        await userRepository.updateUser(fname, mname, lname, phone, email);
    result.when((userData) {
      user.value = userData;
      setValues();
    }, (error) {});
    isLoading(false);
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    isLoading(true);
    final result =
        await userRepository.changePassword(oldPassword, newPassword);

    result.when((success) {
      Get.back();
      showAppSnackbar(
          LocaleKeys.success_text.tr(), LocaleKeys.password_changed_text.tr());
    }, (error) {
      showAppSnackbar(LocaleKeys.error_text.tr(), error.message);
    });
    isLoading(false);
  }

  Future<void> requestCard() async {
    isLoading(true);

    final result = await userRepository.requestCard();
    result.when((success) {
      showAppSnackbar(
          LocaleKeys.success_text.tr(), LocaleKeys.card_created_text.tr());
    }, (error) {
      showAppSnackbar(LocaleKeys.error_text.tr(), error.message);
    });

    isLoading(false);
  }

  void setValues() {
    fname.text = user.value!.fname;
    mname.text = user.value!.mname;
    lname.text = user.value!.lname;
    phone.text = user.value!.phone;
    email.text = user.value!.email;
  }

  @override
  void dispose() {
    fname.dispose();
    mname.dispose();
    lname.dispose();
    phone.dispose();
    email.dispose();
    super.dispose();
  }
}

final userController = UserController.instance;
