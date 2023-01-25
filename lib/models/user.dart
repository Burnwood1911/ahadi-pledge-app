// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.id,
    required this.fname,
    required this.mname,
    required this.lname,
    required this.jumuiya,
    required this.phone,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
  });

  int id;
  String fname;
  String mname;
  String lname;
  int jumuiya;
  String phone;
  String email;
  DateTime dateOfBirth;
  String gender;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        fname: json["fname"],
        mname: json["mname"],
        lname: json["lname"],
        jumuiya: int.parse(json["jumuiya"]),
        phone: json["phone"],
        email: json["email"],
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fname": fname,
        "mname": mname,
        "lname": lname,
        "jumuiya": jumuiya,
        "phone": phone,
        "email": email,
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "gender": gender,
      };
}
