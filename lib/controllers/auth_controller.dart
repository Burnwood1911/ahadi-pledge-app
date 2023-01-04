import 'package:ahadi_pledge/controllers/user_controller.dart';
import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/repos/auth_repo.dart';
import 'package:ahadi_pledge/screens/home_screen.dart';
import 'package:ahadi_pledge/screens/login.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthController extends GetxController with StateMixin {
  final authRepository = getIt.get<AuthRepository>();

  @override
  void onReady() {
    super.onReady();
    checkAuthState();
    change(state, status: RxStatus.success());
  }

  void checkAuthState() async {
    final String? token = GetStorage().read("token");
    if (token == null) {
      Get.offAll(() => const AuthScreen());
    } else {
      Get.offAll(() => const HomeScreen());
      Get.find<UserController>().fetchUser();
    }
  }

  void login(String email, String password) async {
    change(state, status: RxStatus.loading());

    final result = await authRepository.login(email, password);

    result.when((success) {
      change(state, status: RxStatus.success());

      if (success) {
        Get.offAll(() => const HomeScreen());
      } else {
        Get.snackbar("Failed", "Invalid Credentials");
      }
    }, (error) {
      change(state, status: RxStatus.success());
      Get.snackbar("Failed", "Something went wrong");
    });
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
    change(state, status: RxStatus.loading());

    final result = await authRepository.register(fname, mname, lname, phone,
        email, password, selectedGender, birth, jumuiyaId);

    result.when((success) {
      change(state, status: RxStatus.success());
      if (success) {
        Get.snackbar("Success", "Account registered");
      } else {
        Get.snackbar("Failed", "Account failed to register");
      }
    }, (error) {
      change(state, status: RxStatus.success());
      Get.snackbar("Failed", "Something went wrong");
    });
  }
}
