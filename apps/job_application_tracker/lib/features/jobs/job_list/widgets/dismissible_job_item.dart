import 'package:flutter/material.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/job_list_item.dart';

class DismissibleJobItem extends StatefulWidget {
  const DismissibleJobItem({required this.job, this.onDismissed, super.key});

  final JobApplicationEntity job;

  final void Function(JobApplicationEntity job)? onDismissed;

  @override
  State<DismissibleJobItem> createState() => _DismissibleJobItemState();
}

class _DismissibleJobItemState extends State<DismissibleJobItem> {
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    final job = widget.job;

    return Dismissible(
      key: Key(job.id),
      direction: DismissDirection.endToStart,
      onUpdate: (details) {
        setState(() {
          _progress = details.progress;
        });
      },
      background: LayoutBuilder(
        builder: (context, constraints) {
          const iconSize = 32.0;

          final width = constraints.maxWidth;
          final revealedWidth = width * _progress;
          final rightOffset = (revealedWidth / 2) - (iconSize / 2);

          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.error,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Positioned(
              right: rightOffset,
              top: 0,
              bottom: 0,
              child: Center(
                child: Transform.scale(
                  scale: 1.0 + (_progress * 0.5),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                    size: iconSize,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      onDismissed: (direction) {
        widget.onDismissed?.call(job);
      },
      child: JobListItem(job: job),
    );
  }
}
