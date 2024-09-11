import 'package:flutter/material.dart';
import '../models/workout.dart';
import '../repositories/workout_repository.dart';

class WorkoutProvider extends ChangeNotifier {
  final WorkoutRepository repository;
  List<Workout> _workouts = [];

  WorkoutProvider({required this.repository}) {
    _loadWorkouts();
  }

  List<Workout> get workouts => _workouts;

  Future<void> _loadWorkouts() async {
    _workouts = await repository.getWorkouts();
    notifyListeners();
  }

  Future<void> addWorkout(Workout workout) async {
    await repository.insertWorkout(workout);
    _loadWorkouts();
  }

  Future<void> updateWorkout(Workout workout) async {
    await repository.updateWorkout(workout);
    _loadWorkouts();
  }

  Future<void> deleteWorkout(String id) async {
    await repository.deleteWorkout(id);
    _loadWorkouts();
  }
}
