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
      {required String fname,
      required String mname,
      required String lname,
      required String phone,
      required String email,
      required String password,
      required String selectedGender,
      required String birth,
      required int jumuiyaId,
      required int martialStatus,
      required int marriageType,
      required int occupationStatus,
      required bool canVolunterr,
      required bool baptized,
      required bool kipaimara,
      required bool sacramentiMezaYaBwana,
      required String placeOfBirth,
      required String marriageDate,
      required String partnerName,
      required String placeOfMarriage,
      required String oldUsharika,
      required String fellowshipName,
      required String neighborMsharikaName,
      required String neighborMsharikaPhone,
      required String deaconName,
      required String deaconPhone,
      required String placeOfWork,
      required String proffession,
      required String baptizationDate,
      required String kipaimaraDate,
      required List<int> selectedSubs}) async {
    change(state, status: RxStatus.loading());

    final result = await authRepository.register(
        fname: fname,
        mname: mname,
        lname: lname,
        phone: phone,
        email: email,
        password: password,
        selectedGender: selectedGender,
        birth: birth,
        jumuiyaId: jumuiyaId,
        martialStatus: martialStatus,
        marriageType: marriageType,
        occupationStatus: occupationStatus,
        canVolunterr: canVolunterr,
        baptized: baptized,
        kipaimara: kipaimara,
        sacramentiMezaYaBwana: sacramentiMezaYaBwana,
        placeOfBirth: placeOfBirth,
        marriageDate: marriageDate,
        partnerName: partnerName,
        placeOfMarriage: placeOfMarriage,
        oldUsharika: oldUsharika,
        fellowshipName: fellowshipName,
        neighborMsharikaName: neighborMsharikaName,
        neighborMsharikaPhone: neighborMsharikaPhone,
        deaconName: deaconName,
        deaconPhone: deaconPhone,
        placeOfWork: placeOfWork,
        proffession: proffession,
        baptizationDate: baptizationDate,
        kipaimaraDate: kipaimaraDate,
        selectedSubs: selectedSubs);

    result.when((success) {
      change(state, status: RxStatus.success());
      showAppSnackbar(LocaleKeys.success_text.tr(),
          LocaleKeys.account_registered_text.tr());
    }, (error) {
      change(state, status: RxStatus.success());
      showAppSnackbar("Error", error.message);
      // var errorResponse = jsonDecode((error as DioError).response.toString());
    });
  }

  Future<String> getToken() async {
    return (await FirebaseMessaging.instance.getToken())!;
  }
}
