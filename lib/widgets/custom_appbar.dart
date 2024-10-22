import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tech_gate/screens/welcome_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60.0); // Set the height

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary, // Set desired color
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Subtle shadow effect
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: SafeArea(
          bottom: false, // Avoid adding unnecessary padding to the bottom
          child: AppBar(
            backgroundColor: Colors.transparent, // Transparent background
            elevation: 0, // Remove shadow
            title: Center(
              child: Image.asset(
                'assets/logo.png', // Replace with your logo path
                height: 50, // Adjust height to fit nicely
                width: 100, // Adjust width as needed
                fit: BoxFit.contain,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout), // Logout icon
                tooltip: 'Logout',
                onPressed: () async {
                  // Logout logic using Firebase Auth
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => WelcomeScreen()));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
