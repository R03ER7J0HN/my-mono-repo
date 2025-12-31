import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/transactions/cubit/transactions_cubit.dart';
import 'package:budget_tracker/features/transactions/cubit/transactions_state.dart';
import 'package:budget_tracker/features/transactions/widgets/daily_summary_card.dart';
import 'package:budget_tracker/features/transactions/widgets/date_navigator.dart';
import 'package:budget_tracker/features/transactions/widgets/transaction_list_item.dart';
import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/widgets/account_type_filter.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionsCubit(
        deleteTransactionUseCase: GetIt.I<DeleteTransactionUseCase>(),
        transactionRepository: GetIt.I<TransactionRepository>(),
        accountRepository: GetIt.I<AccountRepository>(),
        categoryRepository: GetIt.I<CategoryRepository>(),
      ),
      child: const _TransactionsView(),
    );
  }
}

class _TransactionsView extends StatelessWidget {
  const _TransactionsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocBuilder<TransactionsCubit, TransactionsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              final cubit = context.read<TransactionsCubit>();

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Transactions',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Track your spending',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        AccountTypeFilter(
                          selectedAccountType: state.selectedAccountType,
                          onChanged: cubit.setAccountTypeFilter,
                        ),
                      ],
                    ),
                  ),
                  _ViewModeSelector(
                    selectedMode: state.viewMode,
                    onModeChanged: cubit.setViewMode,
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DateNavigator(
                      selectedDate: state.displayDate,
                      viewMode: state.viewMode,
                      onPreviousPeriod: cubit.goToPreviousPeriod,
                      onNextPeriod: cubit.goToNextPeriod,
                      onSelectDate: cubit.selectDate,
                      onToday: cubit.goToToday,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: DailySummaryCard(
                      income: state.periodIncome,
                      expenses: state.periodExpenses,
                      net: state.periodNet,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: state.filteredTransactions.isEmpty
                        ? _EmptyState(viewMode: state.viewMode)
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: state.filteredTransactions.length,
                            itemBuilder: (context, index) {
                              final transaction =
                                  state.filteredTransactions[index];
                              final account = state.accounts.firstWhere(
                                (a) => a.id == transaction.accountId,
                                orElse: () => const AccountEntity(
                                  id: '',
                                  name: 'Unknown',
                                  type: AccountType.cash,
                                ),
                              );
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: TransactionListItem(
                                  transaction: transaction,
                                  accountName: account.name,
                                  category: state.getCategoryForTransaction(
                                    transaction,
                                  ),
                                  onTap: () => context.pushNamed(
                                    AppRoutes.transactionEntry.name,
                                    extra: transaction,
                                  ),
                                  onDelete: () =>
                                      cubit.deleteTransaction(transaction.id),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRoutes.transactionEntry.name),
        icon: const Icon(Icons.add),
        label: const Text('Add Transaction'),
      ),
    );
  }
}

class _ViewModeSelector extends StatelessWidget {
  const _ViewModeSelector({
    required this.selectedMode,
    required this.onModeChanged,
  });

  final TransactionViewMode selectedMode;
  final ValueChanged<TransactionViewMode> onModeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GlassCard(
        padding: const EdgeInsets.all(4),
        child: Row(
          children: TransactionViewMode.values.map((mode) {
            final isSelected = selectedMode == mode;
            return Expanded(
              child: GestureDetector(
                onTap: () => onModeChanged(mode),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? colorScheme.primaryContainer
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    mode.label,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: isSelected
                          ? colorScheme.onPrimaryContainer
                          : colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.viewMode});

  final TransactionViewMode viewMode;

  String get _periodText {
    switch (viewMode) {
      case TransactionViewMode.daily:
        return 'day';
      case TransactionViewMode.monthly:
        return 'month';
      case TransactionViewMode.yearly:
        return 'year';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No transactions for this $_periodText',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to record your first transaction',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
