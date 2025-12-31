import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/category_entry/cubit/category_entry_cubit.dart';
import 'package:budget_tracker/features/categories/category_entry/cubit/category_entry_state.dart';
import 'package:budget_tracker/features/categories/data/category_colors.dart';
import 'package:budget_tracker/features/categories/widgets/color_picker_dialog.dart';
import 'package:budget_tracker/features/categories/widgets/icon_picker_dialog.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/glass_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class CategoryEntryScreen extends StatelessWidget {
  const CategoryEntryScreen({
    this.category,
    super.key,
  });

  final CategoryEntity? category;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoryEntryCubit(
        categoryRepository: GetIt.I<CategoryRepository>(),
        existingCategory: category,
      ),
      child: const _CategoryEntryView(),
    );
  }
}

class _CategoryEntryView extends StatefulWidget {
  const _CategoryEntryView();

  @override
  State<_CategoryEntryView> createState() => _CategoryEntryViewState();
}

class _CategoryEntryViewState extends State<_CategoryEntryView> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<CategoryEntryCubit, CategoryEntryState>(
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
        final cubit = context.read<CategoryEntryCubit>();
        final contrastColor = CategoryColors.contrastColor(state.color);

        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.isEditing ? 'Edit Category' : 'New Category',
            ),
            actions: [
              TextButton(
                onPressed: state.isValid && !state.isSaving
                    ? () async {
                        if (_formKey.currentState?.saveAndValidate() ?? false) {
                          final success = await cubit.save();
                          if (success && context.mounted) {
                            context.pop();
                          }
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
              child: FormBuilder(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Preview Card
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Preview',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: state.color,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: state.color.withValues(alpha: 0.4),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Icon(
                              state.iconData,
                              size: 40,
                              color: contrastColor,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            state.name.isEmpty ? 'Category Name' : state.name,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Name Input
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Category Name',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          FormBuilderTextField(
                            name: 'name',
                            initialValue: state.name,
                            decoration: const InputDecoration(
                              hintText: 'Enter category name',
                              prefixIcon: Icon(Icons.label_outline),
                            ),
                            textCapitalization: TextCapitalization.words,
                            validator: FormBuilderValidators.required(),
                            onChanged: (value) => cubit.setName(value ?? ''),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Icon Selection
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Icon',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              final result = await IconPickerDialog.show(
                                context,
                                selectedCodePoint: state.iconCodePoint,
                              );
                              if (result != null) {
                                cubit.setIcon(result);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: theme.colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: state.color,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Icon(
                                      state.iconData,
                                      color: contrastColor,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      'Tap to change icon',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: theme.colorScheme.outline,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Color Selection
                    GlassCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Color',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () async {
                              final result = await ColorPickerDialog.show(
                                context,
                                selectedColor: state.color,
                              );
                              if (result != null) {
                                cubit.setColor(CategoryColors.toHex(result));
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: theme.colorScheme.surfaceContainerHighest
                                    .withValues(alpha: 0.3),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: BoxDecoration(
                                      color: state.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      'Tap to change color',
                                      style: theme.textTheme.bodyLarge,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: theme.colorScheme.outline,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
