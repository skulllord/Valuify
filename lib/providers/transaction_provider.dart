import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction_model.dart';
import '../providers/auth_provider.dart';

final transactionsProvider = StreamProvider<List<TransactionModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  
  return ref.watch(firestoreServiceProvider).getTransactions(user.uid);
});

final filteredTransactionsProvider = Provider.family<List<TransactionModel>, Map<String, dynamic>>((ref, filters) {
  final transactions = ref.watch(transactionsProvider).value ?? [];
  
  var filtered = transactions;
  
  // Filter by date range
  if (filters['startDate'] != null) {
    filtered = filtered.where((t) => t.date.isAfter(filters['startDate'])).toList();
  }
  if (filters['endDate'] != null) {
    filtered = filtered.where((t) => t.date.isBefore(filters['endDate'])).toList();
  }
  
  // Filter by category
  if (filters['categoryId'] != null) {
    filtered = filtered.where((t) => t.categoryId == filters['categoryId']).toList();
  }
  
  // Filter by type
  if (filters['type'] != null) {
    filtered = filtered.where((t) => t.type == filters['type']).toList();
  }
  
  return filtered;
});

final monthlyStatsProvider = Provider.family<Map<String, double>, DateTime>((ref, month) {
  final transactions = ref.watch(transactionsProvider).value ?? [];
  
  final monthTransactions = transactions.where((t) {
    return t.date.year == month.year && t.date.month == month.month;
  }).toList();
  
  final income = monthTransactions
      .where((t) => t.type == 'income')
      .fold(0.0, (sum, t) => sum + t.amount);
  
  final expense = monthTransactions
      .where((t) => t.type == 'expense')
      .fold(0.0, (sum, t) => sum + t.amount);
  
  return {
    'income': income,
    'expense': expense,
    'net': income - expense,
  };
});
