// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.id,
    this.fname,
    this.mname,
    this.lname,
    this.jumuiya,
    this.phone,
    this.profilePicture,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.role,
  });

  int? id;
  String? fname;
  String? mname;
  String? lname;
  int? jumuiya;
  String? phone;
  String? profilePicture;
  String? email;
  DateTime? dateOfBirth;
  String? gender;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? status;
  String? role;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fname: json["fname"],
        mname: json["mname"],
        lname: json["lname"],
        jumuiya: json["jumuiya"],
        phone: json["phone"],
        profilePicture: json["profile_picture"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        role: json["role"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "jumuiya": jumuiya,
        "phone": phone,
        "profile_picture": profilePicture,
        "email": email,
        "date_of_birth":
            "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "status": status,
        "role": role,
      };
}
