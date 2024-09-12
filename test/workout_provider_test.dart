import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_set.dart';
import 'package:workout_tracker/providers/workout_provider.dart';
import 'package:workout_tracker/repositories/mock_workout_repository.dart';

void main() {
  group('WorkoutProvider Tests', () {
    late WorkoutProvider workoutProvider;
    late MockWorkoutRepository mockRepository;

    setUp(() {
      mockRepository = MockWorkoutRepository();
      workoutProvider = WorkoutProvider();
    });

    test('WorkoutProvider loads workouts from repository', () async {
      final workout = Workout(
        id: 'workout_1',
        createdDate: DateTime.now().toIso8601String(),
        sets: [],
      );
      await mockRepository.insertWorkout(workout);

      // Since the provider loads workouts in its constructor,
      // we need to wait until it finishes loading.
      await Future.delayed(Duration(milliseconds: 100));

      // Access the workouts from the provider
      expect(workoutProvider.workouts.length, 1);
      expect(workoutProvider.workouts[0].id, 'workout_1');
    });

    test('WorkoutProvider adds a new workout', () async {
      final workout = Workout(
        id: 'workout_2',
        createdDate: DateTime.now().toIso8601String(),
        sets: [],
      );

      await workoutProvider.addWorkout(workout);

      // Access the workouts from the provider
      expect(workoutProvider.workouts.length, 1);
      expect(workoutProvider.workouts[0].id, 'workout_2');
    });

    test('WorkoutProvider updates an existing workout', () async {
      final workout = Workout(
        id: 'workout_3',
        createdDate: DateTime.now().toIso8601String(),
        sets: [],
      );
      await workoutProvider.addWorkout(workout);

      final updatedWorkout = workout.copyWith(
        sets: [
          WorkoutSet(
            id: 'set_1',
            exercise: 'Deadlift',
            weight: 120.0,
            reps: 8,
            workoutId: 'workout_3',
          ),
        ],
      );
      await workoutProvider.updateWorkout(updatedWorkout);

      // Access the workouts from the provider
      expect(workoutProvider.workouts[0].sets.length, 1);
      expect(workoutProvider.workouts[0].sets[0].exercise, 'Deadlift');
    });

    test('WorkoutProvider deletes a workout', () async {
      final workout = Workout(
        id: 'workout_4',
        createdDate: DateTime.now().toIso8601String(),
        sets: [],
      );
      await workoutProvider.addWorkout(workout);

      await workoutProvider.deleteWorkout('workout_4');

      // Access the workouts from the provider
      expect(workoutProvider.workouts.isEmpty, true);
    });
  });
}
