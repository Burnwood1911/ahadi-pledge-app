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
      required this.createdBy,
      required this.card,
      required this.formattedDate});

  final int id;
  final int cardMember;
  final int amount;
  final int createdBy;
  final Card card;
  final String formattedDate;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        id: json["id"],
        cardMember: json["card_member"],
        amount: json["amount"],
        createdBy: json["created_by"],
        formattedDate: json["formattedDate"],
        card: Card.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "card_member": cardMember,
        "amount": amount,
        "created_by": createdBy,
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
        userId: json["user_id"],
        cardNo: json["card_no"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "card_no": cardNo,
        "status": status,
      };
}
