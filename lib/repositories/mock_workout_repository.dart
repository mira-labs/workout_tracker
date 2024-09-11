import 'dart:async';
import '../models/workout.dart';
import 'workout_repository.dart';

class MockWorkoutRepository implements WorkoutRepository {
  final List<Workout> _workouts = [];

  @override
  Future<List<Workout>> getWorkouts() async {
    await Future.delayed(Duration(seconds: 1));
    return List.unmodifiable(_workouts);
  }

  @override
  Future<void> addWorkout(Workout workout) async {
    await Future.delayed(Duration(milliseconds: 500));
    _workouts.add(workout);
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    await Future.delayed(Duration(milliseconds: 500));
    final index = _workouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      _workouts[index] = workout;
    }
  }

  @override
  Future<void> deleteWorkout(String id) async {
    await Future.delayed(Duration(milliseconds: 500));
    _workouts.removeWhere((w) => w.id == id);
  }
}
