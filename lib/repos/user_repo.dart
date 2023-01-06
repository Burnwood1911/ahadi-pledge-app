import 'dart:convert';
import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

class UserRepository {
  final DioClient dio;
  UserRepository({required this.dio});

  Future<Result<User, Exception>> fetchUser() async {
    try {
      var response = await dio.get("/user");

      return Success(userFromJson(jsonEncode(response.data)));
    } on DioError catch (_) {
      return Error(Exception("Something went wrong"));
    } on TypeError catch (_) {
      return Error(Exception("Type error occured"));
    }
  }

  Future<Result<User, Exception>> updateUser(String fname, String mname,
      String lname, String phone, String email) async {
    Map<String, dynamic> data = {
      "fname": fname,
      "mname": mname,
      "lname": lname,
      "email": email,
      "phone": phone,
    };
    try {
      var response = await dio.post("/user/update", data: jsonEncode(data));
      return Success(userFromJson(jsonEncode(response.data)));
    } on DioError catch (_) {
      return Error(Exception("Something went wrong"));
    } on TypeError catch (_) {
      return Error(Exception("Type error occured"));
    }
  }

  Future<Result<bool, Exception>> addFcmToken(String token) async {
    Map<String, dynamic> data = {
      "fcm_token": token,
    };
    try {
      await dio.post("/user/update", data: jsonEncode(data));
      return const Success(true);
    } on DioError catch (_) {
      return Error(Exception("Something went wrong"));
    } on TypeError catch (_) {
      return Error(Exception("Type error occured"));
    }
  }

  Future<Result<bool, Exception>> changePassword(
      String oldPassword, String newPassword) async {
    Map<String, dynamic> data = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    try {
      await dio.post("/change-password", data: jsonEncode(data));
      return const Success(true);
    } on DioError catch (_) {
      return Error(Exception("Something went wrong"));
    } on TypeError catch (_) {
      return Error(Exception("Type error occured"));
    }
  }
}
