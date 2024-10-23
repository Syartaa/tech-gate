import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/data/product_dummy_data.dart';

final productProvider = Provider((ref) {
  return dummyProducts;
});
