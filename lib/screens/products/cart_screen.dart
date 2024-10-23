import 'package:flutter/material.dart';
import 'package:tech_gate/provider/product_provider.dart';
import 'package:tech_gate/widgets/product/product.dart';
import 'package:tech_gate/widgets/product/product_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch product provider to get dummy products
    final products = ref.watch(productProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0F1B2B),
      body: Column(
        children: [
          // Categories Section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ProductCategories(
                  image: 'assets/4.jpg',
                  name: 'IT',
                ),
                ProductCategories(
                  image: 'assets/4.jpg',
                  name: 'Phone',
                ),
                ProductCategories(
                  image: 'assets/4.jpg',
                  name: 'Elektro',
                ),
                ProductCategories(
                  image: 'assets/4.jpg',
                  name: 'Ftohje',
                ),
                ProductCategories(
                  image: 'assets/4.jpg',
                  name: 'Pajisje',
                ),
              ],
            ),
          ),

          // Product Grid Section
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 items per row
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 0.75, // Control item height
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductWidget(product: products[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}