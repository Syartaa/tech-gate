class Category {
  final int id;
  final String name;
  final String slug;
  final String description;
  final String imageUrl;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.imageUrl,
  });

  // Convert a JSON object to a Category object
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      description: json['description'] ?? '',
      imageUrl:
          json['image']?['src'] ?? '', // Defaults to empty if image is null
    );
  }

  // Convert a Category object to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
