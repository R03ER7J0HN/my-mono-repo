import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';

class WarningBanner extends StatelessWidget {
  const WarningBanner({
    required this.summary,
    super.key,
  });

  final BudgetSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String message;
    if (summary.accountsOverThreshold > 0 &&
        summary.creditCardsOverThreshold > 0) {
      message =
          '${summary.accountsOverThreshold} account(s) and '
          '${summary.creditCardsOverThreshold} credit card(s) '
          'over budget threshold';
    } else if (summary.accountsOverThreshold > 0) {
      message =
          '${summary.accountsOverThreshold} account(s) '
          'exceeded 80% of budget';
    } else {
      message =
          '${summary.creditCardsOverThreshold} credit card(s) '
          'exceeded 80% of limit';
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.warningColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.warningColor.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppTheme.warningColor.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.warning_amber_rounded,
              color: AppTheme.warningColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Budget Warning',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.warningColor,
                  ),
                ),
                Text(
                  message,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
