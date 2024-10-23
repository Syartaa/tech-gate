import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum Category { telefona, laptop, smartwatch, tv }

class Product {
  final String id;
  final String name;
  final String description;
  final Category category;
  final double price;
  final String brand;
  final String model;
  final DateTime releaseDate;
  final String imageUrl;
  final String warranty;
  final bool availability;

  Product({
    required this.name,
    required this.description,
    required this.category,
    required this.price,
    required this.brand,
    required this.model,
    required this.releaseDate,
    required this.imageUrl,
    required this.warranty,
    required this.availability,
    String? id,
  }) : id = id ?? uuid.v4();
}
