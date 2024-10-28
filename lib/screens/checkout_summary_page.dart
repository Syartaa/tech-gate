import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';

class CheckoutSummaryPage extends ConsumerWidget {
  final List<Product> selectedProducts; // Change to a list of products
  final String paymentMethod;
  final double totalPrice;

  CheckoutSummaryPage({
    required this.selectedProducts,
    required this.paymentMethod,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shopCardNotifier = ref.watch(shopCardProvider.notifier);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order Summary",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ),
              Image.asset(
                'assets/logo.png', // Your logo image here
                height: 30,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Items in your order:",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            // Displaying the selected products
            ...selectedProducts.map((product) => ListTile(
                  title: Text(product.name,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white)),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(color: Colors.white)),
                )),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            Text(
              "Total Price: \$${totalPrice.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "Payment Method: $paymentMethod",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await shopCardNotifier.checkout(); // Perform checkout action
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Order Confirmed"),
                      content: Text("Thank you for your purchase!"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close dialog
                            Navigator.of(context).popUntil((route) => route
                                .isFirst); // Go back to the previous screen
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEC1D3B),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Confirm Order',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
