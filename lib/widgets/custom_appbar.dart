import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60.0); // Set the height here

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Container(
        color: Theme.of(context).colorScheme.primary, // Set your desired color
        child: AppBar(
          backgroundColor: Colors.transparent, // Transparent background
          elevation: 0, // Remove shadow
          title: const Text(''), // Optional title or leave empty
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Image.asset(
                'assets/logo.png', // Replace with your logo path
                height: 100, // Adjust height as needed
                width: 120, // Adjust width as needed
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
