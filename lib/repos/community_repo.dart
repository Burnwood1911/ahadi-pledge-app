import 'dart:convert';

import 'package:ahadi_pledge/models/community.dart';

import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:dio/dio.dart';

class CommunityRepository {
  final DioClient dio;
  CommunityRepository({required this.dio});

  Future<Community> getJumuiyas() async {
    try {
      var response = await dio.get("/jumuiya");
      return communityFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }
}
