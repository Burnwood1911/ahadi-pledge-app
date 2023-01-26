import 'dart:convert';
import 'package:ahadi_pledge/api/pledge_form.dart';
import 'package:ahadi_pledge/models/pledge.dart';
import 'package:ahadi_pledge/models/pledge_purposes.dart';
import 'package:ahadi_pledge/models/pledge_types.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/network/dio_exception.dart';
import 'package:dio/dio.dart';

class PledgeRepository {
  final DioClient dio;
  PledgeRepository({required this.dio});

  Future<Pledge> getPledges() async {
    try {
      var response = await dio.get("/pledge/user");
      return pledgeFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<PledgeType> getPledgeTypes() async {
    try {
      var response = await dio.get("/pledgetype");
      return pledgeTypeFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<PledgePurpose> getPledgePurposes() async {
    try {
      var response = await dio.get("/pledgepurposes");
      return pledgePurposeFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<bool> createPledge(
    PledgeForm form,
  ) async {
    Map<String, dynamic> data = {
      "name": form.name,
      "deadline": form.deadline,
      "description": form.description,
      "amount": form.amount,
      "type_id": form.type_id,
      "purpose_id": form.purpose_id,
    };

    try {
      await dio.post("/pledge", data: jsonEncode(data));
      return true;
    } on DioError catch (_) {
      //final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<bool> setReminder(int id, String date) async {
    Map<String, dynamic> data = {
      "pledge_id": id,
      "date": date,
    };

    try {
      await dio.post("/pledge/reminder", data: jsonEncode(data));
      return true;
    } on DioError catch (_) {
      // final errorMessage = DioExceptions.fromDioError(e).toString();
      return false;
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }
}
