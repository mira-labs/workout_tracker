import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../lib/providers/workout_provider.dart';
import '../lib/models/workout.dart';
import '../lib/models/workout_set.dart';
import '../lib/repositories/mock_workout_repository.dart';

void main() {
  late WorkoutProvider provider;

  setUp(() {
    provider = WorkoutProvider(repository: MockWorkoutRepository());
  });

  test('Add workout', () async {
    final workout = Workout(
      id: 'test_id',
      createdDate: '2024-09-11T12:29:00.000',
      sets: [
        WorkoutSet(
          id: 'set_id',
          exercise: 'Lunges',
          weight: 40.0,
          reps: 10,
        ),
      ],
    );

    await provider.addWorkout(workout);
    final workouts = await provider.getWorkouts();

    expect(workouts.length, 1);
    expect(workouts[0].id, workout.id);
  });

  test('Update workout', () async {
    final workout = Workout(
      id: 'test_id',
      createdDate: '2024-09-11T12:29:00.000',
      sets: [
        WorkoutSet(
          id: 'set_id',
          exercise: 'Pull Ups',
          weight: 0.0,
          reps: 12,
        ),
      ],
    );

    await provider.addWorkout(workout);
    workout.sets[0] = workout.sets[0].copyWith(reps: 15);
    await provider.updateWorkout(workout);
    final workouts = await provider.getWorkouts();

    expect(workouts[0].sets[0].reps, 15);
  });

  test('Delete workout', () async {
    final workout = Workout(
      id: 'test_id',
      createdDate: '2024-09-11T12:29:00.000',
      sets: [
        WorkoutSet(
          id: 'set_id',
          exercise: 'Dips',
          weight: 0.0,
          reps: 20,
        ),
      ],
    );

    await provider.addWorkout(workout);
    await provider.deleteWorkout(workout.id);
    final workouts = await provider.getWorkouts();

    expect(workouts.isEmpty, true);
  });
}
