import 'package:flutter/material.dart';
import '../core/constants.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';
import 'weight_selector.dart';
import 'reps_selector.dart';
import 'exercise_selector.dart';

class WorkoutSetItem extends StatelessWidget {
  final WorkoutSet workoutSet;
  final ValueChanged<String>? onExerciseChanged; // Changed to non-nullable String
  final ValueChanged<double>? onWeightChanged; // Changed to non-nullable double
  final ValueChanged<int>? onRepsChanged; // Changed to non-nullable int
  final VoidCallback? onRemove;

  WorkoutSetItem({
    required this.workoutSet,
    this.onExerciseChanged,
    this.onWeightChanged,
    this.onRepsChanged,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: ExerciseSelector(
              selectedExercise: workoutSet.exercise,
              onExerciseChanged: (selectedExercise) {
                if (onExerciseChanged != null && selectedExercise != null) {
                  onExerciseChanged!(selectedExercise);
                }
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: WeightSelector(
              selectedWeight: workoutSet.weight,
              onWeightChanged: (selectedWeight) {
                if (onWeightChanged != null && selectedWeight != null) {
                  onWeightChanged!(selectedWeight);
                }
              },
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: RepsSelector(
              selectedReps: workoutSet.reps,
              onRepsChanged: (selectedReps) {
                if (onRepsChanged != null && selectedReps != null) {
                  onRepsChanged!(selectedReps);
                }
              },
            ),
          ),
          if (onRemove != null)
            IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: onRemove,
            ),
        ],
      ),
    );
  }
}
