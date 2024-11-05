import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/order.dart';
import 'package:tech_gate/provider/order_history_provider.dart';
import 'package:tech_gate/screens/products/order_details_screen.dart';

class OrderHistoryScreen extends ConsumerWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeOrders = ref
        .read(orderHistoryProvider.notifier)
        .activeOrders; // Get active orders
    final completedOrders = ref
        .read(orderHistoryProvider.notifier)
        .completedOrders; // Get completed orders

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
                'Order History',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Active Orders',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            activeOrders.isEmpty
                ? Center(
                    child: Text(
                    'No active orders.',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: activeOrders.length,
                    itemBuilder: (context, index) {
                      final order = activeOrders[index];
                      return _buildOrderCard(order, context, ref);
                    },
                  ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Completed Orders',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            completedOrders.isEmpty
                ? Center(
                    child: Text(
                    'No completed orders.',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: completedOrders.length,
                    itemBuilder: (context, index) {
                      final order = completedOrders[index];
                      return _buildOrderCard(order, context, ref);
                    },
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderCard(Order order, BuildContext context, WidgetRef ref) {
    return Card(
      color: const Color.fromARGB(211, 179, 180, 231),
      margin: const EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(
          'Order #${order.id}',
          style: GoogleFonts.poppins(),
        ),
        subtitle: Text(
          'Date: ${order.date.toLocal()}',
          style: GoogleFonts.poppins(fontSize: 12),
        ),
        trailing: order.status == OrderStatus.active
            ? ElevatedButton(
                onPressed: () {
                  ref
                      .read(orderHistoryProvider.notifier)
                      .markOrderAsCompleted(order.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Order marked as completed.')),
                  );
                },
                child: const Text('Mark as Completed'),
              )
            : const Text('Completed'),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OrderDetailsScreen(order: order),
            ),
          );
        },
      ),
    );
  }
}
