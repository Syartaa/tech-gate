import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/product.dart';
import 'package:tech_gate/provider/woo_commerce_api_provider.dart';

final productProvider = FutureProvider<List<Product>>((ref) async {
  // Get the WooCommerceAPI instance
  final api = ref.watch(wooCommerceAPIProvider);

  // Fetch the products from the API
  final response = await api.getProducts();

  // Map the JSON response to a list of Product objects
  return response.map<Product>((item) => Product.fromJson(item)).toList();
});

final productByCategoryProvider =
    FutureProvider.family<List<Product>, String>((ref, categoryId) async {
  final api = ref.watch(wooCommerceAPIProvider);

  // Directly return the list of products
  return await api.getProductsByCategory(categoryId);
});
