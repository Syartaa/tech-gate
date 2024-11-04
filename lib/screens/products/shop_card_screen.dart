import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/provider/order_history_provider.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';
import 'package:tech_gate/screens/delivery_details_screen.dart';
import 'package:tech_gate/screens/products/track_order_screen.dart';
import 'package:tech_gate/widgets/product/shop_product_card.dart';

class ShopCardScreen extends ConsumerWidget {
  const ShopCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopCardProducts = ref.watch(shopCardProvider);

    final hasActiveOrder = ref
        .read(orderHistoryProvider.notifier)
        .hasActiveOrder(); // Check active order

    double subtotal = shopCardProducts.fold(
        0, (sum, item) => sum + item.price * item.quantity);

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
                "Shopping Cart",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ), // Display category name
              Image.asset(
                'assets/logo.png', // Add your logo image here
                height: 30,
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
      body: Column(
        children: [
          if (hasActiveOrder) _buildTrackOrderBanner(context),
          Expanded(
            child: shopCardProducts.isEmpty
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
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        DeliveryDetailsScreen()));
                              },
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
          ),
        ],
      ),
    );
  }

  //track order banner
  Widget _buildTrackOrderBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "You have an active order!",
            style: GoogleFonts.poppins(
                fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TrackOrderScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: Text(
                "Track Order",
                style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ))
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
