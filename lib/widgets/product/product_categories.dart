import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductCategories extends StatefulWidget {
  String image;
  String name;
  ProductCategories({super.key, required this.image, required this.name});

  @override
  State<ProductCategories> createState() => _ProductCategoriesState();
}

class _ProductCategoriesState extends State<ProductCategories> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(10),
          width: 50,
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Image.asset(widget.image),
        ),
        Text(
          widget.name,
          style: GoogleFonts.poppins(color: Colors.white),
        )
      ],
    );
  }
}
