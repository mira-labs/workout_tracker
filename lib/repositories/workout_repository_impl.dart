import 'package:hive/hive.dart';
import '../models/workout.dart';
import 'workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final Box<Workout> _workoutBox;

  WorkoutRepositoryImpl() : _workoutBox = Hive.box<Workout>('workouts');

  @override
  Future<void> insertWorkout(Workout workout) async {
    await _workoutBox.put(workout.id, workout);
  }

  @override
  Future<List<Workout>> getWorkouts() async {
    return _workoutBox.values.toList();
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    await _workoutBox.put(workout.id, workout);
  }

  @override
  Future<void> deleteWorkout(String id) async {
    await _workoutBox.delete(id);
  }
}
