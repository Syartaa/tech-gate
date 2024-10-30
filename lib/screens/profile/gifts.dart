import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Gifts extends StatelessWidget {
  const Gifts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shperblime",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              Image.asset(
                'assets/logo.png', // Your logo image here
                height: 30,
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: Center(
        child: Text(
          "No gifts for you",
          style: GoogleFonts.poppins(color: Colors.white),
        ),
      ),
    );
  }
}
