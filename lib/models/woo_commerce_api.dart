// woo_commerce_api.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tech_gate/models/product.dart';

class WooCommerceAPI {
  final String baseUrl;
  final String consumerKey;
  final String consumerSecret;

  WooCommerceAPI({
    required this.baseUrl,
    required this.consumerKey,
    required this.consumerSecret,
  });

  Future<List<dynamic>> getProducts() async {
    final String url =
        '$baseUrl/wp-json/wc/v3/products?consumer_key=$consumerKey&consumer_secret=$consumerSecret';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<dynamic>> getCategories() async {
    final String url =
        '$baseUrl/wp-json/wc/v3/products/categories?consumer_key=$consumerKey&consumer_secret=$consumerSecret';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load categories');
    }
  }

  Future<List<Product>> getProductsByCategory(String categoryId) async {
    final url = Uri.parse(
        '$baseUrl/wp-json/wc/v3/products?category=$categoryId&consumer_key=$consumerKey&consumer_secret=$consumerSecret');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Parse each item as a Product
        final List<dynamic> productList = json.decode(response.body);
        return productList
            .map((data) => Product.fromJson(data as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load products: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load products');
    }
  }
}
