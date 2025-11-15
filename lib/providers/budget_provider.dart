import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/budget_model.dart';
import '../providers/auth_provider.dart';
import '../providers/transaction_provider.dart';

final currentMonthProvider = StateProvider<DateTime>((ref) => DateTime.now());

final budgetsProvider = StreamProvider<List<BudgetModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  final month = ref.watch(currentMonthProvider);
  
  if (user == null) return Stream.value([]);
  
  return ref.watch(firestoreServiceProvider).getBudgets(
    user.uid,
    month.month,
    month.year,
  );
});

final budgetProgressProvider = Provider.family<double, String>((ref, categoryId) {
  final budgets = ref.watch(budgetsProvider).value ?? [];
  final budget = budgets.where((b) => b.categoryId == categoryId).firstOrNull;
  
  if (budget == null) return 0.0;
  
  final month = ref.watch(currentMonthProvider);
  final transactions = ref.watch(transactionsProvider).value ?? [];
  
  final spent = transactions
      .where((t) =>
          t.categoryId == categoryId &&
          t.type == 'expense' &&
          t.date.year == month.year &&
          t.date.month == month.month)
      .fold(0.0, (sum, t) => sum + t.amount);
  
  return spent / budget.amount;
});
