import 'package:flutter/foundation.dart';
import '../models/workout.dart';
import '../repositories/workout_repository.dart';

class WorkoutProvider with ChangeNotifier {
  final WorkoutRepository _workoutRepository = WorkoutRepository();
  List<Workout> _workouts = [];

  List<Workout> get workouts => _workouts;

  WorkoutProvider() {
    _loadWorkouts();
  }

  Future<void> _loadWorkouts() async {
    try {
      _workouts = await _workoutRepository.getWorkouts();
      notifyListeners();
    } catch (error) {
      print('Failed to load workouts: $error');
    }
  }

  Future<void> addWorkout(Workout workout) async {
    try {
      await _workoutRepository.insertWorkout(workout);
      _workouts.add(workout);
      notifyListeners();
    } catch (error) {
      print('Failed to add workout: $error');
    }
  }

  Future<void> updateWorkout(Workout workout) async {
    try {
      await _workoutRepository.updateWorkout(workout);
      final index = _workouts.indexWhere((w) => w.id == workout.id);
      if (index != -1) {
        _workouts[index] = workout;
        notifyListeners();
      }
    } catch (error) {
      print('Failed to update workout: $error');
    }
  }

  Future<void> deleteWorkout(String id) async {
    try {
      await _workoutRepository.deleteWorkout(id);
      _workouts.removeWhere((w) => w.id == id);
      notifyListeners();
    } catch (error) {
      print('Failed to delete workout: $error');
    }
  }
}
