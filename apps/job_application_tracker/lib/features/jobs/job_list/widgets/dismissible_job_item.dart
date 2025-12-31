import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_application/job_application.dart';
import 'package:job_application_tracker/features/jobs/job_list/widgets/job_list_item.dart';
import 'package:job_application_tracker/widgets/confirmation_bottom_sheet.dart';

class SwipeToDeleteController extends ChangeNotifier {
  String? _openItemId;

  String? get openItemId => _openItemId;

  void open(String id) {
    if (_openItemId != id) {
      _openItemId = id;
      notifyListeners();
    }
  }

  void close(String id) {
    if (_openItemId == id) {
      _openItemId = null;
      notifyListeners();
    }
  }

  void closeAll() {
    if (_openItemId != null) {
      _openItemId = null;
      notifyListeners();
    }
  }

  bool isOpen(String id) => _openItemId == id;
}

class DismissibleJobItem extends StatefulWidget {
  const DismissibleJobItem({
    required this.job,
    required this.controller,
    this.onTap,
    this.onInterviewsTap,
    this.onDismissed,
    super.key,
  });

  final JobApplicationEntity job;
  final SwipeToDeleteController controller;
  final VoidCallback? onTap;
  final VoidCallback? onInterviewsTap;
  final void Function(JobApplicationEntity job)? onDismissed;

  @override
  State<DismissibleJobItem> createState() => _DismissibleJobItemState();
}

class _DismissibleJobItemState extends State<DismissibleJobItem> {
  static const double _deleteButtonWidth = 80;
  static const double _dragThreshold = 0.3;

  double _dragExtent = 0;

  bool get _isOpen => widget.controller.isOpen(widget.job.id);

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onControllerChanged);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onControllerChanged);
    super.dispose();
  }

  void _onControllerChanged() {
    if (mounted) {
      setState(() {
        _dragExtent = _isOpen ? _deleteButtonWidth : 0;
      });
    }
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final delta = details.primaryDelta ?? 0;
    setState(() {
      _dragExtent = (_dragExtent - delta).clamp(0, _deleteButtonWidth);
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;

    if (velocity < -300 || _dragExtent > _deleteButtonWidth * _dragThreshold) {
      widget.controller.open(widget.job.id);
    } else {
      widget.controller.close(widget.job.id);
    }
  }

  Future<void> _showDeleteConfirmation() async {
    unawaited(HapticFeedback.mediumImpact());

    await ConfirmationBottomSheet.show<void>(
      context,
      title: 'Delete Application',
      message:
          'Are you sure you want to delete the application for '
          '"${widget.job.jobTitle}" at "${widget.job.companyName}"?',
      confirmWidget: const Text('Delete'),
      isDestructive: true,
      onConfirm: () {
        widget.onDismissed?.call(widget.job);
      },
    );

    widget.controller.close(widget.job.id);
  }

  @override
  Widget build(BuildContext context) {
    final offset = _isOpen ? _deleteButtonWidth : _dragExtent;

    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      onTap: () {
        widget.controller.closeAll();
        widget.onTap?.call();
      },
      child: Stack(
        children: [
          _buildDeleteButton(context, offset),
          AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            transform: Matrix4.translationValues(-offset, 0, 0),
            child: JobListItem(
              job: widget.job,
              onInterviewsTap: widget.onInterviewsTap,
            ),
          ),
        ],
      ),
    );
  }

  Positioned _buildDeleteButton(BuildContext context, double offset) {
    return Positioned.fill(
      child: Align(
        alignment: Alignment.centerRight,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: offset,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.error,
            borderRadius: BorderRadius.circular(24),
          ),
          child: offset > _deleteButtonWidth * 0.5
              ? Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: _showDeleteConfirmation,
                    borderRadius: BorderRadius.circular(24),
                    child: const Center(
                      child: Icon(
                        Icons.delete_rounded,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
