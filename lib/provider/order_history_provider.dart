import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/models/order.dart';
import 'package:tech_gate/models/product.dart';

class OrderHistoryNotifier extends StateNotifier<List<Order>> {
  OrderHistoryNotifier() : super([]);

  //ADD ORDERS
  void addOrder(List<Product> products) {
    final newOrder = Order(
      date: DateTime.now(),
      products: products,
    );
    state = [...state, newOrder];
  }

  //order completed
  void markOrderAsCompleted(String id) {
    state = state.map((order) {
      if (order.id == id) {
        return Order(
          date: order.date,
          products: order.products,
          status: OrderStatus.completed,
        );
      }
      return order;
    }).toList();
  }

//active orders
  List<Order> get activeOrders =>
      state.where((order) => order.status == OrderStatus.active).toList();

  //completed orders
  List<Order> get completedOrders =>
      state.where((order) => order.status == OrderStatus.completed).toList();

  //check if there is an active order
  bool hasActiveOrder() {
    return state.any((order) => order.status == OrderStatus.active);
  }
}

final orderHistoryProvider =
    StateNotifierProvider<OrderHistoryNotifier, List<Order>>((ref) {
  return OrderHistoryNotifier();
});
