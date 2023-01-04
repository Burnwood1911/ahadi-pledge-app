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

      if (response.statusCode == 200) {
        String token = response.data;
        await GetStorage().write('token', token);
        return const Success(true);
      } else {
        return const Success(false);
      }
    } on DioError catch (_) {
      return Error(Exception("Something went wrong"));
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
      var response = await dio.post("/register", data: jsonEncode(data));
      if (response.statusCode == 200) {
        return const Success(true);
      } else {
        return const Success(false);
      }
    } on DioError catch (_) {
      return Error(Exception("Something went wrong"));
    } on TypeError catch (_) {
      return Error(Exception("Type error occured"));
    }
  }
}
