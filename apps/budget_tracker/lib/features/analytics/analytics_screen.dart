import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/analytics/cubit/analytics_cubit.dart';
import 'package:budget_tracker/features/analytics/cubit/analytics_state.dart';
import 'package:budget_tracker/features/analytics/widgets/analytics_date_navigator.dart';
import 'package:budget_tracker/features/analytics/widgets/analytics_view_mode_selector.dart';
import 'package:budget_tracker/widgets/account_type_filter.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/category_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnalyticsCubit(
        transactionRepository: GetIt.I<TransactionRepository>(),
        accountRepository: GetIt.I<AccountRepository>(),
        categoryRepository: GetIt.I<CategoryRepository>(),
      ),
      child: const _AnalyticsContent(),
    );
  }
}

class _AnalyticsContent extends StatelessWidget {
  const _AnalyticsContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        actions: [
          BlocBuilder<AnalyticsCubit, AnalyticsState>(
            builder: (context, state) {
              return AccountTypeFilter(
                selectedAccountType: state.selectedAccountType,
                onChanged: context.read<AnalyticsCubit>().setAccountTypeFilter,
              );
            },
          ),
        ],
      ),
      body: BackgroundDecoration(
        child: SafeArea(
          top: false,
          child: BlocBuilder<AnalyticsCubit, AnalyticsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.error != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.error_outline,
                        size: 48,
                        color: theme.colorScheme.error,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        state.error!,
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 16),

                    // View mode selector
                    const Center(child: AnalyticsViewModeSelector()),
                    const SizedBox(height: 16),

                    // Date navigator
                    const AnalyticsDateNavigator(),
                    const SizedBox(height: 24),

                    // Period summary
                    _PeriodSummary(state: state),
                    const SizedBox(height: 24),

                    // Category breakdown pie chart (merged income + expense)
                    CategoryPieChart(
                      transactions: state.filteredTransactions,
                      categories: state.categories,
                      title: 'Spending by Category',
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _PeriodSummary extends StatelessWidget {
  const _PeriodSummary({required this.state});

  final AnalyticsState state;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SummaryItem(
              label: 'Income',
              amount: state.periodIncome,
              color: Colors.green,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _SummaryItem(
              label: 'Expenses',
              amount: state.periodExpenses,
              color: Colors.red,
            ),
          ),
          Container(
            width: 1,
            height: 40,
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
          ),
          Expanded(
            child: _SummaryItem(
              label: 'Net',
              amount: state.periodNet,
              color: state.periodNet >= 0 ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({
    required this.label,
    required this.amount,
    required this.color,
  });

  final String label;
  final double amount;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          '\$${amount.abs().toStringAsFixed(2)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
