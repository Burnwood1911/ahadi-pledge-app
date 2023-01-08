// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    required this.payments,
  });

  List<PaymentElement> payments;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        payments: List<PaymentElement>.from(
            json["payments"].map((x) => PaymentElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class PaymentElement {
  PaymentElement(
      {required this.id,
      required this.userId,
      required this.typeId,
      required this.pledgeId,
      required this.amount,
      required this.verified,
      required this.createdAt});

  int id;
  int userId;
  int typeId;
  int pledgeId;
  String amount;
  bool verified;
  DateTime createdAt;

  factory PaymentElement.fromJson(Map<String, dynamic> json) => PaymentElement(
        id: json["id"],
        userId: json["user_id"],
        typeId: json["type_id"],
        pledgeId: json["pledge_id"],
        amount: json["amount"],
        verified: json["verified"] == 1,
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "type_id": typeId,
        "pledge_id": pledgeId,
        "amount": amount,
        "verified": verified,
        "created_at": createdAt.toIso8601String(),
      };
}
