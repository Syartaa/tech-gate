import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/category.dart';
import 'package:tech_gate/provider/product_provider.dart';
import 'package:tech_gate/widgets/product/product.dart'; // Assuming ProductWidget is here

class CategoryProductsScreen extends ConsumerWidget {
  final Category category;

  const CategoryProductsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsyncValue =
        ref.watch(productByCategoryProvider(category.id.toString()));

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  category.name,
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                ),
              ),
              Image.asset(
                'assets/logo.png',
                height: 40,
              ),
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: productAsyncValue.when(
        data: (products) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    category.imageUrl.isNotEmpty
                        ? category.imageUrl
                        : 'assets/placeholder.png',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      return Image.asset('assets/placeholder.png');
                    },
                  ),
                ),
              ),
              const SizedBox(height: 10),
              products.isNotEmpty
                  ? Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8.0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.75,
                        ),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return ProductWidget(
                            product: product,
                          );
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
        loading: () => Column(
          children: [
            const SkeletonCategoryImage(), // New skeleton for category image
            const SizedBox(height: 10),
            const Expanded(child: ProductGridSkeletonLoader()), // Grid skeleton
          ],
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Error: $error',
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ),
      ),
    );
  }
}

// Skeleton loader for category image
class SkeletonCategoryImage extends StatelessWidget {
  const SkeletonCategoryImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(15),
      ),
    );
  }
}

// Skeleton loader for products grid
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
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
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
