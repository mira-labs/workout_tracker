import 'dart:async';
import '../models/workout.dart';
import '../models/workout_set.dart';
import 'workout_repository.dart';

class MockWorkoutRepository implements WorkoutRepository {
  final Map<String, Workout> _workouts = {};
  final Map<String, WorkoutSet> _sets = {};

  @override
  Future<void> insertWorkout(Workout workout) async {
    // Simulate a network delay
    await Future.delayed(Duration(milliseconds: 500));
    _workouts[workout.id] = workout;

    // Also save the sets separately
    for (var set in workout.sets) {
      _sets[set.id] = set;
    }
  }

  @override
  Future<List<Workout>> getWorkouts() async {
    // Simulate a network delay
    await Future.delayed(Duration(milliseconds: 500));
    return _workouts.values.toList();
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    // Simulate a network delay
    await Future.delayed(Duration(milliseconds: 500));
    _workouts[workout.id] = workout;

    // Also update the sets
    for (var set in workout.sets) {
      _sets[set.id] = set;
    }
  }

  @override
  Future<void> deleteWorkout(String id) async {
    // Simulate a network delay
    await Future.delayed(Duration(milliseconds: 500));
    _workouts.remove(id);

    // Remove associated sets
    _sets.removeWhere((key, value) => value.workoutId == id);
  }
}
