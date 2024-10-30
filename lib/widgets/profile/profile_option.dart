import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileOption extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ProfileOption({
    Key? key,
    required this.title,
    this.icon = Icons.account_circle_sharp,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 42,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
            ),
            const Spacer(),
            const Icon(
              Icons.arrow_forward_ios,
              //color: Colors.black,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
