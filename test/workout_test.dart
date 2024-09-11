import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_set.dart';

void main() {
  group('Workout Model Tests', () {
    test('Create a Workout with sets', () {
      final workoutSet1 = WorkoutSet(
        id: 'set_1',
        exercise: 'Bench Press',
        weight: 50.0,
        reps: 10,
        workoutId: 'workout_123',
      );
      final workoutSet2 = WorkoutSet(
        id: 'set_2',
        exercise: 'Deadlift',
        weight: 100.0,
        reps: 5,
        workoutId: 'workout_123',
      );

      final workout = Workout(
        id: 'workout_123',
        createdDate: DateTime.now().toIso8601String(),
        sets: [workoutSet1, workoutSet2],
      );

      expect(workout.id, 'workout_123');
      expect(workout.sets.length, 2);
      expect(workout.sets[0].exercise, 'Bench Press');
      expect(workout.sets[1].weight, 100.0);
    });

    test('Update workout set details', () {
      final workoutSet = WorkoutSet(
        id: 'set_1',
        exercise: 'Squat',
        weight: 80.0,
        reps: 8,
        workoutId: 'workout_456',
      );

      final updatedSet = workoutSet.copyWith(
        weight: 90.0,
        reps: 10,
      );

      expect(updatedSet.weight, 90.0);
      expect(updatedSet.reps, 10);
      expect(updatedSet.exercise, 'Squat');
    });
  });
}
