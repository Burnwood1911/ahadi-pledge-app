import 'dart:convert';
import 'dart:io';

import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/network/dio_exception.dart';
import 'package:dio/dio.dart';

import 'package:get_storage/get_storage.dart';

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
}
