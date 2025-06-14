import 'package:flutter/material.dart';
import '../blink_text.dart';

/// A modal dialog that displays a warning message with blinking text.
///
/// Usage:
/// ```dart
/// WarningDialog.show(context, 'Something went wrong!');
/// ```
class WarningDialog extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Color iconColor;
  final Color fromColor;
  final Color toColor;
  final Duration blinkDuration;

  const WarningDialog({
    super.key,
    required this.message,
    this.backgroundColor = const Color(0xE00000EE),
    this.iconColor       = const Color(0xFFFFFF66),
    this.fromColor       = const Color(0xFFEE0000),
    this.toColor         = const Color(0xFFFFFF66),
    this.blinkDuration   = const Duration(seconds: 1),
  });

  /// Shows the warning dialog as a modal.
  static Future<void> show(
    BuildContext context,
    String message, {
    Color backgroundColor = const Color(0xE00000EE),
    Color iconColor       = const Color(0xFFFFFF66),
    Color fromColor       = const Color(0xFFEE0000),
    Color toColor         = const Color(0xFFFFFF66),
    Duration blinkDuration = const Duration(seconds: 1),
  }) {
    return showDialog(
      context: context,
      builder: (_) => WarningDialog(
        message: message,
        backgroundColor: backgroundColor,
        iconColor: iconColor,
        fromColor: fromColor,
        toColor: toColor,
        blinkDuration: blinkDuration,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
      content: Row(
        children: [
          Icon(Icons.warning_amber_rounded, color: iconColor),
          const SizedBox(width: 12),
          Expanded(
            child: BlinkText(
              text: message,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              fromColor: fromColor,
              toColor: toColor,
              duration: blinkDuration,
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('DISMISS'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
