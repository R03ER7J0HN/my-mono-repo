import 'package:flutter/material.dart';

/// View displayed when location services are disabled on the device.
class ServiceDisabledView extends StatelessWidget {
  const ServiceDisabledView({
    required this.onOpenSettings,
    required this.onRetry,
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;
  final VoidCallback onOpenSettings;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_off, size: 64),
            const SizedBox(height: 16),
            const Text(
              'Location Services Disabled',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ??
                  'Location services are disabled. Please enable them.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: onOpenSettings,
              icon: const Icon(Icons.settings),
              label: const Text('Open Location Settings'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: onRetry,
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}
