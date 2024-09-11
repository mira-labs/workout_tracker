import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';
import 'workout_repository.dart';

class MockWorkoutRepository implements WorkoutRepository {
  final List<Workout> _workouts = [];

  @override
  Future<void> insertWorkout(Workout workout) async {
    _workouts.add(workout);
  }

  @override
  Future<List<Workout>> getWorkouts() async {
    return _workouts;
  }

  @override
  Future<void> updateWorkout(Workout workout) async {
    final index = _workouts.indexWhere((w) => w.id == workout.id);
    if (index != -1) {
      _workouts[index] = workout;
    }
  }

  @override
  Future<void> deleteWorkout(String id) async {
    _workouts.removeWhere((workout) => workout.id == id);
  }

  @override
  Future<void> openBox() async {
    // No-op for the mock repository, as there is no actual box to open
  }

  @override
  Future<void> closeBox() async {
    // No-op for the mock repository, as there is no actual box to close
  }
}
