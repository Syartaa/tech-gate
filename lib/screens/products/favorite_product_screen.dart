import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/favorite_product_provider.dart';
import 'package:tech_gate/widgets/product/favorite_product_card.dart';

class FavoriteProductScreen extends ConsumerWidget {
  const FavoriteProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteProducts = ref.watch(favoriteProductsProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("Favorite"),
          backgroundColor: Theme.of(context).colorScheme.primary,
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
