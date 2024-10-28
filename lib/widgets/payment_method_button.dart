import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentMethodButton extends StatelessWidget {
  final IconData? icon;
  final String? imagePath;
  final String label;
  final Color backgroundColor;

  const PaymentMethodButton({
    Key? key,
    this.icon,
    this.imagePath,
    required this.label,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: icon != null
              ? Icon(icon, color: Colors.white)
              : imagePath != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(35.0),
                      child: Image.asset(
                        imagePath!,
                        fit: BoxFit.fitHeight,
                      ),
                    )
                  : null,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }
}
