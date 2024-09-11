import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../lib/repositories/workout_repository_impl.dart';
import '../lib/models/workout.dart';
import '../lib/models/workout_set.dart';

void main() {
  late WorkoutRepositoryImpl repository;

  setUp(() async {
    await Hive.initFlutter();
    repository = WorkoutRepositoryImpl();
    await repository.openBox();
  });

  test('Insert and get workout', () async {
    final workout = Workout(
      id: 'test_id',
      createdDate: '2024-09-11T12:29:00.000',
      sets: [
        WorkoutSet(
          id: 'set_id',
          exercise: 'Deadlift',
          weight: 100.0,
          reps: 5,
        ),
      ],
    );

    await repository.insertWorkout(workout);
    final workouts = await repository.getWorkouts();

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
          exercise: 'Bench Press',
          weight: 80.0,
          reps: 8,
        ),
      ],
    );

    await repository.insertWorkout(workout);
    workout.sets[0] = workout.sets[0].copyWith(weight: 85.0);
    await repository.updateWorkout(workout);
    final workouts = await repository.getWorkouts();

    expect(workouts[0].sets[0].weight, 85.0);
  });

  test('Delete workout', () async {
    final workout = Workout(
      id: 'test_id',
      createdDate: '2024-09-11T12:29:00.000',
      sets: [
        WorkoutSet(
          id: 'set_id',
          exercise: 'Squat',
          weight: 60.0,
          reps: 12,
        ),
      ],
    );

    await repository.insertWorkout(workout);
    await repository.deleteWorkout(workout.id);
    final workouts = await repository.getWorkouts();

    expect(workouts.isEmpty, true);
  });
}
