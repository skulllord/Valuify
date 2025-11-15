import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/transaction_model.dart';
import '../models/category_model.dart';
import '../models/budget_model.dart';
import '../utils/constants.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // TRANSACTIONS
  Stream<List<TransactionModel>> getTransactions(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TransactionModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> addTransaction(String userId, TransactionModel transaction) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .add(transaction.toMap());
  }

  Future<void> updateTransaction(
    String userId,
    String transactionId,
    TransactionModel transaction,
  ) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transactionId)
        .update(transaction.toMap());
  }

  Future<void> deleteTransaction(String userId, String transactionId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('transactions')
        .doc(transactionId)
        .delete();
  }

  // CATEGORIES
  Stream<List<CategoryModel>> getCategories(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CategoryModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> initializeDefaultCategories(String userId) async {
    final categoriesRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('categories');

    final snapshot = await categoriesRef.limit(1).get();
    if (snapshot.docs.isEmpty) {
      for (var category in AppConstants.defaultCategories) {
        await categoriesRef.add({
          'userId': userId,
          'name': category['name'],
          'icon': category['icon'],
          'colorValue': category['color'],
          'type': category['type'],
          'isDefault': true,
        });
      }
    }
  }

  Future<void> addCategory(String userId, CategoryModel category) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .add(category.toMap());
  }

  Future<void> updateCategory(
    String userId,
    String categoryId,
    CategoryModel category,
  ) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .update(category.toMap());
  }

  Future<void> deleteCategory(String userId, String categoryId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('categories')
        .doc(categoryId)
        .delete();
  }

  // BUDGETS
  Stream<List<BudgetModel>> getBudgets(String userId, int month, int year) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('budgets')
        .where('month', isEqualTo: month)
        .where('year', isEqualTo: year)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => BudgetModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  Future<void> setBudget(String userId, BudgetModel budget) async {
    final budgetsRef = _firestore
        .collection('users')
        .doc(userId)
        .collection('budgets');

    final existing = await budgetsRef
        .where('categoryId', isEqualTo: budget.categoryId)
        .where('month', isEqualTo: budget.month)
        .where('year', isEqualTo: budget.year)
        .get();

    if (existing.docs.isNotEmpty) {
      await budgetsRef.doc(existing.docs.first.id).update(budget.toMap());
    } else {
      await budgetsRef.add(budget.toMap());
    }
  }

  Future<void> deleteBudget(String userId, String budgetId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('budgets')
        .doc(budgetId)
        .delete();
  }

  // SETTINGS
  Stream<Map<String, dynamic>> getSettings(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('preferences')
        .snapshots()
        .map((doc) => doc.data() ?? {});
  }

  Future<void> updateSettings(
    String userId,
    Map<String, dynamic> settings,
  ) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('preferences')
        .update(settings);
  }
}
