import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tech_gate/data/category_dummy_data.dart';

final categoryProvider = Provider((ref) {
  return dummyCategories;
});
