import 'package:hive/hive.dart';
import '../models/workout_set.dart';

class WorkoutSetRepository {
  final String _setBoxName = 'setBox';

  Future<void> _init() async {
    if (!Hive.isBoxOpen(_setBoxName)) {
      await Hive.openBox<WorkoutSet>(_setBoxName);
    }
  }

  Future<void> insertSet(WorkoutSet workoutSet) async {
    await _init();
    final setBox = Hive.box<WorkoutSet>(_setBoxName);
    await setBox.put(workoutSet.id, workoutSet);
  }

  Future<List<WorkoutSet>> getSets() async {
    await _init();
    final setBox = Hive.box<WorkoutSet>(_setBoxName);
    return setBox.values.toList();
  }

  Future<void> updateSet(WorkoutSet workoutSet) async {
    await _init();
    final setBox = Hive.box<WorkoutSet>(_setBoxName);
    await setBox.put(workoutSet.id, workoutSet);
  }

  Future<void> deleteSet(String id) async {
    await _init();
    final setBox = Hive.box<WorkoutSet>(_setBoxName);
    await setBox.delete(id);
  }
}
