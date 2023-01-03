import 'package:ahadi_pledge/di/service_locater.dart';
import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/repos/user_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userRepository = getIt.get<UserRepository>();
  RxBool isLoading = false.obs;
  Rx<User> user = User().obs;

  @override
  void onInit() async {
    super.onInit();
    await fetchUser();
  }

  Future<void> fetchUser() async {
    isLoading(true);
    final result = await userRepository.fetchUser();
    user.value = result;
    isLoading(false);
  }

  Future<void> updateUser(String fname, String mname, String lname,
      String phone, String email) async {
    isLoading(true);
    final result =
        await userRepository.updateUser(fname, mname, lname, phone, email);
    user.value = result;
    isLoading(false);
  }
}
