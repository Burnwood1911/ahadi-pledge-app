// To parse this JSON data, do
//
//     final cardPayment = cardPaymentFromJson(jsonString);

import 'dart:convert';

CardPayment cardPaymentFromJson(String str) =>
    CardPayment.fromJson(json.decode(str));

String cardPaymentToJson(CardPayment data) => json.encode(data.toJson());

class CardPayment {
  CardPayment({
    required this.payments,
  });

  List<Payment> payments;

  factory CardPayment.fromJson(Map<String, dynamic> json) => CardPayment(
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Payment {
  Payment({
    required this.amount,
    required this.cardMember,
  });

  double amount;
  int cardMember;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        amount: json["amount"].toDouble(),
        cardMember: json["card_member"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "card_member": cardMember,
      };
}
