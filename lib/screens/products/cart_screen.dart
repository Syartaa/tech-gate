import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/category.dart';
import 'package:tech_gate/provider/category_provider.dart';
import 'package:tech_gate/provider/product_provider.dart';
import 'package:tech_gate/widgets/product/product.dart';
import 'package:tech_gate/widgets/product/product_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch product provider to get products
    final products = ref.watch(productProvider);
    final categories = ref.watch(categoryProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1B2B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Categories Section
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: categories.when(
                data: (categoryList) {
                  // Explicitly cast categoryList as List<Category>
                  final categoryListTyped = categoryList.cast<Category>();
                  return ProductCategoriesSlider(categories: categoryListTyped);
                },
                loading: () => const CircularProgressIndicator(),
                error: (error, stack) => Text('Error: $error'),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Produktet e fundit",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 22),
              ),
            ),

            // Product Grid Section
            products.when(
              data: (productList) {
                return GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    childAspectRatio: 0.75, // Control item height
                  ),
                  itemCount: productList.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(product: productList[index]);
                  },
                );
              },
              loading: () => const CircularProgressIndicator(),
              error: (error, stack) => Text('Error: $error'),
            ),

            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
