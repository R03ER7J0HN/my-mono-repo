import 'package:budget_tracker/features/categories/data/category_colors.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';

/// A dialog widget for selecting a color from a grid of predefined colors
class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog({
    required this.selectedColor,
    super.key,
  });

  final Color selectedColor;

  static Future<Color?> show(BuildContext context, {Color? selectedColor}) {
    return showDialog<Color>(
      context: context,
      builder: (context) => ColorPickerDialog(
        selectedColor: selectedColor ?? Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = CategoryColors.all;
    final screenSize = MediaQuery.of(context).size;

    return Dialog(
      child: GlassCard(
        child: SizedBox(
          width: screenSize.width * 0.9,
          height: screenSize.height * 0.5,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Text(
                      'Select Color',
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
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: colors.length,
                  itemBuilder: (context, index) {
                    final color = colors[index];
                    final isSelected = _colorsEqual(color, selectedColor);

                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => Navigator.of(context).pop(color),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: color,
                          border: isSelected
                              ? Border.all(
                                  color: theme.colorScheme.onSurface,
                                  width: 3,
                                )
                              : Border.all(
                                  color: theme.colorScheme.outline.withValues(
                                    alpha: 0.3,
                                  ),
                                ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: color.withValues(alpha: 0.5),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ]
                              : null,
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                color: CategoryColors.contrastColor(color),
                              )
                            : null,
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

  bool _colorsEqual(Color a, Color b) {
    // Compare by value since Color objects might not be equal by reference
    // ignore: deprecated_member_use
    return a.value == b.value;
  }
}
