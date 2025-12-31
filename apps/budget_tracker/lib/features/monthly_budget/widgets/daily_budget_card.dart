import 'package:budget_tracker/features/monthly_budget/cubit/monthly_budget_state.dart';
import 'package:flutter/material.dart';

class DailyBudgetCard extends StatelessWidget {
  const DailyBudgetCard({
    required this.state,
    super.key,
  });

  final MonthlyBudgetState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isOverDailyBudget = state.isOverDailyBudget;
    final suggestedDaily = state.suggestedDailyBudget;
    final todayRemaining = state.todayRemainingBudget;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Daily Budget', style: theme.textTheme.titleMedium),
                _buildTodayIndicator(theme, isOverDailyBudget),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildDailyItem(
                    context,
                    icon: Icons.calendar_today,
                    title: 'Suggested Daily',
                    value: '\$${suggestedDaily.toStringAsFixed(2)}',
                    subtitle: 'based on remaining budget',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildDailyItem(
                    context,
                    icon: Icons.today,
                    title: 'Today Remaining',
                    value: '\$${todayRemaining.toStringAsFixed(2)}',
                    subtitle:
                        'spent: \$${state.todayExpenses.toStringAsFixed(2)}',
                    isNegative: todayRemaining < 0,
                  ),
                ),
              ],
            ),
            if (state.currentBudget?.dailyBudget != null) ...[
              const Divider(height: 32),
              _buildSetDailyBudget(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTodayIndicator(ThemeData theme, bool isOverDailyBudget) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isOverDailyBudget ? Icons.warning_amber : Icons.check_circle,
          size: 16,
          color: isOverDailyBudget ? theme.colorScheme.error : Colors.green,
        ),
        const SizedBox(width: 4),
        Text(
          isOverDailyBudget ? 'Over daily limit' : 'Within limit',
          style: theme.textTheme.labelSmall?.copyWith(
            color: isOverDailyBudget ? theme.colorScheme.error : Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildDailyItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    bool isNegative = false,
  }) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: theme.colorScheme.primary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.labelMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: isNegative ? theme.colorScheme.error : null,
            ),
          ),
          Text(
            subtitle,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSetDailyBudget(ThemeData theme) {
    final dailyBudget = state.currentBudget?.dailyBudget ?? 0;
    return Row(
      children: [
        Icon(
          Icons.savings,
          color: theme.colorScheme.secondary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Fixed Daily Budget', style: theme.textTheme.titleSmall),
              Text(
                '\$${dailyBudget.toStringAsFixed(2)} per day',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
