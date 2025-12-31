import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/data/category_colors.dart';
import 'package:budget_tracker/features/transactions/transaction_entry/cubit/transaction_entry_cubit.dart';
import 'package:budget_tracker/features/transactions/transaction_entry/cubit/transaction_entry_state.dart';
import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/budget_widgets.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class TransactionEntryScreen extends StatelessWidget {
  const TransactionEntryScreen({
    this.transaction,
    super.key,
  });

  final TransactionEntity? transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionEntryCubit(
        saveTransactionUseCase: GetIt.I<SaveTransactionUseCase>(),
        accountRepository: GetIt.I<AccountRepository>(),
        categoryRepository: GetIt.I<CategoryRepository>(),
        existingTransaction: transaction,
      ),
      child: const _TransactionEntryView(),
    );
  }
}

class _TransactionEntryView extends StatefulWidget {
  const _TransactionEntryView();

  @override
  State<_TransactionEntryView> createState() => _TransactionEntryViewState();
}

class _TransactionEntryViewState extends State<_TransactionEntryView> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    final state = context.read<TransactionEntryCubit>().state;
    _amountController = TextEditingController(
      text: state.amount != 0 ? state.amount.toString() : '',
    );
    _descriptionController = TextEditingController(text: state.description);
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<TransactionEntryCubit, TransactionEntryState>(
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
        final cubit = context.read<TransactionEntryCubit>();

        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEditing ? 'Edit Transaction' : 'New Transaction',
            ),
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
                  _TransactionTypeSelector(
                    selectedType: state.type,
                    onTypeChanged: cubit.setType,
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Amount',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _amountController,
                          decoration: InputDecoration(
                            hintText: '0.00',
                            prefixIcon: Icon(
                              Icons.monetization_on_outlined,
                              color: _getTypeColor(state.type, context),
                            ),
                          ),
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _getTypeColor(state.type, context),
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
                            final amount = double.tryParse(value) ?? 0;
                            cubit.setAmount(amount);
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: FormBuilder(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Details',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          FormBuilderTextField(
                            name: 'description',
                            controller: _descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              hintText: 'e.g., Grocery shopping',
                              prefixIcon: Icon(Icons.description_outlined),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                            validator: FormBuilderValidators.required(),
                            onChanged: (value) =>
                                cubit.setDescription(value ?? ''),
                          ),
                          const SizedBox(height: 16),
                          _CategoryDropdown(
                            categories: state.categories,
                            selectedCategoryId: state.categoryId,
                            onChanged: cubit.setCategoryId,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GlassCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.isTransfer ? 'Transfer Between' : 'Account',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (state.accounts.isEmpty)
                          Text(
                            'No accounts available. Create an account first.',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.error,
                            ),
                          )
                        else ...[
                          _AccountDropdown(
                            label: state.isTransfer
                                ? 'From Account'
                                : 'Account',
                            accounts: state.accounts,
                            selectedAccountId: state.accountId,
                            excludeAccountId: state.toAccountId,
                            onChanged: cubit.setAccountId,
                          ),
                          if (state.isTransfer) ...[
                            const SizedBox(height: 8),
                            Center(
                              child: Icon(
                                Icons.arrow_downward,
                                color: theme.colorScheme.primary,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _AccountDropdown(
                              label: 'To Account',
                              accounts: state.accounts,
                              selectedAccountId: state.toAccountId,
                              excludeAccountId: state.accountId,
                              onChanged: cubit.setToAccountId,
                            ),
                          ],
                        ],
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
                          'Date & Time',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: const Icon(Icons.calendar_today),
                          title: Text(
                            DateFormat.yMMMd().format(state.transactionDate),
                          ),
                          subtitle: Text(
                            DateFormat.jm().format(state.transactionDate),
                          ),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: state.transactionDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime.now().add(
                                const Duration(days: 365),
                              ),
                            );
                            if (date != null && context.mounted) {
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(
                                  state.transactionDate,
                                ),
                              );
                              if (time != null) {
                                cubit.setDate(
                                  DateTime(
                                    date.year,
                                    date.month,
                                    date.day,
                                    time.hour,
                                    time.minute,
                                  ),
                                );
                              } else {
                                cubit.setDate(date);
                              }
                            }
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

  Color _getTypeColor(TransactionType type, BuildContext context) {
    switch (type) {
      case TransactionType.income:
        return AppTheme.successColor;
      case TransactionType.expense:
        return Theme.of(context).colorScheme.error;
      case TransactionType.transfer:
        return Colors.blue;
    }
  }
}

class _TransactionTypeSelector extends StatelessWidget {
  const _TransactionTypeSelector({
    required this.selectedType,
    required this.onTypeChanged,
  });

  final TransactionType selectedType;
  final ValueChanged<TransactionType> onTypeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: TransactionType.values.map((type) {
          final isSelected = selectedType == type;
          final color = _getColor(type, context);

          return Expanded(
            child: GestureDetector(
              onTap: () => onTypeChanged(type),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? color.withValues(alpha: 0.15) : null,
                  borderRadius: BorderRadius.circular(12),
                  border: isSelected
                      ? Border.all(color: color.withValues(alpha: 0.5))
                      : null,
                ),
                child: Column(
                  children: [
                    Icon(
                      _getIcon(type),
                      color: isSelected ? color : theme.colorScheme.outline,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      type.displayName,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: isSelected ? color : theme.colorScheme.outline,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _getIcon(TransactionType type) {
    switch (type) {
      case TransactionType.income:
        return Icons.arrow_upward;
      case TransactionType.expense:
        return Icons.arrow_downward;
      case TransactionType.transfer:
        return Icons.swap_horiz;
    }
  }

  Color _getColor(TransactionType type, BuildContext context) {
    switch (type) {
      case TransactionType.income:
        return AppTheme.successColor;
      case TransactionType.expense:
        return Theme.of(context).colorScheme.error;
      case TransactionType.transfer:
        return Colors.blue;
    }
  }
}

class _AccountDropdown extends StatelessWidget {
  const _AccountDropdown({
    required this.label,
    required this.accounts,
    required this.selectedAccountId,
    required this.onChanged,
    this.excludeAccountId,
  });

  final String label;
  final List<AccountEntity> accounts;
  final String? selectedAccountId;
  final String? excludeAccountId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final availableAccounts = accounts
        .where((a) => a.id != excludeAccountId)
        .toList();

    // Ensure selectedAccountId is valid (exists in availableAccounts)
    final validSelectedId =
        availableAccounts.any(
          (a) => a.id == selectedAccountId,
        )
        ? selectedAccountId
        : null;

    return DropdownButtonFormField<String>(
      // Using value instead of initialValue since we need to update
      // the dropdown when state changes (controlled component pattern).
      // ignore: deprecated_member_use
      value: validSelectedId,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const Icon(Icons.account_balance_wallet),
      ),
      hint: const Text('Select account'),
      items: availableAccounts.map((account) {
        return DropdownMenuItem(
          value: account.id,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AccountTypeIcon(type: account.type, size: 24),
              const SizedBox(width: 12),
              Flexible(
                child: Text(
                  account.name,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                account.balance.toStringAsFixed(2),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}

class _CategoryDropdown extends StatelessWidget {
  const _CategoryDropdown({
    required this.categories,
    required this.selectedCategoryId,
    required this.onChanged,
  });

  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormBuilderDropdown<String>(
          name: 'category',
          initialValue: selectedCategoryId,
          decoration: InputDecoration(
            labelText: 'Category (Optional)',
            prefixIcon: const Icon(Icons.category_outlined),
            suffixIcon: categories.isEmpty
                ? IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () =>
                        context.pushNamed(AppRoutes.categories.name),
                    tooltip: 'Manage Categories',
                  )
                : null,
          ),
          items: [
            const DropdownMenuItem<String>(
              child: Text('No Category'),
            ),
            ...categories.map((category) {
              final color = Color(category.colorValue);
              final contrastColor = CategoryColors.contrastColor(color);

              return DropdownMenuItem(
                value: category.id,
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        IconData(
                          category.iconCodePoint,
                          fontFamily: 'MaterialIcons',
                        ),
                        size: 18,
                        color: contrastColor,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        category.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
          onChanged: onChanged,
        ),
        if (categories.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: () => context.pushNamed(AppRoutes.categories.name),
              icon: const Icon(Icons.settings, size: 16),
              label: Text(
                'Manage Categories',
                style: theme.textTheme.bodySmall,
              ),
            ),
          ),
      ],
    );
  }
}
