import 'package:flutter/material.dart';

class DarkModeSwitch extends StatefulWidget {
  final bool isDarkMode;
  final ValueChanged<bool> onToggle;

  const DarkModeSwitch({
    super.key,
    required this.isDarkMode,
    required this.onToggle,
  });

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: widget.isDarkMode ? Colors.amber : Colors.grey,
          size: 20,
        ),
        Switch(
          value: widget.isDarkMode,
          onChanged: widget.onToggle,
          activeTrackColor: Color(0xff92A3FD).withValues(alpha: 0.5),
          activeThumbColor: Color(0xff92A3FD),
        ),
      ],
    );
  }
}
