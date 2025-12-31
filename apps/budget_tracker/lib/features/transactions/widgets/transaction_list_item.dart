import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/data/category_colors.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:budget_tracker/widgets/confirmation_bottom_sheet.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionListItem extends StatelessWidget {
  const TransactionListItem({
    required this.transaction,
    required this.accountName,
    required this.onTap,
    required this.onDelete,
    this.category,
    super.key,
  });

  final TransactionEntity transaction;
  final String accountName;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final CategoryEntity? category;

  IconData get _icon {
    switch (transaction.type) {
      case TransactionType.income:
        return Icons.arrow_upward;
      case TransactionType.expense:
        return Icons.arrow_downward;
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

    return Dismissible(
      key: Key(transaction.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showConfirmationBottomSheet(
        context: context,
        title: 'Delete Transaction',
        message: 'Are you sure you want to delete this transaction?',
        confirmLabel: 'Delete',
        icon: Icons.delete_outline,
        isDanger: true,
      ),
      onDismissed: (_) => onDelete(),
      background: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_icon, color: color, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.description,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_outlined,
                        size: 12,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        accountName,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.access_time,
                        size: 12,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        DateFormat.jm().format(transaction.date),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatAmount(transaction),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                if (category != null)
                  Container(
                    margin: const EdgeInsets.only(top: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Color(category!.colorValue).withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          IconData(
                            category!.iconCodePoint,
                            fontFamily: 'MaterialIcons',
                          ),
                          size: 12,
                          color: Color(category!.colorValue),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          category!.name,
                          style: theme.textTheme.labelSmall?.copyWith(
                            color:
                                CategoryColors.contrastColor(
                                      Color(
                                        category!.colorValue,
                                      ).withValues(alpha: 0.2),
                                    ) ==
                                    Colors.white
                                ? Color(category!.colorValue)
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
