import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';

class ProductDetailsPage extends ConsumerWidget {
  final Product product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // State to keep track of the selected image
    final selectedImage = ValueNotifier<String>(product.imageUrl);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(60), // Set custom height for AppBar
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Text(
            product.name,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
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
            // Display the selected image
            Center(
              child: ValueListenableBuilder<String>(
                valueListenable: selectedImage,
                builder: (context, imageUrl, _) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.contain,
                          height: 250,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              );
                            }
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset('assets/placeholder.png',
                                height: 250); // Placeholder
                          },
                        ),
                      ),

                      // if (!product.availability)
                      //   Container(
                      //     height: 250,
                      //     decoration: BoxDecoration(
                      //       color: Colors.black.withOpacity(0.5),
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     child: Center(
                      //       child: Text(
                      //         'Not in Stock',
                      //         style: GoogleFonts.poppins(
                      //           color: Colors.white,
                      //           fontSize: 24,
                      //           fontWeight: FontWeight.bold,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Display additional images as thumbnails
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     // Primary image thumbnail
            //     GestureDetector(
            //       onTap: () => selectedImage.value = product.imageUrl,
            //       child: Image.network(
            //         product.imageUrl,
            //         width: 60,
            //         height: 60,
            //         fit: BoxFit.cover,
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     // Additional images thumbnails
            //     ...product.imageUrl.map((image) => GestureDetector(
            //           onTap: () => selectedImage.value = image,
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 4.0),
            //             child: ClipRRect(
            //               borderRadius: BorderRadius.circular(8),
            //               child: Image.asset(
            //                 image,
            //                 width: 60,
            //                 height: 60,
            //                 fit: BoxFit.cover,
            //               ),
            //             ),
            //           ),
            //         )),
            //   ],
            // ),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'In Stock',
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

            const SizedBox(height: 10),

            // Release Date
            // Row(
            //   children: [
            //     const Icon(Icons.calendar_today_outlined, color: Colors.grey),
            //     const SizedBox(width: 8),
            //     Text(
            //       'Released: ${product.releaseDate.toLocal().toString().split(' ')[0]}',
            //       style: GoogleFonts.poppins(
            //         fontSize: 16,
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ],
            // ),
            const SizedBox(height: 10),

            // Warranty Info
            // Row(
            //   children: [
            //     const Icon(Icons.verified_user, color: Colors.grey),
            //     const SizedBox(width: 8),
            //     Text(
            //       'Warranty: ${product.warranty}',
            //       style: GoogleFonts.poppins(
            //         fontSize: 16,
            //         color: Colors.grey,
            //       ),
            //     ),
            //   ],
            // ),
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
            // Text(
            //   product.description,
            //   style: GoogleFonts.poppins(
            //       fontSize: 16, height: 1.5, color: Colors.white),
            // ),
            HtmlWidget(
              product.description,
              textStyle: TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 20),

            // Category Section
            Row(
              children: [
                const Icon(Icons.category_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  'Category: ${product.categoryIds}',
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
                onPressed: () {
                  // Add to Cart Logic
                  ref.read(shopCardProvider.notifier).addProduct(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product.name} added to cart!'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
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
