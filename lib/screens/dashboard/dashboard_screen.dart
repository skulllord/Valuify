import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';
import '../../providers/transaction_provider.dart';
import '../../providers/category_provider.dart';
import '../../widgets/balance_card.dart';
import '../../widgets/transaction_item.dart';
import '../../widgets/chart_widgets.dart';
import '../../utils/helpers.dart';
import '../../utils/constants.dart';
import '../transactions/add_transaction_screen.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final transactionsAsync = ref.watch(transactionsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final currentMonth = DateTime.now();
    final stats = ref.watch(monthlyStatsProvider(currentMonth));

    return Scaffold(
      body: SafeArea(
        child: transactionsAsync.when(
          data: (transactions) {
            final recentTransactions = transactions.take(5).toList();
            final balance = stats['net'] ?? 0.0;

            // Calculate 3-month trend
            final months = List.generate(3, (i) {
              final month = DateTime(currentMonth.year, currentMonth.month - (2 - i));
              return month;
            });

            final trendData = months.map((month) {
              final monthStats = ref.watch(monthlyStatsProvider(month));
              return monthStats['net'] ?? 0.0;
            }).toList();

            final trendLabels = months.map((m) => Helpers.getMonthYear(m)).toList();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Helpers.getGreeting(),
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                        Text(
                          user?.displayName ?? user?.email ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacing24),
                        BalanceCard(
                          balance: balance,
                          currencySymbol: '\$',
                        ),
                        const SizedBox(height: AppConstants.spacing24),
                        Row(
                          children: [
                            Expanded(
                              child: _StatCard(
                                title: 'Income',
                                amount: stats['income'] ?? 0.0,
                                currencySymbol: '\$',
                                isIncome: true,
                              ),
                            ),
                            const SizedBox(width: AppConstants.spacing12),
                            Expanded(
                              child: _StatCard(
                                title: 'Expense',
                                amount: stats['expense'] ?? 0.0,
                                currencySymbol: '\$',
                                isIncome: false,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppConstants.spacing24),
                        const Text(
                          '3-Month Trend',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppConstants.spacing12),
                        TrendLineChart(
                          data: trendData,
                          labels: trendLabels,
                        ),
                        const SizedBox(height: AppConstants.spacing24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Recent Transactions',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                // Navigate to transactions screen
                              },
                              child: const Text('See All'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                categoriesAsync.when(
                  data: (categories) {
                    final categoryMap = {for (var c in categories) c.id: c};
                    
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: AppConstants.spacing16),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final transaction = recentTransactions[index];
                            return TransactionItem(
                              transaction: transaction,
                              category: categoryMap[transaction.categoryId],
                              currencySymbol: '\$',
                            );
                          },
                          childCount: recentTransactions.length,
                        ),
                      ),
                    );
                  },
                  loading: () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (_, __) => const SliverToBoxAdapter(
                    child: Center(child: Text('Error loading categories')),
                  ),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 80)),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(child: Text('Error: $error')),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddTransactionScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final double amount;
  final String currencySymbol;
  final bool isIncome;

  const _StatCard({
    required this.title,
    required this.amount,
    required this.currencySymbol,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(AppConstants.spacing16),
      decoration: BoxDecoration(
        color: isDark ? Colors.grey[900] : Colors.white,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        border: Border.all(
          color: isDark ? Colors.grey[800]! : Colors.grey[200]!,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            Helpers.formatCurrency(amount, currencySymbol),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: isIncome ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
