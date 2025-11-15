import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category_model.dart';
import '../providers/auth_provider.dart';

final categoriesProvider = StreamProvider<List<CategoryModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  
  return ref.watch(firestoreServiceProvider).getCategories(user.uid);
});

final expenseCategoriesProvider = Provider<List<CategoryModel>>((ref) {
  final categories = ref.watch(categoriesProvider).value ?? [];
  return categories.where((c) => c.type == 'expense').toList();
});

final incomeCategoriesProvider = Provider<List<CategoryModel>>((ref) {
  final categories = ref.watch(categoriesProvider).value ?? [];
  return categories.where((c) => c.type == 'income').toList();
});

final categoryMapProvider = Provider<Map<String, CategoryModel>>((ref) {
  final categories = ref.watch(categoriesProvider).value ?? [];
  return {for (var c in categories) c.id: c};
});
