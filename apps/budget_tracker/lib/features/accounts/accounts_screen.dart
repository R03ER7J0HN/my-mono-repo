import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/accounts/cubit/accounts_cubit.dart';
import 'package:budget_tracker/features/accounts/cubit/accounts_state.dart';
import 'package:budget_tracker/features/accounts/widgets/account_list_item.dart';
import 'package:budget_tracker/features/accounts/widgets/account_type_filter.dart';
import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AccountsScreen extends StatelessWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountsCubit(
        accountRepository: GetIt.I<AccountRepository>(),
        transactionRepository: GetIt.I<TransactionRepository>(),
      ),
      child: const _AccountsView(),
    );
  }
}

class _AccountsView extends StatelessWidget {
  const _AccountsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocBuilder<AccountsCubit, AccountsState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Accounts',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage your financial accounts',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.7,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: AccountTypeFilter(
                      selectedType: state.filterType,
                      onFilterChanged: context.read<AccountsCubit>().setFilter,
                    ),
                  ),
                  if (state.filteredAccounts.isEmpty)
                    SliverFillRemaining(
                      child: _EmptyState(
                        filterType: state.filterType,
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.all(20),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final account = state.filteredAccounts[index];
                            final monthlySpending = state
                                .getMonthlySpendingForAccount(account.id);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: AccountListItem(
                                account: account,
                                monthlySpending: monthlySpending,
                                onTap: () => context.pushNamed(
                                  AppRoutes.accountEntry.name,
                                  extra: account,
                                ),
                                onDelete: () => context
                                    .read<AccountsCubit>()
                                    .deleteAccount(account.id),
                              ),
                            );
                          },
                          childCount: state.filteredAccounts.length,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRoutes.accountEntry.name),
        icon: const Icon(Icons.add),
        label: const Text('Add Account'),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({this.filterType});

  final AccountType? filterType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.account_balance_wallet_outlined,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            filterType != null
                ? 'No ${filterType!.displayName} accounts'
                : 'No accounts yet',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to add your first account',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
