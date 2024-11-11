import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/favorite_product_provider.dart';
import 'package:tech_gate/provider/shop_card_provider.dart';
import 'package:tech_gate/screens/products/product_details.dart';

class ProductWidget extends ConsumerStatefulWidget {
  final Product product;

  const ProductWidget({
    super.key,
    required this.product,
  });

  @override
  ConsumerState<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends ConsumerState<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    final favoriteProducts = ref.watch(favoriteProductsProvider);
    final shopCardProducts = ref.watch(shopCardProvider);

    final isFavorite = favoriteProducts.contains(widget.product);
    final isInCart =
        shopCardProducts.any((item) => item.id == widget.product.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsPage(
                product: widget.product,
              ),
            ),
          );
          print('Navigating to product details: ${widget.product.name}');
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: 160, // Set a fixed width
          decoration: BoxDecoration(
            color: const Color(0xFF192a3a),
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
            clipBehavior: Clip.none,
            children: [
              // Product Info Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        widget.product.imageUrl.isNotEmpty
                            ? widget.product.imageUrl
                            : 'assets/placeholder.png',
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Image.asset('assets/placeholder.png');
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Product Name with fixed height container
                  Container(
                    height: 40, // Fixed height for consistency
                    child: Text(
                      widget.product.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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

              // Favorite Icon - Positioned above the product card
              Positioned(
                top: -10,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: Icon(
                      isFavorite ? Icons.favorite : Icons.favorite_border,
                      color: isFavorite ? Colors.red : Colors.grey,
                    ),
                    onPressed: () {
                      ref
                          .read(favoriteProductsProvider.notifier)
                          .toggleProductFavoriteStatus(widget.product);
                    },
                  ),
                ),
              ),

              // Cart Icon - Positioned at the bottom right
              Positioned(
                bottom: 8,
                right: 8,
                child: Tooltip(
                  message: isInCart ? 'Remove from cart' : 'Add to cart',
                  child: IconButton(
                    icon: Icon(
                      isInCart
                          ? Icons.shopping_cart
                          : Icons.shopping_cart_outlined,
                      color: isInCart ? Colors.green : Colors.white,
                    ),
                    onPressed: () {
                      if (isInCart) {
                        ref
                            .read(shopCardProvider.notifier)
                            .removeProduct(widget.product);
                      } else {
                        ref
                            .read(shopCardProvider.notifier)
                            .addProduct(widget.product);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
