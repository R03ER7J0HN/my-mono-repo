import 'package:budget_tracker/theme/app_theme.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';

class InstallmentsSummaryCard extends StatelessWidget {
  const InstallmentsSummaryCard({
    required this.monthlyPayment,
    required this.remainingAmount,
    required this.activeCount,
    super.key,
  });

  final double monthlyPayment;
  final double remainingAmount;
  final int activeCount;

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
            'Summary',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _SummaryItem(
                  label: 'Monthly Due',
                  value: monthlyPayment.toStringAsFixed(2),
                  icon: Icons.calendar_month,
                  color: colorScheme.primary,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
              Expanded(
                child: _SummaryItem(
                  label: 'Total Remaining',
                  value: remainingAmount.toStringAsFixed(2),
                  icon: Icons.account_balance,
                  color: colorScheme.error,
                ),
              ),
              Container(
                width: 1,
                height: 50,
                color: colorScheme.outline.withValues(alpha: 0.2),
              ),
              Expanded(
                child: _SummaryItem(
                  label: 'Active Plans',
                  value: activeCount.toString(),
                  icon: Icons.credit_score,
                  color: AppTheme.successColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(height: 8),
        Text(
          value,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
