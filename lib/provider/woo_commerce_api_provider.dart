import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/woo_commerce_api.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final wooCommerceAPIProvider = Provider<WooCommerceAPI>((ref) {
  final baseUrl = dotenv.env['WOO_COMMERCE_BASE_URL']!;
  final consumerKey = dotenv.env['WOO_COMMERCE_CONSUMER_KEY']!;
  final consumerSecret = dotenv.env['WOO_COMMERCE_CONSUMER_SECRET']!;

  return WooCommerceAPI(
    baseUrl: baseUrl,
    consumerKey: consumerKey,
    consumerSecret: consumerSecret,
  );
});
