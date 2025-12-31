import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuickActionsCard extends StatelessWidget {
  const QuickActionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _QuickActionButton(
                icon: Icons.add_circle_outline,
                label: 'Add\nIncome',
                color: Colors.green,
                onTap: () => context.pushNamed(
                  AppRoutes.transactionEntry.name,
                ),
              ),
              _QuickActionButton(
                icon: Icons.remove_circle_outline,
                label: 'Add\nExpense',
                color: Colors.red,
                onTap: () => context.pushNamed(
                  AppRoutes.transactionEntry.name,
                ),
              ),
              _QuickActionButton(
                icon: Icons.swap_horiz,
                label: 'Transfer\nMoney',
                color: Colors.blue,
                onTap: () => context.pushNamed(
                  AppRoutes.transactionEntry.name,
                ),
              ),
              _QuickActionButton(
                icon: Icons.pie_chart_outline,
                label: 'View\nAnalytics',
                color: Colors.teal,
                onTap: () => context.pushNamed(
                  AppRoutes.analytics.name,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
