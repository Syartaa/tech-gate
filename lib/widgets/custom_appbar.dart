import 'package:flutter/material.dart';
import 'package:tech_gate/screens/products/favorite_product_screen.dart';
import 'package:tech_gate/screens/products/shop_card_screen.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showBasketIcon; // New parameter to control the icon visibility

  const CustomAppBar({super.key, this.showBasketIcon = false});

  @override
  Size get preferredSize => const Size.fromHeight(60.0); // Set the height

  @override
  Widget build(BuildContext context) {
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
            title: Center(
              child: Image.asset(
                'assets/logo.png', // Replace with your logo path
                height: 50,
                width: 100,
                fit: BoxFit.contain,
              ),
            ),
            actions: showBasketIcon
                ? [
                    IconButton(
                      icon: Icon(Icons.shopping_cart_outlined),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopCardScreen(),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite_outline),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FavoriteProductScreen(),
                          ),
                        );
                      },
                    ),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
