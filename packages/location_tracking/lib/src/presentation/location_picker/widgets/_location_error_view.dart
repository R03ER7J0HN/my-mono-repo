import 'package:flutter/material.dart';

class LocationErrorView extends StatelessWidget {
  const LocationErrorView({
    required this.onRetry,
    super.key,
    this.errorMessage,
  });

  final String? errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_off, size: 48),
          const SizedBox(height: 16),
          Text(errorMessage ?? 'Could not get location'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
