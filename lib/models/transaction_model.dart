class TransactionModel {
  final String id;
  final String userId;
  final double amount;
  final String type; // 'income' or 'expense'
  final String categoryId;
  final DateTime date;
  final String? merchant;
  final String? notes;
  final String? receiptUrl;
  final DateTime createdAt;

  TransactionModel({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.date,
    this.merchant,
    this.notes,
    this.receiptUrl,
    required this.createdAt,
  });

  factory TransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return TransactionModel(
      id: id,
      userId: map['userId'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      type: map['type'] ?? 'expense',
      categoryId: map['categoryId'] ?? '',
      date: DateTime.parse(map['date']),
      merchant: map['merchant'],
      notes: map['notes'],
      receiptUrl: map['receiptUrl'],
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'amount': amount,
      'type': type,
      'categoryId': categoryId,
      'date': date.toIso8601String(),
      'merchant': merchant,
      'notes': notes,
      'receiptUrl': receiptUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  TransactionModel copyWith({
    String? id,
    String? userId,
    double? amount,
    String? type,
    String? categoryId,
    DateTime? date,
    String? merchant,
    String? notes,
    String? receiptUrl,
    DateTime? createdAt,
  }) {
    return TransactionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      date: date ?? this.date,
      merchant: merchant ?? this.merchant,
      notes: notes ?? this.notes,
      receiptUrl: receiptUrl ?? this.receiptUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
