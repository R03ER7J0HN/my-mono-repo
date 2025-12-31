import 'package:budget_core/budget_core.dart';
import 'package:flutter/material.dart';

/// A compact icon button filter for account types that shows a bottom sheet
class AccountTypeFilter extends StatelessWidget {
  const AccountTypeFilter({
    required this.selectedAccountType,
    required this.onChanged,
    super.key,
  });

  /// Currently selected account type. Null means "All" accounts.
  final AccountType? selectedAccountType;

  /// Callback when account type selection changes
  final ValueChanged<AccountType?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasFilter = selectedAccountType != null;

    return IconButton(
      onPressed: () => _showFilterBottomSheet(context),
      style: IconButton.styleFrom(
        backgroundColor: hasFilter
            ? theme.colorScheme.primaryContainer
            : theme.colorScheme.surfaceContainerLow,
      ),
      icon: Icon(
        Icons.filter_list,
        color: hasFilter
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
      tooltip: selectedAccountType?.displayName ?? 'Filter by account type',
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    final theme = Theme.of(context);

    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Filter by Account Type',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // All accounts option
                _FilterOption(
                  icon: Icons.account_balance_wallet,
                  label: 'All Accounts',
                  isSelected: selectedAccountType == null,
                  onTap: () {
                    onChanged(null);
                    Navigator.pop(context);
                  },
                ),
                const Divider(height: 1),
                // Account type options
                ...AccountType.values.map((type) {
                  return _FilterOption(
                    icon: _getIconForAccountType(type),
                    label: type.displayName,
                    isSelected: selectedAccountType == type,
                    onTap: () {
                      onChanged(type);
                      Navigator.pop(context);
                    },
                  );
                }),
              ],
            ),
          ),
        );
      },
    );
  }

  IconData _getIconForAccountType(AccountType type) {
    switch (type) {
      case AccountType.cash:
        return Icons.payments;
      case AccountType.debitCard:
        return Icons.credit_card;
      case AccountType.creditCard:
        return Icons.credit_score;
      case AccountType.eWallet:
        return Icons.account_balance_wallet;
      case AccountType.savings:
        return Icons.savings;
    }
  }
}

class _FilterOption extends StatelessWidget {
  const _FilterOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurfaceVariant,
      ),
      title: Text(
        label,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: isSelected ? theme.colorScheme.primary : null,
          fontWeight: isSelected ? FontWeight.w600 : null,
        ),
      ),
      trailing: isSelected
          ? Icon(Icons.check, color: theme.colorScheme.primary)
          : null,
      onTap: onTap,
    );
  }
}
