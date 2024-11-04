import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/models/order.dart'; // Import your Order model
import 'package:tech_gate/provider/order_history_provider.dart'; // Import Order history provider

class TrackOrderScreen extends ConsumerWidget {
  const TrackOrderScreen({Key? key}) : super(key: key);

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
                "Tracking",
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
      backgroundColor: const Color(0xFF0A192F), // Dark background
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(
                'Current Order (${activeOrders.length})', Colors.white),
            const SizedBox(height: 10),
            if (activeOrders.isNotEmpty)
              _buildOrderList(activeOrders, isCurrentOrder: true)
            else
              const Center(
                child: Text(
                  'No active orders.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            const SizedBox(height: 30),
            _buildSectionTitle(
                'Previous Orders (${completedOrders.length})', Colors.white70),
            const SizedBox(height: 10),
            if (completedOrders.isNotEmpty)
              _buildOrderList(completedOrders, isCurrentOrder: false)
            else
              const Center(
                child: Text(
                  'No previous orders.',
                  style: TextStyle(color: Colors.white70),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders, {required bool isCurrentOrder}) {
    return Column(
      children: orders.map((order) {
        return Card(
          color: const Color(0xFF192A3A), // Dark card color
          margin: const EdgeInsets.only(bottom: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Order #${order.id}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                // Text(
                //   '${order.products.first.name}',
                //   style: const TextStyle(
                //     fontSize: 14,
                //     color: Colors.white70,
                //   ),
                // ),
                // const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: ${order.date.toLocal().toString().split(' ')[0]}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white70,
                      ),
                    ),
                    if (isCurrentOrder)
                      const Icon(
                        Icons.local_shipping,
                        color: Color(0xFF2E7D32), // Dark green icon
                        size: 24,
                      )
                    else
                      const Icon(
                        Icons.check_circle,
                        color: Color(0xFF4CAF50), // Green completed icon
                        size: 24,
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                _buildProgressBar(isCurrentOrder),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProgressBar(bool isCurrentOrder) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 5,
            decoration: BoxDecoration(
              color: isCurrentOrder
                  ? const Color(0xFF2E7D32)
                  : const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Icon(
          isCurrentOrder ? Icons.local_shipping : Icons.check_circle,
          color: isCurrentOrder
              ? const Color(0xFF2E7D32)
              : const Color(0xFF4CAF50),
        ),
      ],
    );
  }
}
