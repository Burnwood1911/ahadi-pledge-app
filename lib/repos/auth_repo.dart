import 'dart:convert';
import 'dart:io';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/utils/custom_error.dart';
import 'package:ahadi_pledge/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multiple_result/multiple_result.dart';

class AuthRepository {
  final DioClient dio;
  AuthRepository({required this.dio});

  Future<Result<bool, Failure>> login(String email, String password) async {
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
        return Error(Failure(
            message: response.statusMessage!,
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(
            Failure(message: "No internet Connection", statusCode: 500));
      } else {
        return Error(Failure(message: "Something went wrong", statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(Failure(message: "Received Invalid JSON", statusCode: 500));
    }
  }

  Future<Result<bool, Failure>> register(
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
      if (response.statusCode == 201) {
        return const Success(true);
      } else {
        return Error(Failure(
            message: response.statusMessage!,
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(
            Failure(message: "No internet Connection", statusCode: 500));
      } else {
        return Error(Failure(message: "Something went wrong", statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(Failure(message: "Received Invalid JSON", statusCode: 500));
    }
  }
}
