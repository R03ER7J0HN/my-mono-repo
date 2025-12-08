import 'package:flutter/material.dart';

class ConfirmationBottomSheet extends StatelessWidget {
  const ConfirmationBottomSheet({
    required this.title,
    required this.message,
    required this.onConfirm,
    this.confirmWidget = const Text('Confirm'),
    this.cancelWidget = const Text('Cancel'),
    this.isDestructive = false,
    super.key,
  });

  final String title;
  final String message;
  final VoidCallback onConfirm;
  final Widget confirmWidget;
  final Widget cancelWidget;
  final bool isDestructive;

  static Future<void> show(
    BuildContext context, {
    required String title,
    required String message,
    required VoidCallback onConfirm,
    Widget confirmWidget = const Text('Confirm'),
    Widget cancelWidget = const Text('Cancel'),
    bool isDestructive = false,
    bool useRootNavigator = true,
  }) => showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: useRootNavigator,
    builder: (context) => ConfirmationBottomSheet(
      title: title,
      message: message,
      onConfirm: onConfirm,
      confirmWidget: confirmWidget,
      cancelWidget: cancelWidget,
      isDestructive: isDestructive,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDragHandle(context),
            const SizedBox(height: 24),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      side: BorderSide(
                        color: colorScheme.outline.withValues(alpha: 0.5),
                      ),
                    ),
                    child: cancelWidget,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      onConfirm();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: isDestructive
                          ? colorScheme.error
                          : colorScheme.primary,
                      foregroundColor: isDestructive
                          ? colorScheme.onError
                          : colorScheme.onPrimary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: confirmWidget,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDragHandle(BuildContext context) {
    return Container(
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withAlpha(51),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}
