// To parse this JSON data, do
//
//     final subscription = subscriptionFromJson(jsonString);

import 'dart:convert';

Subscription subscriptionFromJson(String str) =>
    Subscription.fromJson(json.decode(str));

String subscriptionToJson(Subscription data) => json.encode(data.toJson());

class Subscription {
  Subscription({
    required this.subscriptions,
  });

  final List<SubscriptionElement> subscriptions;

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        subscriptions: List<SubscriptionElement>.from(
            json["subscriptions"].map((x) => SubscriptionElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "subscriptions":
            List<dynamic>.from(subscriptions.map((x) => x.toJson())),
      };
}

class SubscriptionElement {
  SubscriptionElement({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  factory SubscriptionElement.fromJson(Map<String, dynamic> json) =>
      SubscriptionElement(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
