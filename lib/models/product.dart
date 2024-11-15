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
  final String brand;
  final String color;
  final String capacity;

  Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.price,
    required this.images, // Now expects a list of image URLs
    required this.categoryIds,
    required this.brand,
    required this.color,
    required this.capacity,
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
    // Extract attributes for brand and color
    String brand = '';
    String color = '';
    String capacity = '';
    if (json['attributes'] is List) {
      for (var attribute in json['attributes']) {
        if (attribute['name'] == 'Brand' && attribute['options'] is List) {
          brand = attribute['options'].isNotEmpty
              ? attribute['options'][0]
              : ''; // Assuming options array has the value for brand
        } else if (attribute['name'] == 'Color' &&
            attribute['options'] is List) {
          color = attribute['options'].isNotEmpty
              ? attribute['options'][0]
              : ''; // Assuming options array has the value for color
        } else if (attribute['name'] == 'Capacity' &&
            attribute['options'] is List) {
          color = attribute['options'].isNotEmpty
              ? attribute['options'][0]
              : ''; // Assuming options array has the value for color
        }
      }
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
      brand: brand,
      color: color,
      capacity: capacity,
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
      'brand': brand, // Include the brand field in the JSON
      'color': color, // Include the color field in the JSON
      'capacity': capacity, // Include the capacity field in the JSON
      'attributes': [
        // Construct the attributes array based on brand, color, and capacity
        {
          'id': 18, // Assuming the ID for Brand
          'name': 'Brand',
          'slug': 'pa_brand',
          'position': 0,
          'visible': true,
          'variation': false,
          'options': [brand], // Add brand to options
        },
        {
          'id': 19, // Assuming the ID for Color
          'name': 'Color',
          'slug': 'pa_color',
          'position': 0,
          'visible': true,
          'variation': false,
          'options': [color], // Add color to options
        },
        {
          'id': 20, // Assuming the ID for Capacity
          'name': 'Capacity',
          'slug': 'pa_capacity',
          'position': 0,
          'visible': true,
          'variation': false,
          'options': [capacity], // Add capacity to options
        },
      ],
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
        brand: brand,
        color: color,
        capacity: capacity);
  }
}
