import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';

class FavoriteProductsNotifier extends StateNotifier<List<Product>> {
  FavoriteProductsNotifier() : super([]);

  bool toggleProductFavoriteStatus(Product product) {
    final productIsFavorite = state.contains(product);

    if (productIsFavorite) {
      state = state.where((p) => p.id != product.id).toList();
      return false;
    } else {
      state = [...state, product];
      return true;
    }
  }
}

final favoriteProductsProvider =
    StateNotifierProvider<FavoriteProductsNotifier, List<Product>>((ref) {
  return FavoriteProductsNotifier();
});
