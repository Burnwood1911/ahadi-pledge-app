import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/repos/auth_repo.dart';
import 'package:ahadi_pledge/repos/community_repo.dart';
import 'package:ahadi_pledge/repos/payment_repo.dart';
import 'package:ahadi_pledge/repos/pledge_repo.dart';
import 'package:ahadi_pledge/repos/user_repo.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  getIt.registerSingleton(Dio());
  getIt.registerSingleton(DioClient(getIt<Dio>()));
  getIt.registerSingleton(PledgeRepository(dio: getIt<DioClient>()));
  getIt.registerSingleton(PaymentRepository(dio: getIt<DioClient>()));
  getIt.registerSingleton(AuthRepository(dio: getIt<DioClient>()));
  getIt.registerSingleton(CommunityRepository(dio: getIt<DioClient>()));
  getIt.registerSingleton(UserRepository(dio: getIt<DioClient>()));
}
