import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/provider/product.dart';

class ProductTest extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the productProvider to get product data
    final productsAsyncValue = ref.watch(productProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Products')),
      body: productsAsyncValue.when(
        data: (products) {
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              final productName = product['name'];
              final productPrice = product['price'];

              // Check if the product has images
              final productImageUrl =
                  (product['images'] != null && product['images'].isNotEmpty)
                      ? product['images'][0]['src']
                      : null; // Set to null if no images

              return ListTile(
                leading: productImageUrl != null
                    ? Image.network(
                        productImageUrl,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.error),
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : Center(child: CircularProgressIndicator());
                        },
                      )
                    : Icon(Icons
                        .image_not_supported), // Show placeholder if no image
                title: Text(
                  productName,
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
                subtitle: Text(
                  "\$${productPrice}",
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
