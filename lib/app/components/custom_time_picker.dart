import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTimePicker extends StatelessWidget {
  const CustomTimePicker({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final TimeOfDay? value;
  final ValueChanged<TimeOfDay>? onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final inputTheme = theme.inputDecorationTheme;

    final border = inputTheme.enabledBorder as OutlineInputBorder?;
    final borderColor = border?.borderSide.color ?? Colors.grey;
    final borderRadius = border?.borderRadius ?? BorderRadius.circular(8);

    return GestureDetector(
      onTap: () {
        SystemSound.play(SystemSoundType.click);
        showTimePicker(
          context: context,
          initialTime: value ?? TimeOfDay.now(),
        ).then((value) {
          if (value != null) {
            _handleValueChange(value);
          }
        });
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: theme.inputDecorationTheme.fillColor ?? Colors.white,
          border: Border.all(color: borderColor),
          borderRadius: borderRadius,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              value?.format(context) ?? '--:-- --',
            ),
            Icon(Icons.access_time, color: theme.inputDecorationTheme.labelStyle?.color),
          ],
        ),
      ),
    );
  }

  void _handleValueChange(TimeOfDay value) {
    assert(onChanged != null);
    if (value != this.value) {
      onChanged!(value);
    }
  }
}
