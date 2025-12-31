import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/widgets/glass_card.dart';

class InterviewListItem extends StatelessWidget {
  const InterviewListItem({
    required this.interview,
    this.onTap,
    this.onCalendarTap,
    super.key,
  });

  final JobInterviewEntity interview;
  final VoidCallback? onTap;
  final VoidCallback? onCalendarTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIcon(context),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        interview.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatDateTime(interview.startTime),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (interview.endTime != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          'Until ${_formatTime(interview.endTime!)}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                _buildStatusIndicator(context),
              ],
            ),
            if (interview.meetingUrl != null || interview.location != null) ...[
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  if (interview.meetingUrl != null)
                    _buildInfoChip(
                      context,
                      icon: Icons.video_call,
                      label: 'Virtual',
                    ),
                  if (interview.location != null)
                    _buildInfoChip(
                      context,
                      icon: Icons.location_on,
                      label: interview.location!.length > 20
                          ? '${interview.location!.substring(0, 20)}...'
                          : interview.location!,
                    ),
                ],
              ),
            ],
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!interview.addedToCalendar && onCalendarTap != null)
                  TextButton.icon(
                    onPressed: onCalendarTap,
                    icon: const Icon(Icons.calendar_month, size: 18),
                    label: const Text('Add to Calendar'),
                  ),
                if (interview.addedToCalendar)
                  Chip(
                    avatar: Icon(
                      Icons.check_circle,
                      size: 16,
                      color: colorScheme.primary,
                    ),
                    label: Text(
                      'In Calendar',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                      ),
                    ),
                    backgroundColor: colorScheme.primaryContainer.withValues(
                      alpha: 0.5,
                    ),
                    side: BorderSide.none,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.event,
        color: colorScheme.onSecondaryContainer,
      ),
    );
  }

  Widget _buildStatusIndicator(BuildContext context) {
    final now = DateTime.now();
    final isUpcoming = interview.startTime.isAfter(now);
    final isPast = interview.startTime.isBefore(now);
    final colorScheme = Theme.of(context).colorScheme;

    Color color;
    String label;

    if (isUpcoming) {
      final difference = interview.startTime.difference(now);
      if (difference.inDays == 0) {
        color = colorScheme.error;
        label = 'Today';
      } else if (difference.inDays == 1) {
        color = Colors.orange;
        label = 'Tomorrow';
      } else {
        color = colorScheme.primary;
        label = 'Upcoming';
      }
    } else if (isPast) {
      color = colorScheme.outline;
      label = 'Past';
    } else {
      color = colorScheme.primary;
      label = 'Now';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: colorScheme.onSurfaceVariant),
          const SizedBox(width: 4),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(dateTime.year, dateTime.month, dateTime.day);

    if (date == today) {
      return 'Today at ${DateFormat.jm().format(dateTime)}';
    } else if (date == today.add(const Duration(days: 1))) {
      return 'Tomorrow at ${DateFormat.jm().format(dateTime)}';
    } else {
      return DateFormat('EEE, MMM d').format(dateTime) +
          ' at ${DateFormat.jm().format(dateTime)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    return DateFormat.jm().format(dateTime);
  }
}
