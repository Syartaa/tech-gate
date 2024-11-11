import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';

class FavoriteProductsNotifier extends StateNotifier<List<Product>> {
  FavoriteProductsNotifier() : super([]);

  bool toggleProductFavoriteStatus(Product product) {
    final productIsFavorite = state.any((p) => p.id == product.id);

    if (productIsFavorite) {
      // Create a new list excluding the removed product
      state = List.from(state)..removeWhere((p) => p.id == product.id);
      return false;
    } else {
      // Add the product if not already in the list
      state = List.from(state)..add(product);
      return true;
    }
  }
}

final favoriteProductsProvider =
    StateNotifierProvider<FavoriteProductsNotifier, List<Product>>((ref) {
  return FavoriteProductsNotifier();
});
