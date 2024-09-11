import 'package:flutter/material.dart';
import '../core/constants.dart';

class ExerciseSelector extends StatelessWidget {
  final String selectedExercise;
  final ValueChanged<String?>? onExerciseChanged;

  ExerciseSelector({
    required this.selectedExercise,
    this.onExerciseChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedExercise,
      items: exercises.map((String exercise) {
        return DropdownMenuItem<String>(
          value: exercise,
          child: Text(exercise),
        );
      }).toList(),
      onChanged: onExerciseChanged,
      hint: Text('Select Exercise'),
      isExpanded: true,
    );
  }
}
