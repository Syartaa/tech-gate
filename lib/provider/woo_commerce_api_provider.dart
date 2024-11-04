import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/woo_commerce_api.dart';

final wooCommerceApiProvider = Provider<WooCommerceAPI>((ref) {
  return WooCommerceAPI(
    baseUrl: "https://your-woocommerce-site.com",
    consumerKey: "your_consumer_key",
    consumerSecret: "your_consumer_secret",
  );
});
