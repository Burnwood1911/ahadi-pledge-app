// To parse this JSON data, do
//
//     final paymentMethod = paymentMethodsFromJson(jsonString);

import 'dart:convert';

List<PaymentMethod> paymentMethodsFromJson(String str) =>
    List<PaymentMethod>.from(
        json.decode(str).map((x) => PaymentMethod.fromJson(x)));

String paymentMethodsToJson(List<PaymentMethod> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentMethod {
  PaymentMethod({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory PaymentMethod.fromJson(Map<String, dynamic> json) => PaymentMethod(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
