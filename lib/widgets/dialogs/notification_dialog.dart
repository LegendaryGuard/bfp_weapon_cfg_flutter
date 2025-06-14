import 'package:flutter/material.dart';

/// A modal dialog that displays an informational message.
///
/// Maintains styling similar to [SnackBarNotify], but as a dialog.
///
/// Usage:
/// ```dart
/// NotificationDialog.show(
///   context,
///   'Operation successful',
/// );
/// ```
class NotificationDialog extends StatelessWidget {
  /// The message to display.
  final String message;

  /// Background color of the dialog.
  final Color backgroundColor;

  /// Text color for the message.
  final Color textColor;

  /// Creates a [NotificationDialog].
  const NotificationDialog({
    super.key,
    required this.message,
    this.backgroundColor = const Color(0xFFFFFF66),
    this.textColor       = const Color(0xFF0000EE),
  });

  /// Shows the notification dialog as a modal.
  static Future<void> show(
    BuildContext context,
    String message, {
    Color backgroundColor = const Color(0xFFFFFF66),
    Color textColor       = const Color(0xFF0000EE),
  }) {
    return showDialog(
      context: context,
      builder: (_) => NotificationDialog(
        message: message,
        backgroundColor: backgroundColor,
        textColor: textColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          Icon(Icons.info_outline, color: textColor),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: TextStyle(color: textColor, fontSize: 16),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text(
            'DISMISS',
            style: TextStyle(color: Color(0xFF000000)),
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}
