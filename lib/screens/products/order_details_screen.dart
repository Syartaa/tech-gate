import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/order.dart';

class OrderDetailsScreen extends StatelessWidget {
  final Order order;

  const OrderDetailsScreen({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
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
                'Order Details',
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
              ), // Display category name
              Image.asset(
                'assets/logo.png', // Add your logo image here
                height: 40,
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Date: ${order.date.toLocal()}',
              style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              'Status: ${order.status == OrderStatus.active ? 'Active' : 'Completed'}',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: order.status == OrderStatus.active
                    ? Colors.green
                    : Colors.grey,
              ),
            ),
            const Divider(height: 20, thickness: 2),
            Text(
              'Products:',
              style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: order.products.length,
                itemBuilder: (context, index) {
                  final product = order.products[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(8.0),
                    leading:
                        Icon(Icons.shopping_cart, color: Colors.blueAccent),
                    title: Text(
                      product.name,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                    subtitle: Text(
                      'Quantity: ${product.quantity}',
                      style: GoogleFonts.poppins(
                          color: const Color.fromARGB(178, 255, 255, 255)),
                    ),
                    trailing: Text(
                      '\$${product.price * product.quantity}',
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 30, 100, 54)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
