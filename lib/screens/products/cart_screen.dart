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
                  final categoryListTyped = categoryList.cast<Category>();
                  return ProductCategoriesSlider(categories: categoryListTyped);
                },
                loading: () => const CategorySkeletonLoader(),
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
                  physics: const NeverScrollableScrollPhysics(),
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
              loading: () => const ProductGridSkeletonLoader(),
              error: (error, stack) => Text('Error: $error'),
            ),

            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}

// Skeleton loader for categories
class CategorySkeletonLoader extends StatelessWidget {
  const CategorySkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 100,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),
      ),
    );
  }
}

// Skeleton loader for products
class ProductGridSkeletonLoader extends StatelessWidget {
  const ProductGridSkeletonLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 0.75,
      ),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 15,
                color: Colors.grey[700],
              ),
              const SizedBox(height: 4),
              Container(
                height: 15,
                width: 80,
                color: Colors.grey[700],
              ),
            ],
          ),
        );
      },
    );
  }
}
