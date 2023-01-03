// To parse this JSON data, do
//
//     final pledgeType = pledgeTypeFromJson(jsonString);

import 'dart:convert';

PledgeType pledgeTypeFromJson(String str) =>
    PledgeType.fromJson(json.decode(str));

String pledgeTypeToJson(PledgeType data) => json.encode(data.toJson());

class PledgeType {
  PledgeType({
    this.types,
  });

  List<TypePledge>? types;

  factory PledgeType.fromJson(Map<String, dynamic> json) => PledgeType(
        types: List<TypePledge>.from(
            json["types"].map((x) => TypePledge.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "types": List<dynamic>.from(types!.map((x) => x.toJson())),
      };
}

class TypePledge {
  TypePledge({
    this.id,
    this.title,
  });

  int? id;
  String? title;

  factory TypePledge.fromJson(Map<String, dynamic> json) => TypePledge(
        id: json["id"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
      };
}
