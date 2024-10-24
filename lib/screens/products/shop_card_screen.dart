import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';
import 'package:tech_gate/widgets/product/shop_product_card.dart';

class ShopCardScreen extends ConsumerWidget {
  const ShopCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopCardProducts = ref.watch(shopCardProvider);

    double subtotal = shopCardProducts.fold(
        0, (sum, item) => sum + item.price * item.quantity);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shopping Cart", style: GoogleFonts.poppins()),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
      ),
      body: shopCardProducts.isEmpty
          ? Center(
              child: Text(
                'No items in the cart!',
                style: GoogleFonts.poppins(
                  color: Color.fromARGB(137, 218, 213, 213),
                  fontSize: 18,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: shopCardProducts.length,
                    itemBuilder: (context, index) {
                      final product = shopCardProducts[index];
                      return ShopProductCard(
                        product: product,
                        onRemove: () {
                          ref
                              .read(shopCardProvider.notifier)
                              .removeProduct(product);
                        },
                        onUpdateQuantity: (newQuantity) {
                          ref
                              .read(shopCardProvider.notifier)
                              .updateQuantity(product, newQuantity);
                        },
                      );
                    },
                  ),
                ),
                _buildSubtotalSection(subtotal),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(
                          "Check out",
                          style: GoogleFonts.poppins(
                              fontSize: 18, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "Continue shopping",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
    );
  }

  Widget _buildSubtotalSection(double subtotal) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Subtotal",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          Text(
            '\$${subtotal.toStringAsFixed(2)}',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
