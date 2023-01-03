// To parse this JSON data, do
//
//     final community = communityFromJson(jsonString);

import 'dart:convert';

Community communityFromJson(String str) => Community.fromJson(json.decode(str));

String communityToJson(Community data) => json.encode(data.toJson());

class Community {
  Community({
    required this.communities,
  });

  List<CommunityElement> communities;

  factory Community.fromJson(Map<String, dynamic> json) => Community(
        communities: List<CommunityElement>.from(
            json["communities"].map((x) => CommunityElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "communities": List<dynamic>.from(communities.map((x) => x.toJson())),
      };
}

class CommunityElement {
  CommunityElement({
    required this.id,
    required this.name,
    required this.location,
    required this.abbreviation,
  });

  int id;
  String name;
  String location;
  String abbreviation;

  factory CommunityElement.fromJson(Map<String, dynamic> json) =>
      CommunityElement(
        id: json["id"],
        name: json["name"],
        location: json["location"],
        abbreviation: json["abbreviation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "location": location,
        "abbreviation": abbreviation,
      };
}
