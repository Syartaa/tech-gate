import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';
import 'package:tech_gate/screens/checkout_summary_page.dart';
import 'package:tech_gate/widgets/product/custom_text_field.dart';

class CheckOutPayment extends ConsumerStatefulWidget {
  const CheckOutPayment({super.key});

  @override
  ConsumerState<CheckOutPayment> createState() => _CheckOutPaymentState();
}

class _CheckOutPaymentState extends ConsumerState<CheckOutPayment> {
  String? selectedPaymentMethod;
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  final TextEditingController _paypalEmailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final basketProducts =
        ref.watch(shopCardProvider); // Select products from shopCardProvider
    final totalPrice = basketProducts.fold(
        0.0, (sum, item) => sum + item.price); // Calculate total price

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Check Out",
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
      body: ListView(
        padding: const EdgeInsets.all(10.0),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Payment method",
                style: GoogleFonts.poppins(
                    color: const Color.fromARGB(255, 245, 241, 241),
                    fontSize: 21),
              ),
              const SizedBox(height: 10),
              // Row of payment icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildPaymentIcon("Credit", Icons.credit_card, "Credit"),
                  _buildPaymentIcon("Cash", Icons.money, "Cash"),
                  _buildPaymentIcon("Paypal", Icons.payment, "Paypal"),
                ],
              ),
              const SizedBox(height: 20),
              // Render payment form based on selected payment method
              if (selectedPaymentMethod != null) _buildPaymentForm(),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => CheckoutSummaryPage(
                      selectedProducts:
                          basketProducts, // Use the basket products here
                      paymentMethod: selectedPaymentMethod ?? 'Unknown',
                      totalPrice: totalPrice, // Pass the calculated total price
                    ),
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
                'Vazhdo',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build each payment icon
  Widget _buildPaymentIcon(
      String label, IconData iconData, String paymentMethod) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = paymentMethod;
        });
      },
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: selectedPaymentMethod == paymentMethod
                ? Colors.orange
                : Colors.grey[300],
            child: Icon(iconData, color: Colors.white),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: selectedPaymentMethod == paymentMethod
                  ? Colors.orange
                  : const Color.fromARGB(255, 250, 248, 248),
            ),
          ),
        ],
      ),
    );
  }

  // Widget to build the specific form based on the selected payment method
  Widget _buildPaymentForm() {
    switch (selectedPaymentMethod) {
      case "Credit":
        return Column(
          children: [
            CustomTextField(
              labelText: "Card Number",
              controller: _cardNumberController,
            ),
            CustomTextField(
              labelText: "Expiry Date",
              controller: _expiryDateController,
            ),
            CustomTextField(
              labelText: "CVV",
              controller: _cvvController,
            ),
            CustomTextField(
              labelText: "Card Holder Name",
              controller: _nameController,
            ),
          ],
        );
      case "Cash":
        return Column(
          children: [
            CustomTextField(
              labelText: "Your Address",
              controller: _addressController,
            ),
            CustomTextField(
              labelText: "Additional Notes",
              controller: _notesController,
            ),
          ],
        );
      case "Paypal":
        return Column(
          children: [
            CustomTextField(
              labelText: "Paypal Email",
              controller: _paypalEmailController,
            ),
          ],
        );
      default:
        return Container();
    }
  }
}
