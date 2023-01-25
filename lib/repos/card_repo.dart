import 'dart:convert';
import 'dart:developer';
import 'package:ahadi_pledge/models/card.dart' as card;
import 'package:ahadi_pledge/models/card_payment.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/custom_error.dart';
import 'package:ahadi_pledge/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:easy_localization/easy_localization.dart';

class CardRepository {
  final DioClient dio;
  CardRepository({required this.dio});

  Future<Result<card.Card, Failure>> getCards() async {
    try {
      final response = await dio.get('/cards');

      if (response.statusCode == 200) {
        return Success(card.cardFromJson(jsonEncode(response.data)));
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

  Future<Result<CardPayment, Failure>> getCardPayments(int cardId) async {
    Map<String, dynamic> data = {
      "card_id": cardId,
    };

    try {
      var response = await dio.post("/card-payments", data: jsonEncode(data));
      if (response.statusCode == 200) {
        return Success(cardPaymentFromJson(jsonEncode(response.data)));
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
    } on TypeError catch (e) {
      log(e.stackTrace.toString());

      return Error(
          Failure(message: LocaleKeys.invalid_json_text.tr(), statusCode: 500));
    }
  }
}
