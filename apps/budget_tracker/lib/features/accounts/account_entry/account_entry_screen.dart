import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/accounts/account_entry/cubit/account_entry_cubit.dart';
import 'package:budget_tracker/features/accounts/account_entry/cubit/account_entry_state.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class AccountEntryScreen extends StatelessWidget {
  const AccountEntryScreen({
    this.account,
    super.key,
  });

  final AccountEntity? account;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountEntryCubit(
        accountRepository: GetIt.I<AccountRepository>(),
        existingAccount: account,
      ),
      child: const _AccountEntryView(),
    );
  }
}

class _AccountEntryView extends StatefulWidget {
  const _AccountEntryView();

  @override
  State<_AccountEntryView> createState() => _AccountEntryViewState();
}

class _AccountEntryViewState extends State<_AccountEntryView> {
  late final TextEditingController _nameController;
  late final TextEditingController _balanceController;
  late final TextEditingController _creditLimitController;
  late final TextEditingController _budgetLimitController;

  @override
  void initState() {
    super.initState();
    final state = context.read<AccountEntryCubit>().state;
    _nameController = TextEditingController(text: state.name);
    _balanceController = TextEditingController(
      text: state.balance != 0 ? state.balance.toString() : '',
    );
    _creditLimitController = TextEditingController(
      text: state.creditLimit?.toString() ?? '',
    );
    _budgetLimitController = TextEditingController(
      text: state.budgetLimit?.toString() ?? '',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    _creditLimitController.dispose();
    _budgetLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<AccountEntryCubit, AccountEntryState>(
      listenWhen: (prev, curr) =>
          prev.error != curr.error && curr.error != null,
      listener: (context, state) {
        if (state.error != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error!),
              backgroundColor: theme.colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<AccountEntryCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text(state.isEditing ? 'Edit Account' : 'New Account'),
            actions: [
              TextButton(
                onPressed: state.isValid && !state.isSaving
                    ? () async {
                        final success = await cubit.save();
                        if (success && context.mounted) {
                          context.pop();
                        }
                      }
                    : null,
                child: state.isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
          body: BackgroundDecoration(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Details',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Account Name',
                            hintText: 'e.g., Main Savings',
                            prefixIcon: Icon(Icons.label_outline),
                          ),
                          onChanged: cubit.setName,
                          textCapitalization: TextCapitalization.words,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Account Type',
                          style: theme.textTheme.labelLarge,
                        ),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: AccountType.values.map((type) {
                            final isSelected = state.type == type;
                            return ChoiceChip(
                              label: Text(type.displayName),
                              selected: isSelected,
                              onSelected: (_) => cubit.setType(type),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Balance & Limits',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _balanceController,
                          decoration: InputDecoration(
                            labelText: state.type == AccountType.creditCard
                                ? 'Current Balance (negative for debt)'
                                : 'Current Balance',
                            hintText: '0.00',
                            prefixIcon: const Icon(
                              Icons.account_balance_wallet,
                            ),
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                            signed: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^-?\d*\.?\d*'),
                            ),
                          ],
                          onChanged: (value) {
                            final amount = double.tryParse(value) ?? 0;
                            cubit.setBalance(amount);
                          },
                        ),
                        if (state.type == AccountType.creditCard) ...[
                          const SizedBox(height: 16),
                          TextField(
                            controller: _creditLimitController,
                            decoration: const InputDecoration(
                              labelText: 'Credit Limit',
                              hintText: 'e.g., 10000',
                              prefixIcon: Icon(Icons.credit_card),
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d*\.?\d*'),
                              ),
                            ],
                            onChanged: (value) {
                              final limit = double.tryParse(value);
                              cubit.setCreditLimit(limit);
                            },
                          ),
                        ],
                        const SizedBox(height: 16),
                        TextField(
                          controller: _budgetLimitController,
                          decoration: const InputDecoration(
                            labelText: 'Budget Limit (Optional)',
                            hintText: 'Monthly spending limit',
                            prefixIcon: Icon(Icons.savings),
                            helperText: 'Get warned when reaching 80% of limit',
                          ),
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*'),
                            ),
                          ],
                          onChanged: (value) {
                            final limit = double.tryParse(value);
                            cubit.setBudgetLimit(limit);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
