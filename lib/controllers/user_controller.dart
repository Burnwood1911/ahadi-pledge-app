import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/repos/user_repo.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';

class UserController extends GetxController with StateMixin<User> {
  final userRepository = getIt.get<UserRepository>();
  static UserController instance = Get.find<UserController>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController mname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void onReady() async {
    super.onReady();
    change(state, status: RxStatus.empty());
  }

  Future<void> fetchUser() async {
    change(state, status: RxStatus.loading());
    final result = await userRepository.fetchUser();
    result.when((user) {
      change(user, status: RxStatus.success());
      setValues();
    }, (error) => change(state, status: RxStatus.error(error.message)));
  }

  Future<void> updateUser(String fname, String mname, String lname,
      String phone, String email) async {
    change(state, status: RxStatus.loading());
    final result =
        await userRepository.updateUser(fname, mname, lname, phone, email);
    result.when((user) {
      change(user, status: RxStatus.success());
      setValues();
    }, (error) => change(state, status: RxStatus.error(error.message)));
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    change(state, status: RxStatus.loading());
    final result =
        await userRepository.changePassword(oldPassword, newPassword);

    result.when((success) {
      change(state, status: RxStatus.success());
      Get.back();
      showAppSnackbar(
          LocaleKeys.success_text.tr(), LocaleKeys.password_changed_text.tr());
    }, (error) {
      change(state, status: RxStatus.success());
      showAppSnackbar(LocaleKeys.error_text.tr(),
          LocaleKeys.old_password_not_match_text.tr());
    });
  }

  Future<void> requestCard() async {
    change(state, status: RxStatus.loading());
    final result = await userRepository.requestCard();
    result.when((success) {
      change(state, status: RxStatus.success());
      showAppSnackbar(
          LocaleKeys.success_text.tr(), LocaleKeys.card_created_text.tr());
    }, (error) {
      change(state, status: RxStatus.error(error.message));
      showAppSnackbar(
          LocaleKeys.error_text.tr(), LocaleKeys.card_failed_create_text.tr());
    });
  }

  void setValues() {
    fname.text = state!.fname;
    mname.text = state!.mname;
    lname.text = state!.lname;
    phone.text = state!.phone;
    email.text = state!.email;
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
