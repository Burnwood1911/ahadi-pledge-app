import 'dart:convert';
import 'package:ahadi_pledge/models/payment.dart';
import 'package:ahadi_pledge/models/payment_methods.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:ahadi_pledge/translations/locale_keys.g.dart';
import 'package:ahadi_pledge/utils/custom_error.dart';
import 'package:ahadi_pledge/utils/extensions.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:easy_localization/easy_localization.dart';

class PaymentRepository {
  final DioClient dio;
  PaymentRepository({required this.dio});

  Future<Payment> getPayments() async {
    try {
      var response = await dio.get("/payment/user");
      return paymentFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<Result<List<PaymentMethod>, Failure>> getPaymentMethods() async {
    try {
      var response = await dio.get("/paymentmethod");
      return Success(
          paymentMethodsFromJson(jsonEncode(response.data['methods'])));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<Result<bool, Failure>> submitPayment(
      String amount, int typeId, int pledgeId, String receipt) async {
    Map<String, dynamic> data = {
      "type_id": typeId,
      "pledge_id": pledgeId,
      "amount": amount,
      "receipt": receipt
    };
    try {
      var response = await dio.post("/payment", data: jsonEncode(data));

      if (response.statusCode == 200) {
        return const Success(true);
      } else {
        return Error(Failure(
            message: LocaleKeys.amount_exceed_error_text.tr(),
            statusCode: response.statusCode!));
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return Error(Failure(
            message: LocaleKeys.no_connection_text.tr(), statusCode: 500));
      } else {
        return Error(Failure(
            message: LocaleKeys.amount_exceed_error_text.tr(),
            statusCode: 500));
      }
    } on TypeError catch (_) {
      return Error(
          Failure(message: LocaleKeys.invalid_json_text.tr(), statusCode: 500));
    }
  }
}
