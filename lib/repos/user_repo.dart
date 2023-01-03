import 'dart:convert';
import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final DioClient dio;
  UserRepository({required this.dio});

  Future<User> fetchUser() async {
    try {
      var response = await dio.get("/user");
      return userFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<User> updateUser(String fname, String mname, String lname,
      String phone, String email) async {
    Map<String, dynamic> data = {
      "fname": fname,
      "mname": mname,
      "lname": lname,
      "email": email,
      "phone": phone,
    };
    try {
      var response = await dio.post("/user/update", data: jsonEncode(data));
      return userFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    Map<String, dynamic> data = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    try {
      var response = await dio.post("/user/password", data: jsonEncode(data));

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }
}
