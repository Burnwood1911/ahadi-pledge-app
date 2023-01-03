import 'dart:convert';

import 'package:ahadi_pledge/models/payment.dart';

import 'package:ahadi_pledge/network/dio_client.dart';
import 'package:dio/dio.dart';

class PaymentRepository {
  final DioClient dio;
  PaymentRepository({required this.dio});

  Future<Payment> getPayments() async {
    try {
      var response = await dio.get("/payment/user/2");
      return paymentFromJson(jsonEncode(response.data));
    } on DioError catch (e) {
      throw Exception({"error": e.message});
    } on TypeError catch (e) {
      throw Exception({"error": e.toString(), "stacktrace": e.stackTrace});
    }
  }
}
