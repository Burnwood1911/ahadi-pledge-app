import 'dart:convert';
import 'package:ahadi_pledge/models/card_payment.dart' as card;
import 'package:ahadi_pledge/models/payment.dart';
import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:dio/dio.dart';

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

  Future<card.CardPayment> getCardPayments() async {
    try {
      var response = await dio.get("/cardpayments");
      return card.cardPaymentFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }

  Future<bool> submitPayment(
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
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      return false;
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }
}
