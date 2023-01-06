import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Events",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
    );
  }
}
