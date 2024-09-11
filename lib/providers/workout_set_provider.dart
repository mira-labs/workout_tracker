import 'package:flutter/foundation.dart';
import '../models/workout_set.dart';
import '../repositories/workout_set_repository.dart';

class WorkoutSetProvider with ChangeNotifier {
  final WorkoutSetRepository _workoutSetRepository = WorkoutSetRepository();
  List<WorkoutSet> _sets = [];

  List<WorkoutSet> get sets => _sets;

  WorkoutSetProvider() {
    _loadSets();
  }

  Future<void> _loadSets() async {
    try {
      _sets = await _workoutSetRepository.getSets();
      notifyListeners();
    } catch (error) {
      print('Failed to load sets: $error');
    }
  }

  Future<void> addSet(WorkoutSet workoutSet) async {
    try {
      await _workoutSetRepository.insertSet(workoutSet);
      _sets.add(workoutSet);
      notifyListeners();
    } catch (error) {
      print('Failed to add set: $error');
    }
  }

  Future<void> updateSet(WorkoutSet workoutSet) async {
    try {
      await _workoutSetRepository.updateSet(workoutSet);
      final index = _sets.indexWhere((s) => s.id == workoutSet.id);
      if (index != -1) {
        _sets[index] = workoutSet;
        notifyListeners();
      }
    } catch (error) {
      print('Failed to update set: $error');
    }
  }

  Future<void> deleteSet(String id) async {
    try {
      await _workoutSetRepository.deleteSet(id);
      _sets.removeWhere((s) => s.id == id);
      notifyListeners();
    } catch (error) {
      print('Failed to delete set: $error');
    }
  }
}
