import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/repos/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController with StateMixin<User> {
  final userRepository = getIt.get<UserRepository>();
  final TextEditingController fname = TextEditingController();
  final TextEditingController mname = TextEditingController();
  final TextEditingController lname = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();

  @override
  void onReady() async {
    super.onReady();
    change(state, status: RxStatus.success());
  }

  Future<void> fetchUser() async {
    change(state, status: RxStatus.loading());
    final result = await userRepository.fetchUser();
    result.when((user) {
      change(user, status: RxStatus.success());
      setValues();
    }, (error) => change(state, status: RxStatus.error(error.toString())));
  }

  Future<void> updateUser(String fname, String mname, String lname,
      String phone, String email) async {
    change(state, status: RxStatus.loading());
    final result =
        await userRepository.updateUser(fname, mname, lname, phone, email);
    result.when((user) {
      change(user, status: RxStatus.success());
      setValues();
    }, (error) => change(state, status: RxStatus.error(error.toString())));
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    change(state, status: RxStatus.loading());
    final result =
        await userRepository.changePassword(oldPassword, newPassword);

    result.when((success) {
      change(state, status: RxStatus.success());
      Get.back();
      Get.snackbar("Success", "Password Changed");
    }, (error) {
      change(state, status: RxStatus.success());
      Get.snackbar("Error", "Old Password Doesn't match!");
    });
  }

  Future<void> requestCard() async {
    change(state, status: RxStatus.loading());
    final result = await userRepository.requestCard();
    result.when((success) {
      change(state, status: RxStatus.success());
      Get.snackbar('Success', 'Your card has been created');
    }, (error) {
      change(state, status: RxStatus.error(error.toString()));
      Get.snackbar('Error', 'Failed to create card');
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
