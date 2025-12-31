import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/installments/cubit/installments_cubit.dart';
import 'package:budget_tracker/features/installments/cubit/installments_state.dart';
import 'package:budget_tracker/features/installments/widgets/installment_list_item.dart';
import 'package:budget_tracker/features/installments/widgets/installments_summary_card.dart';
import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class InstallmentsScreen extends StatelessWidget {
  const InstallmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => InstallmentsCubit(
        installmentRepository: GetIt.I<InstallmentRepository>(),
        accountRepository: GetIt.I<AccountRepository>(),
      ),
      child: const _InstallmentsView(),
    );
  }
}

class _InstallmentsView extends StatelessWidget {
  const _InstallmentsView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocBuilder<InstallmentsCubit, InstallmentsState>(
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
                            'Installments',
                            style: theme.textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Track your credit card installments',
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
                  if (state.creditCardAccounts.isNotEmpty) ...[
                    SliverToBoxAdapter(
                      child: _AccountFilter(
                        accounts: state.creditCardAccounts,
                        selectedAccountId: state.filterAccountId,
                        onFilterChanged: context
                            .read<InstallmentsCubit>()
                            .setFilterAccountId,
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: InstallmentsSummaryCard(
                          monthlyPayment: state.totalMonthlyPayment,
                          remainingAmount: state.totalRemainingAmount,
                          activeCount: state.activeInstallments.length,
                        ),
                      ),
                    ),
                  ],
                  if (state.activeInstallments.isEmpty &&
                      state.completedInstallments.isEmpty)
                    SliverFillRemaining(child: _EmptyState())
                  else ...[
                    if (state.activeInstallments.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                          child: Text(
                            'Active (${state.activeInstallments.length})',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final installment =
                                  state.activeInstallments[index];
                              final account = state.accounts.firstWhere(
                                (a) => a.id == installment.accountId,
                                orElse: () => const AccountEntity(
                                  id: '',
                                  name: 'Unknown',
                                  type: AccountType.creditCard,
                                ),
                              );
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: InstallmentListItem(
                                  installment: installment,
                                  accountName: account.name,
                                  onTap: () => context.pushNamed(
                                    AppRoutes.installmentEntry.name,
                                    extra: installment,
                                  ),
                                  onPaymentMade: () => context
                                      .read<InstallmentsCubit>()
                                      .markPaymentMade(installment.id),
                                  onDelete: () => context
                                      .read<InstallmentsCubit>()
                                      .deleteInstallment(installment.id),
                                ),
                              );
                            },
                            childCount: state.activeInstallments.length,
                          ),
                        ),
                      ),
                    ],
                    if (state.completedInstallments.isNotEmpty) ...[
                      SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                          child: Text(
                            'Completed (${state.completedInstallments.length})',
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.outline,
                            ),
                          ),
                        ),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final installment =
                                  state.completedInstallments[index];
                              final account = state.accounts.firstWhere(
                                (a) => a.id == installment.accountId,
                                orElse: () => const AccountEntity(
                                  id: '',
                                  name: 'Unknown',
                                  type: AccountType.creditCard,
                                ),
                              );
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: InstallmentListItem(
                                  installment: installment,
                                  accountName: account.name,
                                  onTap: () {},
                                  onPaymentMade: null,
                                  onDelete: () => context
                                      .read<InstallmentsCubit>()
                                      .deleteInstallment(installment.id),
                                ),
                              );
                            },
                            childCount: state.completedInstallments.length,
                          ),
                        ),
                      ),
                    ],
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 80),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.pushNamed(AppRoutes.installmentEntry.name),
        icon: const Icon(Icons.add),
        label: const Text('Add Installment'),
      ),
    );
  }
}

class _AccountFilter extends StatelessWidget {
  const _AccountFilter({
    required this.accounts,
    required this.selectedAccountId,
    required this.onFilterChanged,
  });

  final List<AccountEntity> accounts;
  final String? selectedAccountId;
  final ValueChanged<String?> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _FilterChip(
            label: 'All Cards',
            isSelected: selectedAccountId == null,
            onTap: () => onFilterChanged(null),
          ),
          const SizedBox(width: 8),
          ...accounts.map(
            (account) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _FilterChip(
                label: account.name,
                isSelected: selectedAccountId == account.id,
                onTap: () => onFilterChanged(account.id),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? colorScheme.primary
                : colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.credit_card_outlined,
            size: 64,
            color: theme.colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            'No installments yet',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to track a new installment plan',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
