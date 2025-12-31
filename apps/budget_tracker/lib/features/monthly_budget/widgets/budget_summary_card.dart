import 'package:budget_tracker/features/monthly_budget/cubit/monthly_budget_state.dart';
import 'package:flutter/material.dart';

class BudgetSummaryCard extends StatelessWidget {
  const BudgetSummaryCard({
    required this.state,
    super.key,
  });

  final MonthlyBudgetState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final budget = state.currentBudget;
    if (budget == null) return const SizedBox.shrink();

    final spentPercentage = state.spentPercentage;
    final isOverBudget = state.isOverBudget;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Monthly Budget', style: theme.textTheme.titleMedium),
                _buildStatusChip(theme, isOverBudget),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Spent',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '\$${state.totalExpenses.toStringAsFixed(2)}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: isOverBudget
                            ? theme.colorScheme.error
                            : theme.colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'of \$${budget.totalBudget.toStringAsFixed(2)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      '${spentPercentage.toStringAsFixed(1)}%',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: (spentPercentage / 100).clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: theme.colorScheme.surfaceContainerHighest,
                color: isOverBudget
                    ? theme.colorScheme.error
                    : theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoItem(
                  theme,
                  'Remaining',
                  '\$${state.remainingBudget.toStringAsFixed(2)}',
                  isNegative: state.remainingBudget < 0,
                ),
                _buildInfoItem(
                  theme,
                  'Income',
                  '+\$${state.totalIncome.toStringAsFixed(2)}',
                  isPositive: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ThemeData theme, bool isOverBudget) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isOverBudget
            ? theme.colorScheme.errorContainer
            : theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        isOverBudget ? 'Over Budget' : 'On Track',
        style: theme.textTheme.labelSmall?.copyWith(
          color: isOverBudget
              ? theme.colorScheme.onErrorContainer
              : theme.colorScheme.onPrimaryContainer,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInfoItem(
    ThemeData theme,
    String label,
    String value, {
    bool isNegative = false,
    bool isPositive = false,
  }) {
    Color? valueColor;
    if (isNegative) {
      valueColor = theme.colorScheme.error;
    } else if (isPositive) {
      valueColor = Colors.green;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            color: valueColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
