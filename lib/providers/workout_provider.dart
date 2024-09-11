import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../repositories/workout_repository.dart';

class WorkoutProvider with ChangeNotifier {
  final WorkoutRepository _repository;

  List<Workout> _workouts = [];

  WorkoutProvider(this._repository) {
    _loadWorkouts();
  }

  List<Workout> get workouts => _workouts;

  Future<void> _loadWorkouts() async {
    _workouts = await _repository.getWorkouts();
    notifyListeners();
  }

  Future<void> addWorkout(Workout workout) async {
    await _repository.addWorkout(workout);
    _workouts.add(workout);
    notifyListeners();
  }

  Future<void> updateWorkout(Workout updatedWorkout) async {
    await _repository.updateWorkout(updatedWorkout);
    final index = _workouts.indexWhere((w) => w.id == updatedWorkout.id);
    if (index != -1) {
      _workouts[index] = updatedWorkout;
      notifyListeners();
    }
  }

  Future<void> deleteWorkout(String workoutId) async {
    await _repository.deleteWorkout(workoutId);
    _workouts.removeWhere((w) => w.id == workoutId);
    notifyListeners();
  }
}
