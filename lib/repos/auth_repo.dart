import 'dart:convert';
import 'dart:io';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/custom_error.dart';
import 'package:ahadi_pledge/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:easy_localization/easy_localization.dart';

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

  Future<Result<bool, Failure>> register(
      {required String fname,
      required String mname,
      required String lname,
      required String phone,
      required String email,
      required String password,
      required String selectedGender,
      required String birth,
      required int jumuiyaId,
      required int martialStatus,
      required int marriageType,
      required int occupationStatus,
      required bool canVolunterr,
      required bool baptized,
      required bool kipaimara,
      required bool sacramentiMezaYaBwana,
      required String placeOfBirth,
      required String marriageDate,
      required String partnerName,
      required String placeOfMarriage,
      required String oldUsharika,
      required String fellowshipName,
      required String neighborMsharikaName,
      required String neighborMsharikaPhone,
      required String deaconName,
      required String deaconPhone,
      required String placeOfWork,
      required String proffession,
      required String baptizationDate,
      required String kipaimaraDate,
      required List<int> selectedSubs}) async {
    Map<String, dynamic> data = {
      "fname": fname,
      "mname": mname,
      "lname": lname,
      "email": email,
      "phone": phone,
      "date_of_birth": birth,
      "gender": selectedGender,
      "jumuiya": jumuiyaId,
      "password": password,
      'place_of_birth': placeOfBirth,
      'martial_status': martialStatus + 1,
      'marriage_type': martialStatus == 0 ? marriageType + 1 : null,
      'marriage_date': marriageDate,
      'partner_name': partnerName,
      'place_of_marriage': placeOfMarriage,
      'old_usharika': oldUsharika,
      'fellowship_name': fellowshipName,
      'neighbour_msharika_name': neighborMsharikaName,
      'neighbour_msharika_phone': neighborMsharikaPhone,
      'deacon_name': deaconName,
      'deacon_phone': deaconPhone,
      'occupation': occupationStatus + 1,
      'place_of_work': placeOfWork,
      'proffession': proffession,
      'can_volunteer': canVolunterr,
      'baptized': baptized,
      'baptization_date': baptizationDate,
      'kipaimara': kipaimara,
      'kipaimara_date': kipaimaraDate,
      'sacramenti_meza_bwana': sacramentiMezaYaBwana,
      'selected_subs': selectedSubs
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
}
