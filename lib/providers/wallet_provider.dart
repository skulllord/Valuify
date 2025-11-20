import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/wallet_model.dart';
import '../models/upi_transaction_model.dart';
import '../services/wallet_service.dart';
import '../providers/auth_provider.dart';

final walletServiceProvider = Provider((ref) => WalletService());

final walletProvider = StreamProvider<WalletModel?>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value(null);
  
  return ref.watch(walletServiceProvider).getWallet(user.uid);
});

final upiTransactionsProvider = StreamProvider<List<UpiTransactionModel>>((ref) {
  final user = ref.watch(currentUserProvider);
  if (user == null) return Stream.value([]);
  
  return ref.watch(walletServiceProvider).getUpiTransactions(user.uid);
});
