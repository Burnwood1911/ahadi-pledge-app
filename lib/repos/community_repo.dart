import 'dart:convert';

import 'package:ahadi_pledge/models/community.dart';

import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/utils/custom_error.dart';
import 'package:ahadi_pledge/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

class CommunityRepository {
  final DioClient dio;
  CommunityRepository({required this.dio});

  Future<Result<Community, Failure>> getJumuiyas() async {
    try {
      var response = await dio.get("/jumuiya");

      if (response.statusCode == 200) {
        return Success(communityFromJson(jsonEncode(response.data)));
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
