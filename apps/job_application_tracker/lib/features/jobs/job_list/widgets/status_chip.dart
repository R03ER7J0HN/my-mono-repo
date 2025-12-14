import 'package:flutter/material.dart';
import 'package:job_application/job_application.dart';

class StatusChip extends StatelessWidget {
  const StatusChip({required this.status, super.key});

  final JobStatus status;

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      JobStatus.applied => Colors.blue,
      JobStatus.interviewing => Colors.orange,
      JobStatus.offer => Colors.green,
      JobStatus.rejected => Colors.red,
      JobStatus.ghosted => Colors.grey,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        status.name.toUpperCase(),
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
