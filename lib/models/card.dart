// To parse this JSON data, do
//
//     final card = cardFromJson(jsonString);

import 'dart:convert';

Card cardFromJson(String str) => Card.fromJson(json.decode(str));

String cardToJson(Card data) => json.encode(data.toJson());

class Card {
  Card({
    required this.cards,
  });

  final List<CardElement> cards;

  factory Card.fromJson(Map<String, dynamic> json) => Card(
        cards: List<CardElement>.from(
            json["cards"].map((x) => CardElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "cards": List<dynamic>.from(cards.map((x) => x.toJson())),
      };
}

class CardElement {
  CardElement({
    required this.id,
    required this.userId,
    required this.cardNo,
    required this.status,
    required this.card,
  });

  final int id;
  final int userId;
  final int cardNo;
  final int status;
  final CardCard card;

  factory CardElement.fromJson(Map<String, dynamic> json) => CardElement(
        id: json["id"],
        userId: int.tryParse(json["user_id"]) ?? json["user_id"],
        cardNo: int.tryParse(json["card_no"]) ?? json["card_no"],
        status: int.tryParse(json["status"]) ?? json["status"],
        card: CardCard.fromJson(json["card"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "card_no": cardNo,
        "status": status,
        "card": card.toJson(),
      };
}

class CardCard {
  CardCard({
    required this.id,
    required this.cardNo,
    required this.status,
  });

  final int id;
  final String cardNo;
  final int status;

  factory CardCard.fromJson(Map<String, dynamic> json) => CardCard(
        id: json["id"],
        cardNo: json["card_no"],
        status: int.tryParse(json["status"]) ?? json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "card_no": cardNo,
        "status": status,
      };
}
