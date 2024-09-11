import 'package:flutter_test/flutter_test.dart';
import '../lib/models/workout.dart';
import '../lib/models/workout_set.dart';

void main() {
  test('Workout model toMap and fromMap should work correctly', () {
    final workout = Workout(
      id: 'test_id',
      createdDate: '2024-09-11T12:29:00.000',
      sets: [
        WorkoutSet(
          id: 'set_id',
          exercise: 'Squat',
          weight: 50.0,
          reps: 10,
        ),
      ],
    );

    final workoutMap = workout.toMap();
    final newWorkout = Workout.fromMap(workoutMap);

    expect(newWorkout.id, workout.id);
    expect(newWorkout.createdDate, workout.createdDate);
    expect(newWorkout.sets.length, workout.sets.length);
    expect(newWorkout.sets[0].exercise, workout.sets[0].exercise);
  });
}
