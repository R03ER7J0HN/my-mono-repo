import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Widget displaying a budget progress indicator
class BudgetProgressIndicator extends StatelessWidget {
  /// Creates a progress indicator with current/limit values
  const BudgetProgressIndicator({
    required this.current,
    required this.limit,
    super.key,
    this.warningThreshold = 0.8,
    this.height = 8,
    this.showPercentage = true,
    this.label,
  });

  /// Current value (e.g., spent amount or paid installments)
  final double current;

  /// Maximum/limit value (e.g., budget limit or total installments)
  final double limit;

  /// Threshold at which to show warning color (0-1)
  final double warningThreshold;

  /// Height of the progress bar
  final double height;

  /// Whether to show percentage label
  final bool showPercentage;

  /// Optional label describing what the percentage represents
  /// e.g., 'of monthly budget', 'completed'
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final percentage = limit > 0 ? (current / limit) : 0.0;

    Color progressColor;
    if (percentage >= 1.0) {
      progressColor = colorScheme.error;
    } else if (percentage >= warningThreshold) {
      progressColor = AppTheme.warningColor;
    } else {
      progressColor = AppTheme.successColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: percentage.clamp(0.0, 1.0),
            minHeight: height,
            backgroundColor: colorScheme.surfaceContainerHighest,
            valueColor: AlwaysStoppedAnimation(progressColor),
          ),
        ),
        if (showPercentage) ...[
          const SizedBox(height: 4),
          Text(
            '${(percentage * 100).toStringAsFixed(0)}%${label != null ? ' $label' : ''}',
            style: theme.textTheme.labelSmall?.copyWith(
              color: progressColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ],
    );
  }
}

/// Widget displaying an account type icon
class AccountTypeIcon extends StatelessWidget {
  const AccountTypeIcon({
    required this.type,
    super.key,
    this.size = 40,
    this.backgroundColor,
  });

  final AccountType type;
  final double size;
  final Color? backgroundColor;

  IconData get _icon {
    switch (type) {
      case AccountType.cash:
        return Icons.payments_outlined;
      case AccountType.debitCard:
        return Icons.credit_card;
      case AccountType.creditCard:
        return Icons.credit_score;
      case AccountType.eWallet:
        return Icons.phone_android;
      case AccountType.savings:
        return Icons.savings_outlined;
    }
  }

  Color _getBackgroundColor(BuildContext context) {
    if (backgroundColor != null) return backgroundColor!;
    final colorScheme = Theme.of(context).colorScheme;
    switch (type) {
      case AccountType.cash:
        return Colors.green.withValues(alpha: 0.15);
      case AccountType.debitCard:
        return Colors.blue.withValues(alpha: 0.15);
      case AccountType.creditCard:
        return Colors.purple.withValues(alpha: 0.15);
      case AccountType.eWallet:
        return Colors.orange.withValues(alpha: 0.15);
      case AccountType.savings:
        return colorScheme.primary.withValues(alpha: 0.15);
    }
  }

  Color _getIconColor(BuildContext context) {
    switch (type) {
      case AccountType.cash:
        return Colors.green;
      case AccountType.debitCard:
        return Colors.blue;
      case AccountType.creditCard:
        return Colors.purple;
      case AccountType.eWallet:
        return Colors.orange;
      case AccountType.savings:
        return Theme.of(context).colorScheme.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _getBackgroundColor(context),
        borderRadius: BorderRadius.circular(size / 3),
      ),
      child: Icon(
        _icon,
        size: size * 0.5,
        color: _getIconColor(context),
      ),
    );
  }
}

/// Widget for displaying amounts with proper formatting
class AmountText extends StatelessWidget {
  const AmountText({
    required this.amount,
    super.key,
    this.style,
    this.showSign = false,
    this.colorize = false,
    this.compact = false,
  });

  final double amount;
  final TextStyle? style;
  final bool showSign;
  final bool colorize;

  /// Whether to use compact format for large numbers (1K, 1M, etc.)
  final bool compact;

  String get _formattedAmount {
    final absAmount = amount.abs();

    String formatted;
    if (compact && absAmount >= 1000) {
      final formatter = NumberFormat.compact();
      formatted = formatter.format(absAmount);
    } else {
      formatted = absAmount.toStringAsFixed(2);
    }

    if (showSign) {
      if (amount > 0) return '+$formatted';
      if (amount < 0) return '-$formatted';
    }
    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var textStyle = style ?? theme.textTheme.bodyLarge;

    if (colorize) {
      Color? color;
      if (amount > 0) {
        color = AppTheme.successColor;
      } else if (amount < 0) {
        color = theme.colorScheme.error;
      }
      if (color != null) {
        textStyle = textStyle?.copyWith(color: color);
      }
    }

    return Text(_formattedAmount, style: textStyle);
  }
}
