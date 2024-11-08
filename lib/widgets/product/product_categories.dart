import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/category.dart';
import 'package:tech_gate/screens/products/category_products_screen.dart';

class ProductCategoriesSlider extends StatelessWidget {
  final List<Category> categories;

  const ProductCategoriesSlider({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, // Adjust as needed for the slider height
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          final imageUrl = category.imageUrl;

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) =>
                      CategoryProductsScreen(category: category),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8.0),
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: imageUrl.isNotEmpty
                      ? ClipOval(
                          child: Image.network(
                            imageUrl,
                            fit: BoxFit.cover,
                            width: 70,
                            height: 70,
                          ),
                        )
                      : Icon(Icons.category, size: 40),
                ),
                const SizedBox(height: 4),
                Container(
                  width: 70, // Limit the width for the category text
                  child: Text(
                    category.name,
                    style:
                        GoogleFonts.poppins(fontSize: 12, color: Colors.white),
                    maxLines: 2, // Allow two lines
                    overflow: TextOverflow.ellipsis, // Ellipsis for long text
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
