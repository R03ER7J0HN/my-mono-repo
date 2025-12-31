import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/monthly_budget/cubit/monthly_budget_cubit.dart';
import 'package:budget_tracker/features/monthly_budget/cubit/monthly_budget_state.dart';
import 'package:budget_tracker/features/monthly_budget/widgets/budget_entry_dialog.dart';
import 'package:budget_tracker/features/monthly_budget/widgets/budget_summary_card.dart';
import 'package:budget_tracker/features/monthly_budget/widgets/daily_budget_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';

class MonthlyBudgetScreen extends StatelessWidget {
  const MonthlyBudgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MonthlyBudgetCubit(
        monthlyBudgetRepository: GetIt.I<MonthlyBudgetRepository>(),
        transactionRepository: GetIt.I<TransactionRepository>(),
      ),
      child: const _MonthlyBudgetView(),
    );
  }
}

class _MonthlyBudgetView extends StatelessWidget {
  const _MonthlyBudgetView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final now = DateTime.now();
    final monthYear = DateFormat('MMMM yyyy').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text(monthYear),
        actions: [
          BlocBuilder<MonthlyBudgetCubit, MonthlyBudgetState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Set Budget',
                onPressed: () => _showBudgetDialog(context, state),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<MonthlyBudgetCubit, MonthlyBudgetState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.currentBudget == null) {
            return _buildNoBudgetView(context, state, theme);
          }

          return _buildBudgetDashboard(context, state, theme);
        },
      ),
    );
  }

  Widget _buildNoBudgetView(
    BuildContext context,
    MonthlyBudgetState state,
    ThemeData theme,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 80,
            color: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No Budget Set',
            style: theme.textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            'Set a monthly budget to track your spending',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 24),
          FilledButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Set Monthly Budget'),
            onPressed: () => _showBudgetDialog(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildBudgetDashboard(
    BuildContext context,
    MonthlyBudgetState state,
    ThemeData theme,
  ) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        BudgetSummaryCard(state: state),
        const SizedBox(height: 16),
        DailyBudgetCard(state: state),
        const SizedBox(height: 16),
        _buildRecentTransactions(context, state, theme),
      ],
    );
  }

  Widget _buildRecentTransactions(
    BuildContext context,
    MonthlyBudgetState state,
    ThemeData theme,
  ) {
    final expenses =
        state.monthlyTransactions
            .where((t) => t.type == TransactionType.expense)
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));

    final recentExpenses = expenses.take(5).toList();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Recent Expenses', style: theme.textTheme.titleMedium),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('See All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (recentExpenses.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Center(
                  child: Text(
                    'No expenses this month',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              ...recentExpenses.map(
                (transaction) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(transaction.description),
                  subtitle: Text(
                    DateFormat('MMM d').format(transaction.date),
                  ),
                  trailing: Text(
                    '-\$${transaction.amount.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showBudgetDialog(BuildContext context, MonthlyBudgetState state) {
    unawaited(
      showDialog<void>(
        context: context,
        builder: (dialogContext) => BudgetEntryDialog(
          currentBudget: state.currentBudget,
          onSave: (totalBudget, dailyBudget, notes) async {
            final cubit = context.read<MonthlyBudgetCubit>();
            final success = await cubit.setMonthlyBudget(
              totalBudget: totalBudget,
              dailyBudget: dailyBudget,
              notes: notes,
            );
            if (success && dialogContext.mounted) {
              Navigator.pop(dialogContext);
            }
          },
        ),
      ),
    );
  }
}
