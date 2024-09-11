import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/models/workout.dart';
import 'package:workout_tracker/models/workout_set.dart';
import 'package:workout_tracker/repositories/mock_workout_repository.dart';

void main() {
  group('MockWorkoutRepository Tests', () {
    late MockWorkoutRepository mockRepository;

    setUp(() {
      mockRepository = MockWorkoutRepository();
    });

    test('Insert and retrieve workouts', () async {
      final workout = Workout(
        id: 'workout_1',
        createdDate: DateTime.now().toIso8601String(),
        sets: [
          WorkoutSet(
            id: 'set_1',
            exercise: 'Squat',
            weight: 80.0,
            reps: 10,
            workoutId: 'workout_1',
          ),
        ],
      );

      await mockRepository.insertWorkout(workout);

      final workouts = await mockRepository.getWorkouts();
      expect(workouts.length, 1);
      expect(workouts[0].id, 'workout_1');
      expect(workouts[0].sets[0].exercise, 'Squat');
    });

    test('Update a workout', () async {
      final workout = Workout(
        id: 'workout_2',
        createdDate: DateTime.now().toIso8601String(),
        sets: [],
      );

      await mockRepository.insertWorkout(workout);

      final updatedWorkout = workout.copyWith(
        sets: [
          WorkoutSet(
            id: 'set_1',
            exercise: 'Deadlift',
            weight: 150.0,
            reps: 5,
            workoutId: 'workout_2',
          ),
        ],
      );

      await mockRepository.updateWorkout(updatedWorkout);

      final workouts = await mockRepository.getWorkouts();
      expect(workouts[0].sets[0].exercise, 'Deadlift');
    });

    test('Delete a workout', () async {
      final workout = Workout(
        id: 'workout_3',
        createdDate: DateTime.now().toIso8601String(),
        sets: [],
      );

      await mockRepository.insertWorkout(workout);

      await mockRepository.deleteWorkout('workout_3');

      final workouts = await mockRepository.getWorkouts();
      expect(workouts.isEmpty, true);
    });
  });
}
