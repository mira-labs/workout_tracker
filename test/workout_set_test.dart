import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/models/workout_set.dart';

void main() {
  group('WorkoutSet Model Tests', () {
    test('Create a WorkoutSet', () {
      final workoutSet = WorkoutSet(
        id: 'set_1',
        exercise: 'Bench Press',
        weight: 50.0,
        reps: 10,
        workoutId: 'workout_123',
      );

      expect(workoutSet.id, 'set_1');
      expect(workoutSet.exercise, 'Bench Press');
      expect(workoutSet.weight, 50.0);
      expect(workoutSet.reps, 10);
      expect(workoutSet.workoutId, 'workout_123');
    });

    test('Copy a WorkoutSet with modifications', () {
      final workoutSet = WorkoutSet(
        id: 'set_2',
        exercise: 'Deadlift',
        weight: 100.0,
        reps: 5,
        workoutId: 'workout_456',
      );

      final modifiedSet = workoutSet.copyWith(
        weight: 120.0,
        reps: 8,
      );

      expect(modifiedSet.weight, 120.0);
      expect(modifiedSet.reps, 8);
      expect(modifiedSet.exercise, 'Deadlift');
    });
  });
}
