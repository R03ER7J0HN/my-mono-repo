import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/dashboard/cubit/dashboard_cubit.dart';
import 'package:budget_tracker/features/dashboard/cubit/dashboard_state.dart';
import 'package:budget_tracker/features/dashboard/widgets/dashboard_summary_card.dart';
import 'package:budget_tracker/features/dashboard/widgets/quick_actions_card.dart';
import 'package:budget_tracker/features/dashboard/widgets/recent_transactions_card.dart';
import 'package:budget_tracker/features/dashboard/widgets/warning_banner.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/confirmation_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:get_it/get_it.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = DashboardCubit(
          accountRepository: GetIt.I<AccountRepository>(),
          transactionRepository: GetIt.I<TransactionRepository>(),
          installmentRepository: GetIt.I<InstallmentRepository>(),
          categoryRepository: GetIt.I<CategoryRepository>(),
        );
        unawaited(cubit.init());
        return cubit;
      },
      child: const _DashboardView(),
    );
  }
}

class _DashboardView extends StatelessWidget {
  const _DashboardView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: BackgroundDecoration(
        child: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (state.isLoading && state.accounts.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 12),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Budget Tracker',
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _getGreeting(),
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSurface
                                        .withValues(
                                          alpha: 0.7,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          PopupMenuButton<String>(
                            icon: Icon(
                              Icons.more_vert,
                              color: theme.colorScheme.onSurface,
                            ),
                            onSelected: (value) async {
                              if (value == 'reset') {
                                await _showResetConfirmation(context);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem<String>(
                                value: 'reset',
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.delete_forever,
                                      color: theme.colorScheme.error,
                                      size: 20,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'Reset All Data',
                                      style: TextStyle(
                                        color: theme.colorScheme.error,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        if (state.summary.hasWarnings) ...[
                          WarningBanner(summary: state.summary),
                          const SizedBox(height: 16),
                        ],
                        DashboardSummaryCard(summary: state.summary),
                        const SizedBox(height: 16),
                        const QuickActionsCard(),
                        const SizedBox(height: 16),
                        RecentTransactionsCard(
                          transactions: state.recentTransactions,
                          accounts: state.accounts,
                        ),
                        const SizedBox(height: 24),
                      ]),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showResetConfirmation(BuildContext context) async {
    final confirmed = await showConfirmationBottomSheet(
      context: context,
      title: 'Reset All Data?',
      message:
          'This will permanently delete all your accounts, transactions, '
          'installments, and budgets. This action cannot be undone.',
      confirmLabel: 'Reset Everything',
      cancelLabel: 'Cancel',
      icon: Icons.delete_forever,
      isDanger: true,
    );

    if (confirmed && context.mounted) {
      final resetAllDataUseCase = GetIt.I<ResetAllDataUseCase>();
      await resetAllDataUseCase();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All data has been reset'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning!';
    if (hour < 17) return 'Good afternoon!';
    return 'Good evening!';
  }
}
