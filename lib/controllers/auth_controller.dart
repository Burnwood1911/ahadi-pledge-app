import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/repos/auth_repo.dart';
import 'package:ahadi_pledge/screens/home_screen.dart';
import 'package:ahadi_pledge/screens/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController {
  final authRepository = getIt.get<AuthRepository>();
  RxBool isLoading = false.obs;

  @override
  void onReady() {
    super.onReady();
    checkAuthState();
  }

  void checkAuthState() async {
    final String? token = GetStorage().read("token");
    if (token == null) {
      Get.offAll(() => const AuthScreen());
    } else {
      Get.offAll(() => const HomeScreen());
    }
  }

  void login(String email, String password) async {
    isLoading(true);

    try {
      final result = await authRepository.login(email, password);

      if (result) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar("Login Failed", "Email or Password Incorrect");
      }
    } catch (f) {
      Get.snackbar("Login Failed", "Something went wrong");
    }

    isLoading(false);
  }

  void logout() async {
    await GetStorage().remove("token");
    Get.offAll(() => const AuthScreen());
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
    isLoading(true);

    try {
      final result = await authRepository.register(fname, mname, lname, phone,
          email, password, selectedGender, birth, jumuiyaId);

      if (result) {
        Get.snackbar("Success", "You have been registered");
      } else {
        Get.snackbar("Fail", "Your registration failed");
      }
    } catch (f) {
      Get.snackbar("Login Failed", "Something went wrong");
    }

    isLoading(false);
  }
}
