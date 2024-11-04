// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class WooCommerceAPI {
//   final String baseUrl = dotenv.env['BASE_URL'] ?? "your_base_url";
//   final String consumerKey = dotenv.env['WOO_CONSUMER_KEY'] ?? "your_consumer_key";
//   final String consumerSecret = dotenv.env['WOO_CONSUMER_SECRET'] ?? "your_consumer_secret";

//   Future<List<dynamic>> getProducts() async {
//     final url = Uri.parse("$baseUrl/wp-json/wc/v3/products?consumer_key=$consumerKey&consumer_secret=$consumerSecret");

//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       return json.decode(response.body);
//     } else {
//       throw Exception("Failed to load products");
//     }
//   }
// }
