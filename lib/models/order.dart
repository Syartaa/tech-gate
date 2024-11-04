import 'package:tech_gate/models/product.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

enum OrderStatus { active, completed }

class Order {
  final String id;
  final DateTime date;
  final List<Product> products;
  OrderStatus status;

  Order({
    required this.date,
    required this.products,
    this.status = OrderStatus.active,
    String? id,
  }) : id = id ?? uuid.v4();

  // Method to mark order as completed
  void markAsCompleted() {
    status = OrderStatus.completed;
  }
}
