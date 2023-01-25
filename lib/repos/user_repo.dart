import 'dart:convert';
import 'dart:developer';
import 'package:ahadi_pledge/models/user.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/custom_error.dart';
import 'package:ahadi_pledge/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:easy_localization/easy_localization.dart';

class UserRepository {
  final DioClient dio;
  UserRepository({required this.dio});

  Future<Result<User, Failure>> fetchUser() async {
    try {
      var response = await dio.get("/user");

      if (response.statusCode == 200) {
        return Success(userFromJson(jsonEncode(response.data)));
      } else {
        return Error(Failure(
            message: response.statusMessage!,
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(Failure(
            message: LocaleKeys.no_connection_text.tr(), statusCode: 500));
      } else {
        return Error(Failure(
            message: LocaleKeys.something_went_wrong_text.tr(),
            statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(
          Failure(message: LocaleKeys.invalid_json_text.tr(), statusCode: 500));
    }
  }

  Future<Result<User, Failure>> updateUser(String fname, String mname,
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

      if (response.statusCode == 200) {
        return Success(userFromJson(jsonEncode(response.data)));
      } else {
        return Error(Failure(
            message: response.statusMessage!,
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(Failure(
            message: LocaleKeys.no_connection_text.tr(), statusCode: 500));
      } else {
        return Error(Failure(
            message: LocaleKeys.something_went_wrong_text.tr(),
            statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(
          Failure(message: LocaleKeys.invalid_json_text.tr(), statusCode: 500));
    }
  }

  Future<Result<bool, Failure>> addFcmToken(String token) async {
    Map<String, dynamic> data = {
      "fcm_token": token,
    };
    try {
      var response = await dio.post("/user/update", data: jsonEncode(data));

      if (response.statusCode == 200) {
        return const Success(true);
      } else {
        return Error(Failure(
            message: response.statusMessage!,
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(Failure(
            message: LocaleKeys.no_connection_text.tr(), statusCode: 500));
      } else {
        return Error(Failure(
            message: LocaleKeys.something_went_wrong_text.tr(),
            statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(
          Failure(message: LocaleKeys.invalid_json_text.tr(), statusCode: 500));
    }
  }

  Future<Result<bool, Failure>> changePassword(
      String oldPassword, String newPassword) async {
    Map<String, dynamic> data = {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
    };
    try {
      var response = await dio.post("/change-password", data: jsonEncode(data));

      if (response.statusCode == 200) {
        return const Success(true);
      } else {
        return Error(Failure(
            message: response.statusMessage!,
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(Failure(
            message: LocaleKeys.no_connection_text.tr(), statusCode: 500));
      } else {
        return Error(Failure(
            message:
                e.response?.data["error"].toString() ?? "Some error occured",
            statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(
          Failure(message: LocaleKeys.invalid_json_text.tr(), statusCode: 500));
    }
  }

  Future<Result<bool, Failure>> requestCard() async {
    try {
      var response = await dio.get("/request-card");

      if (response.statusCode == 200) {
        return const Success(true);
      } else {
        return Error(Failure(
            message: response.statusMessage!,
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(Failure(
            message: LocaleKeys.no_connection_text.tr(), statusCode: 500));
      } else {
        return Error(Failure(
            message:
                e.response?.data["error"].toString() ?? "Some error occured",
            statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(
          Failure(message: LocaleKeys.invalid_json_text.tr(), statusCode: 500));
    }
  }
}
