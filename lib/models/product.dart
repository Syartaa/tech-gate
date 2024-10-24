import 'package:tech_gate/models/category.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Product {
  final String id;
  final String name;
  final String description;
  final CategoryName category;
  final double price;
  final String brand;
  final String model;
  final DateTime releaseDate;
  final String imageUrl;
  final String warranty;
  final bool availability;
  final String color;
  int quantity;

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
    required this.color,
    this.quantity = 1,
    String? id,
  }) : id = id ?? uuid.v4();

  // Create a copyWith method for immutability
  Product copyWith({int? quantity}) {
    return Product(
      id: id,
      name: name,
      imageUrl: imageUrl,
      price: price,
      color: color,
      quantity: quantity ?? this.quantity,
      description: description,
      category: category,
      brand: brand,
      model: model,
      releaseDate: releaseDate,
      warranty: warranty,
      availability: availability,
    );
  }
}
