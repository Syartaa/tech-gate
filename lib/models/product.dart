class Product {
  final int id;
  final String name;
  final String slug;
  final String description;
  final double price;
  final List<String>
      images; // Changed from a single image URL to a list of image URLs
  final List<int> categoryIds;
  final int quantity;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.images, // Now expects a list of image URLs
    required this.categoryIds,
    this.quantity = 1,
  });

  // Convert a JSON object to a Product object
  factory Product.fromJson(Map<String, dynamic> json) {
    // Extract image URLs, assuming 'images' is a list of image objects
    List<String> imageUrls = [];
    if (json['images'] is List) {
      imageUrls = (json['images'] as List)
          .map((image) => image['src'] as String)
          .toList();
    }

    return Product(
      id: json['id'] as int,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      price: double.tryParse(json['price']?.toString() ?? '0') ?? 0.0,
      images: imageUrls, // Assign the image URLs list
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
      'images': images
          .map((imageUrl) => {'src': imageUrl})
          .toList(), // Convert list of images to JSON
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
      images: images, // Keep the existing images
      categoryIds: categoryIds,
      quantity: quantity ?? this.quantity,
    );
  }
}
