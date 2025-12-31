import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class DashboardSummaryCard extends StatelessWidget {
  const DashboardSummaryCard({
    required this.summary,
    super.key,
  });

  final BudgetSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Financial Overview',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  label: 'Net Worth',
                  value: summary.netWorth,
                  icon: Icons.account_balance,
                  iconColor: colorScheme.primary,
                  valueColor: summary.netWorth >= 0
                      ? AppTheme.successColor
                      : colorScheme.error,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SummaryTile(
                  label: 'Total Balance',
                  value: summary.totalBalance,
                  icon: Icons.wallet,
                  iconColor: AppTheme.successColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryTile(
                  label: 'Total Debt',
                  value: summary.totalDebt,
                  icon: Icons.credit_card,
                  iconColor: colorScheme.error,
                  valueColor: colorScheme.error,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SummaryTile(
                  label: 'Installments/mo',
                  value: summary.monthlyInstallments,
                  icon: Icons.calendar_month,
                  iconColor: Colors.orange,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            children: [
              Expanded(
                child: _MonthlyStatTile(
                  label: 'Income',
                  value: summary.monthlyIncome,
                  icon: Icons.arrow_downward,
                  color: AppTheme.successColor,
                ),
              ),
              Expanded(
                child: _MonthlyStatTile(
                  label: 'Expenses',
                  value: summary.monthlyExpenses,
                  icon: Icons.arrow_upward,
                  color: colorScheme.error,
                ),
              ),
              Expanded(
                child: _MonthlyStatTile(
                  label: 'Savings',
                  value: summary.monthlySavings,
                  icon: Icons.savings,
                  color: summary.monthlySavings >= 0
                      ? AppTheme.successColor
                      : colorScheme.error,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryTile extends StatelessWidget {
  const _SummaryTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.valueColor,
  });

  final String label;
  final double value;
  final IconData icon;
  final Color iconColor;
  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
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
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value.toStringAsFixed(2),
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthlyStatTile extends StatelessWidget {
  const _MonthlyStatTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final double value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(height: 8),
        Text(
          value.toStringAsFixed(2),
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
