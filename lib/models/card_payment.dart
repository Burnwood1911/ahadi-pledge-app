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

  final List<Payment> payments;

  factory CardPayment.fromJson(Map<String, dynamic> json) => CardPayment(
        payments: List<Payment>.from(
            json["payments"].map((x) => Payment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "payments": List<dynamic>.from(payments.map((x) => x.toJson())),
      };
}

class Payment {
  Payment(
      {required this.id,
      required this.cardMember,
      required this.amount,
      required this.card,
      required this.formattedDate});

  final int id;
  final int cardMember;
  final int amount;
  final Card card;
  final String formattedDate;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        cardMember: int.tryParse(json["card_member"]) ?? json["card_member"],
        amount: int.tryParse(json["amount"]) ?? json["amount"],
        formattedDate: json["formattedDate"],
        card: Card.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "card_member": cardMember,
        "amount": amount,
        "formattedDate": formattedDate,
        "card": card.toJson(),
      };
}

class Card {
  Card({
    required this.id,
    required this.userId,
    required this.cardNo,
    required this.status,
  });

  final int id;
  final int userId;
  final int cardNo;
  final int status;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        id: json["id"],
        userId: int.tryParse(json["user_id"]) ?? json["user_id"],
        cardNo: int.tryParse(json["card_no"]) ?? json["card_no"],
        status: int.tryParse(json["status"]) ?? json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "card_no": cardNo,
        "status": status,
      };
}
