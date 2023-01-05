import 'dart:convert';
import 'dart:io';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthRepository {
  final DioClient dio;
  AuthRepository({required this.dio});

  Future<Result<bool, Exception>> login(String email, String password) async {
    try {
      final response = await dio.post('/token',
          data: {
            'email': email,
            'password': password,
            'device_name': Platform.isAndroid ? "android" : "ios",
          },
          options: Options(headers: {"requiresToken": true}));

      String token = response.data;
      await GetStorage().write('token', token);
      return const Success(true);
    } on DioError catch (_) {
      return Error(Exception("credentials are incorrect"));
    } on TypeError catch (_) {
      return Error(Exception("Type error occured"));
    }
  }

  Future<Result<bool, Exception>> register(
    String fname,
    String mname,
    String lname,
    String phone,
    String email,
    String password,
    String selectedGender,
    String birth,
    int jumuiyaId,
  ) async {
    Map<String, dynamic> data = {
      "fname": fname,
      "mname": mname,
      "lname": lname,
      "email": email,
      "phone": phone,
      "date_of_birth": birth,
      "gender": selectedGender,
      "jumuiya": jumuiyaId,
      "password": password
    };

    try {
      await dio.post("/register", data: jsonEncode(data));
      return const Success(true);
    } on DioError catch (e) {
      return Error(e);
    } on TypeError catch (_) {
      return Error(Exception("Type error occured"));
    }
  }
}
