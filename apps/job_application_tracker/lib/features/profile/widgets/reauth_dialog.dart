import 'package:flutter/material.dart';

class ReauthDialog extends StatefulWidget {
  const ReauthDialog({super.key});

  @override
  State<ReauthDialog> createState() => _ReauthDialogState();
}

class _ReauthDialogState extends State<ReauthDialog> {
  final _controller = TextEditingController();
  final _isButtonEnabled = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _controller.dispose();
    _isButtonEnabled.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirm Password'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '''
For security reasons, please enter your password to confirm account deletion.''',
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _controller,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            onChanged: (value) {
              _isButtonEnabled.value = value.isNotEmpty;
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ValueListenableBuilder(
          valueListenable: _isButtonEnabled,
          builder: (context, isEnabled, child) {
            return FilledButton(
              onPressed: isEnabled
                  ? () => Navigator.pop(context, _controller.text)
                  : null,
              child: const Text('Confirm'),
            );
          },
        ),
      ],
    );
  }
}
