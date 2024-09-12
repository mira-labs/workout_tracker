import 'package:hive/hive.dart';

part 'workout_set.g.dart'; // Generated file for the adapter

@HiveType(typeId: 1) // Unique typeId for the WorkoutSet model
class WorkoutSet extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String exercise;

  @HiveField(2)
  final double weight;

  @HiveField(3)
  final int reps;

  @HiveField(4)
  final String workoutId;

  WorkoutSet({
    required this.id,
    required this.exercise,
    required this.weight,
    required this.reps,
    required this.workoutId,
  });

  // CopyWith method for immutability (optional)
  WorkoutSet copyWith({
    String? id,
    String? exercise,
    double? weight,
    int? reps,
    String? workoutId,
  }) {
    return WorkoutSet(
      id: id ?? this.id,
      exercise: exercise ?? this.exercise,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
      workoutId: workoutId ?? this.workoutId,
    );
  }

  // Convert WorkoutSet to Map (optional)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'exercise': exercise,
      'weight': weight,
      'reps': reps,
      'workoutId': workoutId,
    };
  }

  // Create WorkoutSet from Map (optional)
  factory WorkoutSet.fromMap(Map<String, dynamic> map) {
    return WorkoutSet(
      id: map['id'],
      exercise: map['exercise'],
      weight: map['weight'],
      reps: map['reps'],
      workoutId: map['workoutId'],
    );
  }
}
