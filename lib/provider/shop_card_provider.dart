import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/order_history_provider.dart';

class ShopCardNotifier extends StateNotifier<List<Product>> {
  ShopCardNotifier() : super([]);

  //add
  void addProduct(Product product) {
    state = [...state, product];
  }

  //remove
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

  //checkout
  Future<void> checkout(WidgetRef ref) async {
    try {
      // Simulate an API call with a delay
      await Future.delayed(Duration(seconds: 2));

      // Add the current cart products to the order history
      ref.read(orderHistoryProvider.notifier).addOrder(state);

      // Log the current products in the basket for testing
      print('Checking out the following products:');
      for (var product in state) {
        print('Product ID: ${product.id}, Quantity: ${product.quantity}');
      }

      // Clear the basket after "checkout"
      state = [];
    } catch (error) {
      // Handle any potential errors here
      print('Checkout failed: $error');
    }
  }

  double calculateTotalPrice() {
    return state.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}

final shopCardProvider =
    StateNotifierProvider<ShopCardNotifier, List<Product>>((ref) {
  return ShopCardNotifier();
});
