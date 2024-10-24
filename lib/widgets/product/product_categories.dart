import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/category.dart';
import 'package:tech_gate/screens/products/category_products_screen.dart'; // Import your Category model

class ProductCategories extends StatelessWidget {
  final Category
      category; // Accept a Category object instead of individual strings

  const ProductCategories({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryProductsScreen(
                  category: category,
                )));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              // borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Image.asset(
              category.thumbnailImage,
              fit: BoxFit.fitHeight,
            ), // Use the image from the Category model
          ),
          Text(
            category.categoryName.name, // Display the enum name as a string
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
