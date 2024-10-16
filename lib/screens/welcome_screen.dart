// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/screens/login_screen.dart';
import 'package:tech_gate/screens/signup_screen.dart';
import 'package:tech_gate/widgets/welcome_slider.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const WelcomeSlider(),
            const SizedBox(height: 45),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Regjistrohu",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                //padding: const EdgeInsets.all(10),
              ).copyWith(
                backgroundColor:
                    WidgetStateProperty.resolveWith<Color>((states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Theme.of(context)
                        .colorScheme
                        .secondary; // Color when pressed
                  } else if (states.contains(WidgetState.hovered)) {
                    return Theme.of(context)
                        .colorScheme
                        .secondary; // Color when hovered
                  }
                  return Theme.of(context).colorScheme.primary; // Default color
                }),
              ),
            ),
            const SizedBox(height: 15),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  "Une kam nje llogari",
                  style: GoogleFonts.poppins(
                      fontSize: 15, fontWeight: FontWeight.w500),
                )),
          ],
        ),
      ),
    );
  }
}
