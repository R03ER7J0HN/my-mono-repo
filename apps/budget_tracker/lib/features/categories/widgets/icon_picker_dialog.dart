import 'package:budget_tracker/features/categories/data/category_icons.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';

/// A dialog widget for selecting an icon from a grid of Material icons
class IconPickerDialog extends StatefulWidget {
  const IconPickerDialog({
    required this.selectedCodePoint,
    super.key,
  });

  final int selectedCodePoint;

  static Future<int?> show(BuildContext context, {int? selectedCodePoint}) {
    return showDialog<int>(
      context: context,
      builder: (context) => IconPickerDialog(
        selectedCodePoint: selectedCodePoint ?? Icons.category.codePoint,
      ),
    );
  }

  @override
  State<IconPickerDialog> createState() => _IconPickerDialogState();
}

class _IconPickerDialogState extends State<IconPickerDialog> {
  late final TextEditingController _searchController;
  late List<IconData> _filteredIcons;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _filteredIcons = CategoryIcons.all;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      child: GlassCard(
        child: SizedBox(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.7,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Select Icon',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _filteredIcons.length,
                  itemBuilder: (context, index) {
                    final icon = _filteredIcons[index];
                    final isSelected =
                        icon.codePoint == widget.selectedCodePoint;

                    return InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () => Navigator.of(context).pop(icon.codePoint),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: isSelected
                              ? theme.colorScheme.primary.withValues(alpha: 0.2)
                              : theme.colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                          border: isSelected
                              ? Border.all(
                                  color: theme.colorScheme.primary,
                                  width: 2,
                                )
                              : null,
                        ),
                        child: Icon(
                          icon,
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
