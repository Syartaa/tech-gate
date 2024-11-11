import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/category.dart';
import 'package:tech_gate/provider/product_provider.dart';
import 'package:tech_gate/widgets/product/product.dart'; // Assuming ProductWidget is here

class CategoryProductsScreen extends ConsumerWidget {
  final Category category; // Pass the category object

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Use productByCategoryProvider to fetch products for this specific category
    final productAsyncValue =
        ref.watch(productByCategoryProvider(category.id.toString()));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(60), // Set custom height for AppBar
        child: AppBar(
          backgroundColor:
              Theme.of(context).colorScheme.primary, // AppBar color
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  category.name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ), // Display category name
              Image.asset(
                'assets/logo.png', // Add your logo image here
                height: 40,
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30), // Bottom border rounded
            ),
          ),
        ),
      ),
      body: productAsyncValue.when(
        data: (products) {
          return Column(
            children: [
              Container(
                margin:
                    const EdgeInsets.all(16.0), // Add margin around the image
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), // Set border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      15), // Ensure image fits border radius
                  child: Image.network(
                    category.imageUrl, // Use the category image
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10), // Add some spacing

              // Display the list of products in a GridView
              products.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 products per row
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio:
                              0.75, // Adjust the height-to-width ratio
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductWidget(
                            product: product,
                          ); // Use ProductWidget to display each product
                        },
                      ),
                    )
                  : const Expanded(
                      child: Center(
                        child: Text(
                          "No products available in this category",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
            ],
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()), // Loading spinner
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: $error',
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ), // Error message
      ),
    );
  }
}
