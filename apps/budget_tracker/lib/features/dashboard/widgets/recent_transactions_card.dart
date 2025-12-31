import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class RecentTransactionsCard extends StatelessWidget {
  const RecentTransactionsCard({
    required this.transactions,
    required this.accounts,
    super.key,
  });

  final List<TransactionEntity> transactions;
  final List<AccountEntity> accounts;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transactions',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => context.goNamed(AppRoutes.transactions.name),
                child: const Text('See All'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (transactions.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Icon(
                      Icons.receipt_long_outlined,
                      size: 48,
                      color: theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No transactions yet',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ...transactions.map((transaction) {
              final account = accounts.firstWhere(
                (a) => a.id == transaction.accountId,
                orElse: () => const AccountEntity(
                  id: '',
                  name: 'Unknown',
                  type: AccountType.cash,
                ),
              );
              return _TransactionTile(
                transaction: transaction,
                accountName: account.name,
              );
            }),
        ],
      ),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  const _TransactionTile({
    required this.transaction,
    required this.accountName,
  });

  final TransactionEntity transaction;
  final String accountName;

  IconData get _icon {
    switch (transaction.type) {
      case TransactionType.income:
        return Icons.arrow_downward;
      case TransactionType.expense:
        return Icons.arrow_upward;
      case TransactionType.transfer:
        return Icons.swap_horiz;
    }
  }

  Color _getColor(BuildContext context) {
    switch (transaction.type) {
      case TransactionType.income:
        return AppTheme.successColor;
      case TransactionType.expense:
        return Theme.of(context).colorScheme.error;
      case TransactionType.transfer:
        return Colors.blue;
    }
  }

  String _formatAmount(TransactionEntity transaction) {
    final prefix = transaction.type == TransactionType.income ? '+' : '-';
    return '$prefix${transaction.amount.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _getColor(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  // String interpolation with date format exceeds 80 chars.
                  // ignore: lines_longer_than_80_chars
                  '$accountName • ${DateFormat.MMMd().format(transaction.date)}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            _formatAmount(transaction),
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
