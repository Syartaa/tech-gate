import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/provider/favorite_product_provider.dart';
import 'package:tech_gate/screens/products/favorite_product_screen.dart';
import 'package:tech_gate/screens/products/shop_card_screen.dart';
import 'package:tech_gate/provider/shop_card_provider.dart'; // Import cart provider

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final bool showBasketIcon; // Control visibility of icons

  const CustomAppBar({super.key, this.showBasketIcon = false});

  @override
  Size get preferredSize => const Size.fromHeight(60.0); // AppBar height

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch the cart provider to get the total quantity of items in the cart
    final cartProducts = ref.watch(shopCardProvider);
    final cartItemCount = cartProducts.fold<int>(
      0,
      (previousValue, product) => previousValue + product.quantity,
    );

    // Watch the favorite provider to get the count of favorited products
    final favoriteProducts = ref.watch(favoriteProductsProvider);
    final favoriteItemCount = favoriteProducts.length;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(20.0),
        bottomRight: Radius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: const SizedBox.shrink(), // Remove back button
            title: Row(
              children: [
                if (showBasketIcon) const Spacer(), // Push logo towards center

                // Centered Logo
                Image.asset(
                  'assets/logo.png', // Replace with your logo path
                  height: 50,
                  width: 100,
                  fit: BoxFit.contain,
                ),

                if (showBasketIcon) const Spacer(), // Align icons properly

                // Icons only if showBasketIcon is true
                if (showBasketIcon)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Shopping Cart Icon with Badge
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.shopping_cart_outlined),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ShopCardScreen(),
                                ),
                              );
                            },
                          ),
                          if (cartItemCount > 0)
                            Positioned(
                              right: 3,
                              top: 2,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$cartItemCount',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),

                      // Favorite Icon with Badge
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.favorite_outline),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const FavoriteProductScreen(),
                                ),
                              );
                            },
                          ),
                          if (favoriteItemCount > 0)
                            Positioned(
                              right: 3,
                              top: 2,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  '$favoriteItemCount',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
