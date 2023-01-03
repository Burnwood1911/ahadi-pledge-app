import 'dart:convert';
import 'dart:io';

import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/network/dio_exception.dart';
import 'package:dio/dio.dart';

import 'package:get_storage/get_storage.dart';

class AuthRepository {
  final DioClient dio;
  AuthRepository({required this.dio});

  Future<bool> login(String email, String password) async {
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
      return true;
    } else {
      return false;
    }
  }

  Future<bool> register(
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
      return true;
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }
}
