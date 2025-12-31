import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/data/category_colors.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';

/// A list item widget for displaying a category with icon and color
class CategoryListItem extends StatelessWidget {
  const CategoryListItem({
    required this.category,
    this.onTap,
    this.onDelete,
    super.key,
  });

  final CategoryEntity category;
  final VoidCallback? onTap;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = Color(category.colorValue);
    final contrastColor = CategoryColors.contrastColor(color);

    return GlassCard(
      padding: EdgeInsets.zero,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            IconData(
              category.iconCodePoint,
              fontFamily: 'MaterialIcons',
            ),
            color: contrastColor,
          ),
        ),
        title: Text(
          category.name,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: category.isSystem
            ? Text(
                'System Category',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              )
            : null,
        trailing: category.isSystem
            ? Icon(
                Icons.lock_outline,
                color: theme.colorScheme.outline,
                size: 20,
              )
            : IconButton(
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.error,
                ),
              ),
        onTap: onTap,
      ),
    );
  }
}
