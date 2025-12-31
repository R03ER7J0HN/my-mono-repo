import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/theme/app_theme.dart';
import 'package:budget_tracker/widgets/budget_widgets.dart';
import 'package:budget_tracker/widgets/confirmation_bottom_sheet.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InstallmentListItem extends StatelessWidget {
  const InstallmentListItem({
    required this.installment,
    required this.accountName,
    required this.onTap,
    required this.onPaymentMade,
    required this.onDelete,
    super.key,
  });

  final InstallmentEntity installment;
  final String accountName;
  final VoidCallback onTap;
  final VoidCallback? onPaymentMade;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = installment.isFullyPaid;

    return Dismissible(
      key: Key(installment.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) => showConfirmationBottomSheet(
        context: context,
        title: 'Delete Installment',
        message: 'Are you sure you want to delete this installment plan?',
        confirmLabel: 'Delete',
        icon: Icons.delete_outline,
        isDanger: true,
      ),
      onDismissed: (_) => onDelete(),
      background: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      child: GlassCard(
        onTap: onTap,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        installment.description,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isCompleted ? theme.colorScheme.outline : null,
                          decoration: isCompleted
                              ? TextDecoration.lineThrough
                              : null,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.credit_card,
                            size: 14,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            accountName,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Ends '
                            '${DateFormat.yMMMd().format(installment.endDate)}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                if (isCompleted)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14,
                          color: AppTheme.successColor,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Paid',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: AppTheme.successColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            BudgetProgressIndicator(
              current: installment.paidInstallments.toDouble(),
              limit: installment.totalInstallments.toDouble(),
              label: 'payments completed',
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${installment.paidInstallments}/${installment.totalInstallments} payments',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
                Text(
                  '${installment.monthlyAmount.toStringAsFixed(2)}/mo',
                  style: theme.textTheme.labelMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            if (!isCompleted) ...[
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Remaining',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                      Text(
                        installment.remainingAmount.toStringAsFixed(2),
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ],
                  ),
                  if (onPaymentMade != null)
                    OutlinedButton.icon(
                      onPressed: () => _confirmPayment(context),
                      icon: const Icon(Icons.check, size: 18),
                      label: const Text('Mark Paid'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.successColor,
                        side: BorderSide(color: AppTheme.successColor),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _confirmPayment(BuildContext context) async {
    final confirmed = await showConfirmationBottomSheet(
      context: context,
      title: 'Mark Payment Made',
      message:
          'Mark payment ${installment.paidInstallments + 1} of '
          '${installment.totalInstallments} as paid?',
      icon: Icons.check_circle_outline,
    );

    if (confirmed) {
      onPaymentMade?.call();
    }
  }
}
