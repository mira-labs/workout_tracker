import 'package:flutter_test/flutter_test.dart';
import '../lib/models/workout_set.dart';

void main() {
  test('WorkoutSet model toMap and fromMap should work correctly', () {
    final workoutSet = WorkoutSet(
      id: 'set_id',
      exercise: 'Push Up',
      weight: 20.0,
      reps: 15,
    );

    final workoutSetMap = workoutSet.toMap();
    final newWorkoutSet = WorkoutSet.fromMap(workoutSetMap);

    expect(newWorkoutSet.id, workoutSet.id);
    expect(newWorkoutSet.exercise, workoutSet.exercise);
    expect(newWorkoutSet.weight, workoutSet.weight);
    expect(newWorkoutSet.reps, workoutSet.reps);
  });
}
