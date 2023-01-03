// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Color.fromARGB(0, 20, 19, 19),
            centerTitle: true,
            title: Text(
              "Register",
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(color: Colors.black)),
            ),
          ),
          body: ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                "First Name",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Middle Name",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Last Name",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Date of Birth",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'DD/MM/YYYY',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Gender",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
                value: 'MALE',
                items: <String>['MALE', 'FEMAIL'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Jumuiya",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
                value: 'SINZA',
                items: <String>['SINZA', 'MWENGE', 'MAKUMBUSHO']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Email",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'example@gmail.com',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Password",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                "Phone",
                style: GoogleFonts.poppins(),
              ),
              SizedBox(
                height: 8,
              ),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '255xxxxxxxxx',
                ),
              ),
              SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: Expanded(
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black),
                        onPressed: (() {}),
                        child: Text("Register"))),
              )
            ],
          )),
    );
  }
}
