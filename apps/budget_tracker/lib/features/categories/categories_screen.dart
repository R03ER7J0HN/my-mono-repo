import 'dart:async';

import 'package:budget_core/budget_core.dart';
import 'package:budget_tracker/features/categories/cubit/categories_cubit.dart';
import 'package:budget_tracker/features/categories/cubit/categories_state.dart';
import 'package:budget_tracker/features/categories/widgets/category_list_item.dart';
import 'package:budget_tracker/router/app_routes.dart';
import 'package:budget_tracker/widgets/background_decoration.dart';
import 'package:budget_tracker/widgets/confirmation_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesCubit(
        categoryRepository: GetIt.I<CategoryRepository>(),
      ),
      child: const _CategoriesView(),
    );
  }
}

class _CategoriesView extends StatelessWidget {
  const _CategoriesView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<CategoriesCubit, CategoriesState>(
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
        final cubit = context.read<CategoriesCubit>();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
          ),
          body: BackgroundDecoration(
            child: _buildBody(context, state, cubit),
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              unawaited(context.pushNamed(AppRoutes.categoryEntry.name));
            },
            icon: const Icon(Icons.add),
            label: const Text('Add Category'),
          ),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    CategoriesState state,
    CategoriesCubit cubit,
  ) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.categories.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.category_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No categories yet',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the button below to add one',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ],
        ),
      );
    }

    // Group categories by system/custom
    final systemCategories = state.categories.where((c) => c.isSystem).toList();
    final customCategories = state.categories
        .where((c) => !c.isSystem)
        .toList();

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (customCategories.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Custom Categories',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ...customCategories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CategoryListItem(
                category: category,
                onTap: () {
                  unawaited(
                    context.pushNamed(
                      AppRoutes.categoryEntry.name,
                      extra: category,
                    ),
                  );
                },
                onDelete: () =>
                    unawaited(_confirmDelete(context, category, cubit)),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (systemCategories.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'System Categories',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
          ),
          ...systemCategories.map(
            (category) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: CategoryListItem(
                category: category,
                onTap: () {
                  unawaited(
                    context.pushNamed(
                      AppRoutes.categoryEntry.name,
                      extra: category,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
        // Bottom padding for FAB
        const SizedBox(height: 80),
      ],
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    CategoryEntity category,
    CategoriesCubit cubit,
  ) async {
    final confirmed = await showConfirmationBottomSheet(
      context: context,
      title: 'Delete Category',
      message: 'Are you sure you want to delete "${category.name}"?',
      confirmLabel: 'Delete',
      icon: Icons.delete_outline,
      isDanger: true,
    );

    if (confirmed) {
      await cubit.deleteCategory(category);
    }
  }
}
