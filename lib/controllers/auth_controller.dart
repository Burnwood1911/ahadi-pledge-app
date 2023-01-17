import 'dart:convert';
import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/repos/auth_repo.dart';
import 'package:ahadi_pledge/repos/user_repo.dart';
import 'package:ahadi_pledge/screens/home_screen.dart';
import 'package:ahadi_pledge/screens/login.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/snackbar.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:easy_localization/easy_localization.dart';

class AuthController extends GetxController with StateMixin {
  final authRepository = getIt.get<AuthRepository>();
  final userRepository = getIt.get<UserRepository>();

  //Register errors
  Rx<String?> phoneError = Rx<String?>(null);
  Rx<String?> emailError = Rx<String?>(null);
  Rx<String?> passwordError = Rx<String?>(null);

  @override
  void onReady() {
    super.onReady();
    checkAuthState();
    change(state, status: RxStatus.success());
  }

  void checkAuthState() async {
    final String? token = GetStorage().read("token");
    if (token == null) {
      Get.offAll(() => AuthScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  void login(String email, String password) async {
    change(state, status: RxStatus.loading());

    final result = await authRepository.login(email, password);

    result.when((success) async {
      change(state, status: RxStatus.success());

      var token = await getToken();
      userRepository.addFcmToken(token);
      Get.offAll(() => HomeScreen());
    }, (error) {
      change(state, status: RxStatus.success());

      showAppSnackbar(LocaleKeys.error_text.tr(),
          LocaleKeys.credentials_not_correct_text.tr());
    });
  }

  void register(
      String fname,
      String mname,
      String lname,
      String phone,
      String email,
      String password,
      String selectedGender,
      String birth,
      int jumuiyaId) async {
    change(state, status: RxStatus.loading());

    final result = await authRepository.register(fname, mname, lname, phone,
        email, password, selectedGender, birth, jumuiyaId);

    result.when((success) {
      change(state, status: RxStatus.success());
      showAppSnackbar(LocaleKeys.success_text.tr(),
          LocaleKeys.account_registered_text.tr());
    }, (error) {
      change(state, status: RxStatus.success());
      var errorResponse = jsonDecode((error as DioError).response.toString());
      Map<String, dynamic> errors = errorResponse['errors'];
      errors.forEach((k, v) {
        switch (k) {
          case "email":
            emailError.value = v[0].toString();
            break;
          case "phone":
            phoneError.value = v[0].toString();
            break;
          case "password":
            passwordError.value = v[0].toString();
            break;
          default:
            break;
        }
      });
    });
  }

  Future<String> getToken() async {
    return (await FirebaseMessaging.instance.getToken())!;
  }
}
