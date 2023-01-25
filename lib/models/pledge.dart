// To parse this JSON data, do
//
//     final pledge = pledgeFromJson(jsonString);

import 'dart:convert';

Pledge pledgeFromJson(String str) => Pledge.fromJson(json.decode(str));

String pledgeToJson(Pledge data) => json.encode(data.toJson());

class Pledge {
  Pledge({
    this.pledges,
  });

  List<PledgeElement>? pledges;

  factory Pledge.fromJson(Map<String, dynamic> json) => Pledge(
        pledges: List<PledgeElement>.from(
            json["pledges"].map((x) => PledgeElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "pledges": List<dynamic>.from(pledges!.map((x) => x.toJson())),
      };
}

class PledgeElement {
  PledgeElement({
    required this.id,
    required this.name,
    required this.description,
    required this.amount,
    required this.deadline,
    required this.status,
    required this.type,
    required this.purpose,
  });

  int id;
  String name;
  String description;
  String amount;
  DateTime deadline;
  int status;
  Type type;
  Purpose purpose;

  factory PledgeElement.fromJson(Map<String, dynamic> json) => PledgeElement(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        amount: json["amount"],
        deadline: DateTime.parse(json["deadline"]),
        status: int.parse(json["status"]),
        type: Type.fromJson(json["type"]),
        purpose: Purpose.fromJson(json["purpose"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "amount": amount,
        "deadline":
            "${deadline.year.toString().padLeft(4, '0')}-${deadline.month.toString().padLeft(2, '0')}-${deadline.day.toString().padLeft(2, '0')}",
        "status": status,
        "type": type.toJson(),
        "purpose": purpose.toJson(),
      };
}

class Purpose {
  Purpose({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.status,
  });

  int id;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  int status;

  factory Purpose.fromJson(Map<String, dynamic> json) => Purpose(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        status: int.parse(json["status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "start_date":
            "${startDate.year.toString().padLeft(4, '0')}-${startDate.month.toString().padLeft(2, '0')}-${startDate.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate.year.toString().padLeft(4, '0')}-${endDate.month.toString().padLeft(2, '0')}-${endDate.day.toString().padLeft(2, '0')}",
        "status": status,
      };
}

class Type {
  Type({
    required this.id,
    required this.title,
  });

  int id;
  String title;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
