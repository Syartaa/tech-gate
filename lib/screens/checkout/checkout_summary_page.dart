import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';

class CheckoutSummaryPage extends ConsumerStatefulWidget {
  final List<Product> selectedProducts;
  final String paymentMethod;
  final double totalPrice;

  CheckoutSummaryPage({
    required this.selectedProducts,
    required this.paymentMethod,
    required this.totalPrice,
  });

  @override
  ConsumerState<CheckoutSummaryPage> createState() =>
      _CheckoutSummaryPageState();
}

class _CheckoutSummaryPageState extends ConsumerState<CheckoutSummaryPage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
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
            ...widget.selectedProducts.map((product) => ListTile(
                  title: Text(product.name,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white)),
                  subtitle: Text("\$${product.price.toStringAsFixed(2)}",
                      style: GoogleFonts.poppins(color: Colors.white)),
                )),
            const Divider(thickness: 2),
            const SizedBox(height: 10),
            Text(
              "Total Price: \$${widget.totalPrice.toStringAsFixed(2)}",
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "Payment Method: ${widget.paymentMethod}",
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoading = true;
                        });
                        await shopCardNotifier.checkout();
                        setState(() {
                          isLoading = false;
                        });
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
                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
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
