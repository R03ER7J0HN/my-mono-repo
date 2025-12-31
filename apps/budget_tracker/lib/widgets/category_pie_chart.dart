import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/data/category_colors.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// A data class representing a category's spending/income
class CategoryBreakdownItem {
  const CategoryBreakdownItem({
    required this.categoryId,
    required this.categoryName,
    required this.iconCodePoint,
    required this.colorValue,
    required this.amount,
  });

  final String? categoryId;
  final String categoryName;
  final int iconCodePoint;
  final int colorValue;
  final double amount;
}

/// A pie chart widget showing expense/income breakdown by category
class CategoryPieChart extends StatefulWidget {
  const CategoryPieChart({
    required this.transactions,
    required this.categories,
    this.transactionType,
    this.title,
    super.key,
  });

  final List<TransactionEntity> transactions;
  final List<CategoryEntity> categories;

  /// If null, shows all transactions (income + expense merged)
  final TransactionType? transactionType;
  final String? title;

  @override
  State<CategoryPieChart> createState() => _CategoryPieChartState();
}

class _CategoryPieChartState extends State<CategoryPieChart> {
  int _touchedIndex = -1;

  List<CategoryBreakdownItem> _calculateBreakdown() {
    // Filter transactions by type if specified, otherwise use all
    final filteredTransactions = widget.transactionType != null
        ? widget.transactions
              .where((t) => t.type == widget.transactionType)
              .toList()
        : widget.transactions;

    if (filteredTransactions.isEmpty) return [];

    // Group by category
    final categoryTotals = <String?, double>{};
    for (final transaction in filteredTransactions) {
      final categoryId = transaction.categoryId;
      categoryTotals[categoryId] =
          (categoryTotals[categoryId] ?? 0) + transaction.amount;
    }

    // Build breakdown items
    final items = <CategoryBreakdownItem>[];
    for (final entry in categoryTotals.entries) {
      final category = widget.categories
          .where((c) => c.id == entry.key)
          .firstOrNull;

      items.add(
        CategoryBreakdownItem(
          categoryId: entry.key,
          categoryName: category?.name ?? 'Uncategorized',
          iconCodePoint: category?.iconCodePoint ?? Icons.category.codePoint,
          colorValue: category?.colorValue ?? 0xFF9E9E9E,
          amount: entry.value,
        ),
      );
    }

    // Sort by amount descending
    items.sort((a, b) => b.amount.compareTo(a.amount));
    return items;
  }

  String get _defaultTitle {
    if (widget.transactionType == null) {
      return 'Spending by Category';
    }
    return '${widget.transactionType!.displayName} by Category';
  }

  String get _emptyMessage {
    if (widget.transactionType == null) {
      return 'No transaction data';
    }
    return 'No ${widget.transactionType!.displayName.toLowerCase()} data';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final breakdown = _calculateBreakdown();
    final total = breakdown.fold<double>(0, (sum, item) => sum + item.amount);

    if (breakdown.isEmpty) {
      return GlassCard(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title ?? _defaultTitle,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                _emptyMessage,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? _defaultTitle,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: Row(
              children: [
                Expanded(
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              _touchedIndex = -1;
                              return;
                            }
                            _touchedIndex = pieTouchResponse
                                .touchedSection!
                                .touchedSectionIndex;
                          });
                        },
                      ),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: _buildPieSections(breakdown, total),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildLegend(breakdown, total, theme),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _buildPieSections(
    List<CategoryBreakdownItem> breakdown,
    double total,
  ) {
    return breakdown.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final isTouched = index == _touchedIndex;
      final percentage = item.amount / total * 100;
      final color = Color(item.colorValue);

      return PieChartSectionData(
        color: color,
        value: item.amount,
        title: isTouched ? '${percentage.toStringAsFixed(1)}%' : '',
        radius: isTouched ? 60 : 50,
        titleStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: CategoryColors.contrastColor(color),
        ),
        badgeWidget: isTouched
            ? null
            : Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: color.withValues(alpha: 0.4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Icon(
                  IconData(item.iconCodePoint, fontFamily: 'MaterialIcons'),
                  size: 12,
                  color: CategoryColors.contrastColor(color),
                ),
              ),
        badgePositionPercentageOffset: 1.1,
      );
    }).toList();
  }

  Widget _buildLegend(
    List<CategoryBreakdownItem> breakdown,
    double total,
    ThemeData theme,
  ) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: breakdown.take(5).map((item) {
          final percentage = item.amount / total * 100;
          final color = Color(item.colorValue);

          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    item.categoryName,
                    style: theme.textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${percentage.toStringAsFixed(1)}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
