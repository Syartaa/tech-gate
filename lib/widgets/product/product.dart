import 'package:flutter/material.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/screens/products/product_details.dart';

class ProductWidget extends StatefulWidget {
  final Product product;

  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isHovering = false; // Track hover state
  bool isFavorite = false; // Track if product is favorited
  bool isInCart = false; // Track if product is added to cart

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Navigate to Product Details Page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                product: widget.product,
              ),
            ),
          );
        },
        onHover: (hovering) {
          setState(() => _isHovering = hovering);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            color: _isHovering ? Colors.red.shade100 : const Color(0xFF192a3a),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                spreadRadius: 3,
              ),
            ],
          ),
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            clipBehavior:
                Clip.none, // Allow icons to extend beyond the container
            children: [
              // Product Info Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        widget.product.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product Name
                  Text(
                    widget.product.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Product Brand
                  Text(
                    widget.product.brand,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),

                  // Product Price
                  Text(
                    '\$${widget.product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              // Favorite Icon - Positioned tightly at the top right
              Positioned(
                top: -10,
                right: -10,
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isFavorite = !isFavorite; // Toggle favorite state
                    });
                  },
                ),
              ),

              // Cart Icon - Positioned at the bottom right
              Positioned(
                bottom: 8,
                right: 8,
                child: IconButton(
                  icon: Icon(
                    isInCart
                        ? Icons.shopping_cart
                        : Icons.shopping_cart_outlined,
                    color: isInCart ? Colors.green : Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      isInCart = !isInCart; // Toggle cart state
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
