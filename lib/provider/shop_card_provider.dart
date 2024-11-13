import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/models/woo_commerce_api.dart';
import 'package:tech_gate/provider/order_history_provider.dart';

class ShopCardNotifier extends StateNotifier<List<Product>> {
  final WooCommerceAPI wooCommerceAPI;

  ShopCardNotifier({required this.wooCommerceAPI}) : super([]) {
    _loadCart();
  }

  // Load cart from WooCommerce
  Future<void> _loadCart() async {
    try {
      final cartItems = await wooCommerceAPI.getCartItems();
      state = cartItems
          .map((data) => Product.fromJson(data as Map<String, dynamic>))
          .toList();
    } catch (error) {
      print('Failed to load cart: $error');
    }
  }

  //add
  void addProduct(Product product) async {
    try {
      await wooCommerceAPI.addToCart(product.id, product.quantity);
      state = [...state, product];
    } catch (e) {
      print('Failed to add product to cart: $e');
    }
  }

  //remove
  void removeProduct(Product product) async {
    try {
      await wooCommerceAPI.removeFromCart(product.id);
      state = state.where((p) => p.id != product.id).toList();
    } catch (e) {
      print('Failed to remove product from cart: $e');
    }
  }

  // Update Product Quantity
  void updateQuantity(Product product, int newQuantity) async {
    try {
      await wooCommerceAPI.addToCart(product.id, newQuantity);
      state = state.map((item) {
        if (item.id == product.id) {
          return item.copyWith(quantity: newQuantity);
        }
        return item;
      }).toList();
    } catch (e) {
      print('Failed to update product quantity: $e');
    }
  }

  // Checkout cart
  Future<void> checkout(WidgetRef ref) async {
    try {
      await wooCommerceAPI.checkout();
      ref.read(orderHistoryProvider.notifier).addOrder(state);
      state = []; // Clear cart after checkout
    } catch (error) {
      print('Checkout failed: $error');
    }
  }

  double calculateTotalPrice() {
    return state.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}

final shopCardProvider =
    StateNotifierProvider<ShopCardNotifier, List<Product>>((ref) {
  final baseUrl = dotenv.env['WOO_COMMERCE_BASE_URL']!;
  final consumerKey = dotenv.env['WOO_COMMERCE_CONSUMER_KEY']!;
  final consumerSecret = dotenv.env['WOO_COMMERCE_CONSUMER_SECRET']!;

  final wooCommerceAPI = WooCommerceAPI(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
  );
  return ShopCardNotifier(wooCommerceAPI: wooCommerceAPI);
});
