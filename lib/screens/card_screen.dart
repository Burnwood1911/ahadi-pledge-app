import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CardScreen extends StatelessWidget {
  const CardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          "Cards",
          style: GoogleFonts.poppins(
              textStyle: const TextStyle(color: Colors.black)),
        ),
        centerTitle: true,
      ),
    );
  }
}
