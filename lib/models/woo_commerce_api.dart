class WooCommerceAPI {
  final String baseUrl;
  final String consumerKey;
  final String consumerSecret;

  WooCommerceAPI({
    required this.baseUrl,
    required this.consumerKey,
    required this.consumerSecret,
  });

  // Future<List<dynamic>> getProducts() async {
  //   final url = Uri.parse("$baseUrl/wp-json/wc/v3/products?consumer_key=$consumerKey&consumer_secret=$consumerSecret");
  //   final response = await http.get(url);

  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception("Failed to load products");
  //   }
  // }
}
