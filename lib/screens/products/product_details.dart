import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';
import 'package:tech_gate/screens/products/shop_card_screen.dart';

class ProductDetailsPage extends ConsumerWidget {
  final Product product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              Text(
                product.name,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ), // Display category name
            ],
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30), // Bottom border rounded
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image with "Not in Stock" overlay
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Center(
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.contain,
                        height: 250,
                      ),
                    ),
                  ),
                  if (!product.availability)
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          'Not in Stock',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Product Name
            Text(
              product.name,
              style: GoogleFonts.poppins(
                  fontSize: 28,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),

            // Product Price and Availability Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: product.availability ? Colors.green : Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    product.availability ? 'In Stock' : 'Out of Stock',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Brand and Model
            Row(
              children: [
                const Icon(Icons.branding_watermark, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  '${product.brand} - ${product.model}',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Release Date
            Row(
              children: [
                const Icon(Icons.calendar_today_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Released: ${product.releaseDate.toLocal().toString().split(' ')[0]}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Warranty Info
            Row(
              children: [
                const Icon(Icons.verified_user, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Warranty: ${product.warranty}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Divider
            const Divider(color: Colors.grey),

            // Product Description Section
            Text(
              'Product Description',
              style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              product.description,
              style: GoogleFonts.poppins(
                  fontSize: 16, height: 1.5, color: Colors.white),
            ),

            const SizedBox(height: 20),

            // Category Section
            Row(
              children: [
                const Icon(Icons.category_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Category: ${product.category.name}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Add to Cart Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: product.availability
                    ? () {
                        // Add to Cart Logic
                        ref.read(shopCardProvider.notifier).addProduct(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${product.name} added to cart!'),
                          ),
                        );
                      }
                    : null,
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ),
                label: Text(
                  'Add to Cart',
                  style: GoogleFonts.poppins(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFff3e3e),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
