import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/category.dart';
import 'package:tech_gate/provider/woo_commerce_api_provider.dart';

final categoryProvider = FutureProvider<List<dynamic>>((ref) async {
  // Get the WooCommerceAPI instance
  final api = ref.watch(wooCommerceAPIProvider);
  final categoriesData =
      await api.getCategories(); // Get the categories data from the API

  return categoriesData
      .map<Category>((categoryJson) => Category.fromJson(categoryJson))
      .toList();
});
