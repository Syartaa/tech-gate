import 'package:flutter/material.dart';
import 'package:tech_gate/models/product.dart';

class ShopProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onRemove;
  final ValueChanged<int> onUpdateQuantity;

  const ShopProductCard({
    Key? key,
    required this.product,
    required this.onRemove,
    required this.onUpdateQuantity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.images[0],
              width: 80,
              height: 80,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const SizedBox(height: 4),
                Text(
                  '\$${product.price.toStringAsFixed(2)}',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
              ],
            ),
          ),
          _buildQuantityControl(),
        ],
      ),
    );
  }

  Widget _buildQuantityControl() {
    return Row(
      children: [
        IconButton(
          color: Colors.white,
          icon: const Icon(Icons.remove),
          onPressed: () {
            if (product.quantity > 1) {
              onUpdateQuantity(product.quantity - 1);
            }
          },
        ),
        Text(
          product.quantity.toString(),
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add),
          color: Colors.white,
          onPressed: () {
            onUpdateQuantity(product.quantity + 1);
          },
        ),
      ],
    );
  }
}
