import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';

class ShopCardNotifier extends StateNotifier<List<Product>> {
  ShopCardNotifier() : super([]);

  void addProduct(Product product) {
    state = [...state, product];
  }

  void removeProduct(Product product) {
    state = state.where((p) => p.id != product.id).toList();
  }

  // Update Product Quantity
  void updateQuantity(Product product, int newQuantity) {
    state = state.map((item) {
      if (item.id == product.id) {
        return item.copyWith(quantity: newQuantity);
      }
      return item;
    }).toList();
  }
}

final shopCardProvider =
    StateNotifierProvider<ShopCardNotifier, List<Product>>((ref) {
  return ShopCardNotifier();
});
