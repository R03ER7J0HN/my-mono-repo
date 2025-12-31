import 'package:budget_tracker/features/transactions/cubit/transactions_state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateNavigator extends StatelessWidget {
  const DateNavigator({
    required this.selectedDate,
    required this.viewMode,
    required this.onPreviousPeriod,
    required this.onNextPeriod,
    required this.onSelectDate,
    required this.onToday,
    super.key,
  });

  final DateTime selectedDate;
  final TransactionViewMode viewMode;
  final VoidCallback onPreviousPeriod;
  final VoidCallback onNextPeriod;
  final ValueChanged<DateTime> onSelectDate;
  final VoidCallback onToday;

  bool get _isCurrentPeriod {
    final now = DateTime.now();
    switch (viewMode) {
      case TransactionViewMode.daily:
        return selectedDate.year == now.year &&
            selectedDate.month == now.month &&
            selectedDate.day == now.day;
      case TransactionViewMode.monthly:
        return selectedDate.year == now.year && selectedDate.month == now.month;
      case TransactionViewMode.yearly:
        return selectedDate.year == now.year;
    }
  }

  String get _periodLabel {
    switch (viewMode) {
      case TransactionViewMode.daily:
        if (_isCurrentPeriod) return 'Today';
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        if (selectedDate.year == yesterday.year &&
            selectedDate.month == yesterday.month &&
            selectedDate.day == yesterday.day) {
          return 'Yesterday';
        }
        return DateFormat.yMMMd().format(selectedDate);
      case TransactionViewMode.monthly:
        if (_isCurrentPeriod) return 'This Month';
        return DateFormat.yMMM().format(selectedDate);
      case TransactionViewMode.yearly:
        if (_isCurrentPeriod) return 'This Year';
        return selectedDate.year.toString();
    }
  }

  String? get _subLabel {
    switch (viewMode) {
      case TransactionViewMode.daily:
        if (!_isCurrentPeriod) {
          return DateFormat.EEEE().format(selectedDate);
        }
        return null;
      case TransactionViewMode.monthly:
      case TransactionViewMode.yearly:
        return null;
    }
  }

  String get _currentPeriodLabel {
    switch (viewMode) {
      case TransactionViewMode.daily:
        return 'Today';
      case TransactionViewMode.monthly:
        return 'This Month';
      case TransactionViewMode.yearly:
        return 'This Year';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          IconButton.filled(
            onPressed: onPreviousPeriod,
            icon: const Icon(Icons.chevron_left),
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              foregroundColor: colorScheme.onSurface,
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () async {
                final date = await showDatePicker(
                  context: context,
                  initialDate: selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                );
                if (date != null) {
                  onSelectDate(date);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  children: [
                    Text(
                      _periodLabel,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (_subLabel != null)
                      Text(
                        _subLabel!,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          IconButton.filled(
            onPressed: onNextPeriod,
            icon: const Icon(Icons.chevron_right),
            style: IconButton.styleFrom(
              backgroundColor: colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              foregroundColor: colorScheme.onSurface,
            ),
          ),
          if (!_isCurrentPeriod) ...[
            const SizedBox(width: 8),
            TextButton(
              onPressed: onToday,
              child: Text(_currentPeriodLabel),
            ),
          ],
        ],
      ),
    );
  }
}
