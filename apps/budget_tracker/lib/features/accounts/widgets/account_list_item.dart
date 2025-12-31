import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/widgets/budget_widgets.dart';
import 'package:budget_tracker/widgets/confirmation_bottom_sheet.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({
    required this.account,
    required this.onTap,
    required this.onDelete,
    this.monthlySpending = 0,
    super.key,
  });

  final AccountEntity account;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  /// Monthly spending for this account (sum of expenses this month)
  final double monthlySpending;

  String _formatAmount(double amount) {
    final formatter = NumberFormat.compactCurrency(
      symbol: '',
      decimalDigits: amount.abs() >= 1000 ? 0 : 2,
    );
    return formatter.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dismissible(
      key: Key(account.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showConfirmationBottomSheet(
        context: context,
        title: 'Delete Account',
        message:
            'Are you sure you want to delete "${account.name}"? '
            'This will also delete all associated transactions.',
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
        padding: EdgeInsets.zero,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  AccountTypeIcon(type: account.type, size: 48),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          account.name,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          account.type.displayName,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _formatAmount(account.balance),
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: account.balance >= 0
                              ? theme.colorScheme.onSurface
                              : theme.colorScheme.error,
                        ),
                      ),
                      if (account.type == AccountType.creditCard &&
                          account.creditLimit != null)
                        Text(
                          'of ${_formatAmount(account.creditLimit!)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.outline,
                  ),
                ],
              ),
            ),
            if (account.budgetLimit != null && account.budgetLimit! > 0) ...[
              Divider(
                height: 1,
                color: theme.colorScheme.outline.withValues(alpha: 0.2),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                child: BudgetProgressIndicator(
                  current: monthlySpending,
                  limit: account.budgetLimit!,
                  warningThreshold: account.warningThreshold,
                  label: 'of monthly budget used',
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
