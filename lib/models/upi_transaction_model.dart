class UpiTransactionModel {
  final String id;
  final String userId;
  final String type; // 'send' or 'receive'
  final double amount;
  final String recipientUpiId;
  final String recipientName;
  final String? note;
  final String status; // 'pending', 'success', 'failed'
  final String transactionId;
  final DateTime createdAt;

  UpiTransactionModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.amount,
    required this.recipientUpiId,
    required this.recipientName,
    this.note,
    required this.status,
    required this.transactionId,
    required this.createdAt,
  });

  factory UpiTransactionModel.fromMap(Map<String, dynamic> map, String id) {
    return UpiTransactionModel(
      id: id,
      userId: map['userId'] ?? '',
      type: map['type'] ?? 'send',
      amount: (map['amount'] ?? 0).toDouble(),
      recipientUpiId: map['recipientUpiId'] ?? '',
      recipientName: map['recipientName'] ?? '',
      note: map['note'],
      status: map['status'] ?? 'pending',
      transactionId: map['transactionId'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'amount': amount,
      'recipientUpiId': recipientUpiId,
      'recipientName': recipientName,
      'note': note,
      'status': status,
      'transactionId': transactionId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
