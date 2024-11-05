import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tech_gate/provider/favorite_product_provider.dart';
import 'package:tech_gate/widgets/product/favorite_product_card.dart';

class FavoriteProductScreen extends ConsumerWidget {
  const FavoriteProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoriteProductsProvider);

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
                  "Favorite",
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
        body: favoriteProducts.isEmpty
            ? Center(
                child: Text(
                  'No favorites yet!',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 18,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: favoriteProducts.length,
                itemBuilder: (context, index) {
                  final product = favoriteProducts[index];
                  return FavoriteProductCard(
                    product: product,
                  );
                }));
  }
}
