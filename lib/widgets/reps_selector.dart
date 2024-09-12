import 'package:flutter/material.dart';
import '../core/constants.dart';

class RepsSelector extends StatelessWidget {
  final int selectedReps;
  final ValueChanged<int?>? onRepsChanged;

  RepsSelector({
    required this.selectedReps,
    this.onRepsChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: repetitions.contains(selectedReps) ? selectedReps : null, // Ensure valid value
      items: repetitions.map((int reps) {
        return DropdownMenuItem<int>(
          value: reps,
          child: Text('$reps reps'),
        );
      }).toList(),
      onChanged: onRepsChanged, // Callback when the value changes
      hint: Text('Select Reps'),
      isExpanded: true, // Expands to fit width
    );
  }
}
