import 'package:flutter/material.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({super.key});

  @override
  State<DarkModeSwitch> createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          isDarkMode ? Icons.dark_mode : Icons.light_mode,
          color: isDarkMode ? Colors.amber : Colors.grey,
          size: 20,
        ),
        Switch(
          value: isDarkMode,
          onChanged: (value) {
            setState(() {
              isDarkMode = value;
            });
          },
          activeTrackColor: Color(0xff92A3FD).withValues(alpha: 0.5),
          activeThumbColor: Color(0xff92A3FD),
        ),
      ],
    );
  }
}
