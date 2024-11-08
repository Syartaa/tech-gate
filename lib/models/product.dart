class Product {
  final int id;
  final String name;
  final String slug;
  final String description;
  final double price;
  final String imageUrl;
  final List<int> categoryIds;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryIds,
    this.quantity = 1,
  });

  // Convert a JSON object to a Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      imageUrl: (json['images'] as List).isNotEmpty
          ? json['images'][0]['src'] as String
          : '', // Default to empty string if no image
      categoryIds: (json['categories'] as List<dynamic>)
          .map((category) => category['id'] as int)
          .toList(),
    );
  }

  // Convert a Product object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'categoryIds': categoryIds,
      'quantity': quantity,
    };
  }

  // Copy constructor to create a new product with updated quantity
  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      name: name,
      slug: slug,
      description: description,
      price: price,
      imageUrl: imageUrl,
      categoryIds: categoryIds,
      quantity: quantity ?? this.quantity,
    );
  }
}
