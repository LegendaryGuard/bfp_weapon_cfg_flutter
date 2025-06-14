import 'package:flutter/material.dart';

/// A widget that displays blinking text by toggling instantly between two colors.
///
/// The text color switches from [fromColor] to [toColor] every half-cycle of the specified [duration].
/// This creates a hard blink effect (no fade) reminiscent of CSS keyframe blinking.
///
/// Example usage:
/// ```dart
/// BlinkText(
///   text: 'Error: Invalid input',
///   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
///   fromColor: Colors.red,
///   toColor: Colors.blue,
///   duration: Duration(seconds: 1),
/// )
/// ```
class BlinkText extends StatefulWidget {
  /// The string to display. Cannot be null.
  final String text;

  /// Optional base style for the text. The blinking color will override [style.color].
  final TextStyle? style;

  /// Total duration of one blink cycle (from [fromColor] → [toColor] → [fromColor]).
  ///
  /// Defaults to 1 second.
  final Duration duration;

  /// The color to show for the first half of each blink cycle.
  ///
  /// Defaults to a yellowish color (`#FFFF66`).
  final Color fromColor;

  /// The color to show for the second half of each blink cycle.
  ///
  /// Defaults to a pure red (`#EE0000`).
  final Color toColor;

  /// Creates a [BlinkText] widget.
  ///
  /// [text] must not be null. Other parameters are optional.
  const BlinkText({
    super.key,
    required this.text,
    this.style,
    this.duration = const Duration(seconds: 1),
    this.fromColor = const Color(0xFFFFFF66),
    this.toColor = const Color(0xFFEE0000),
  });

  @override
  State<BlinkText> createState() => _BlinkTextState();
}

class _BlinkTextState extends State<BlinkText>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        // Instant switch halfway through each cycle
        final color = _ctrl.value < 0.5 ? widget.fromColor : widget.toColor;
        return Text(
          widget.text,
          style: widget.style?.copyWith(color: color) ??
              TextStyle(color: color),
        );
      },
    );
  }
}