import 'package:hive/hive.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';

class WorkoutRepository {
  final String _workoutBoxName = 'workoutBox';
  final String _setBoxName = 'setBox';

  Future<void> _init() async {
    if (!Hive.isBoxOpen(_workoutBoxName)) {
      await Hive.openBox<Workout>(_workoutBoxName);
    }
    if (!Hive.isBoxOpen(_setBoxName)) {
      await Hive.openBox<WorkoutSet>(_setBoxName);
    }
  }

  Future<void> insertWorkout(Workout workout) async {
    await _init();
    final workoutBox = Hive.box<Workout>(_workoutBoxName);
    await workoutBox.put(workout.id, workout);

    // Also save the sets separately
    final setBox = Hive.box<WorkoutSet>(_setBoxName);
    for (var set in workout.sets) {
      await setBox.put(set.id, set);
    }
  }

  Future<List<Workout>> getWorkouts() async {
    await _init();
    final workoutBox = Hive.box<Workout>(_workoutBoxName);
    return workoutBox.values.toList();
  }

  Future<void> updateWorkout(Workout workout) async {
    await _init();
    final workoutBox = Hive.box<Workout>(_workoutBoxName);
    await workoutBox.put(workout.id, workout);

    // Also update the sets
    final setBox = Hive.box<WorkoutSet>(_setBoxName);
    for (var set in workout.sets) {
      await setBox.put(set.id, set);
    }
  }

  Future<void> deleteWorkout(String id) async {
    await _init();
    final workoutBox = Hive.box<Workout>(_workoutBoxName);
    final setBox = Hive.box<WorkoutSet>(_setBoxName);

    // Delete the workout
    await workoutBox.delete(id);

    // Delete the associated sets
    final workout = workoutBox.get(id);
    if (workout != null) {
      for (var set in workout.sets) {
        await setBox.delete(set.id);
      }
    }
  }
}
