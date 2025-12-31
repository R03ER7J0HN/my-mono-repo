import 'package:budget_tracker/features/analytics/cubit/analytics_cubit.dart';
import 'package:budget_tracker/features/analytics/cubit/analytics_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AnalyticsDateNavigator extends StatelessWidget {
  const AnalyticsDateNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AnalyticsCubit, AnalyticsState>(
      builder: (context, state) {
        final cubit = context.read<AnalyticsCubit>();
        final isCurrentPeriod = _isCurrentPeriod(state);

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: cubit.goToPreviousPeriod,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () => _showDatePicker(context, state, cubit),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _getPeriodLabel(state),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (_getSubLabel(state) != null)
                        Text(
                          _getSubLabel(state)!,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: cubit.goToNextPeriod,
              ),
              if (!isCurrentPeriod)
                TextButton(
                  onPressed: cubit.goToCurrentPeriod,
                  child: Text(_getCurrentPeriodLabel(state.viewMode)),
                ),
            ],
          ),
        );
      },
    );
  }

  bool _isCurrentPeriod(AnalyticsState state) {
    final now = DateTime.now();
    final date = state.displayDate;
    switch (state.viewMode) {
      case AnalyticsViewMode.daily:
        return date.year == now.year &&
            date.month == now.month &&
            date.day == now.day;
      case AnalyticsViewMode.monthly:
        return date.year == now.year && date.month == now.month;
      case AnalyticsViewMode.yearly:
        return date.year == now.year;
    }
  }

  String _getPeriodLabel(AnalyticsState state) {
    if (_isCurrentPeriod(state)) {
      return _getCurrentPeriodLabel(state.viewMode);
    }
    switch (state.viewMode) {
      case AnalyticsViewMode.daily:
        final yesterday = DateTime.now().subtract(const Duration(days: 1));
        final date = state.displayDate;
        if (date.year == yesterday.year &&
            date.month == yesterday.month &&
            date.day == yesterday.day) {
          return 'Yesterday';
        }
        return DateFormat.yMMMd().format(date);
      case AnalyticsViewMode.monthly:
        return DateFormat.yMMM().format(state.displayDate);
      case AnalyticsViewMode.yearly:
        return state.displayDate.year.toString();
    }
  }

  String? _getSubLabel(AnalyticsState state) {
    if (state.viewMode == AnalyticsViewMode.daily && !_isCurrentPeriod(state)) {
      return DateFormat.EEEE().format(state.displayDate);
    }
    return null;
  }

  String _getCurrentPeriodLabel(AnalyticsViewMode viewMode) {
    switch (viewMode) {
      case AnalyticsViewMode.daily:
        return 'Today';
      case AnalyticsViewMode.monthly:
        return 'This Month';
      case AnalyticsViewMode.yearly:
        return 'This Year';
    }
  }

  Future<void> _showDatePicker(
    BuildContext context,
    AnalyticsState state,
    AnalyticsCubit cubit,
  ) async {
    final date = await showDatePicker(
      context: context,
      initialDate: state.displayDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      cubit.selectDate(date);
    }
  }
}
