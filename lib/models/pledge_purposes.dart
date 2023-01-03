// To parse this JSON data, do
//
//     final pledgePurpose = pledgePurposeFromJson(jsonString);

import 'dart:convert';

PledgePurpose pledgePurposeFromJson(String str) =>
    PledgePurpose.fromJson(json.decode(str));

String pledgePurposeToJson(PledgePurpose data) => json.encode(data.toJson());

class PledgePurpose {
  PledgePurpose({
    this.purposes,
  });

  List<PurposePledge>? purposes;

  factory PledgePurpose.fromJson(Map<String, dynamic> json) => PledgePurpose(
        purposes: List<PurposePledge>.from(
            json["purposes"].map((x) => PurposePledge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "purposes": List<dynamic>.from(purposes!.map((x) => x.toJson())),
      };
}

class PurposePledge {
  PurposePledge({
    this.id,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
  });

  int? id;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;

  factory PurposePledge.fromJson(Map<String, dynamic> json) => PurposePledge(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
      };
}
