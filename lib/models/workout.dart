// lib/models/workout.dart

import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  final String id;
  final List<WorkoutSet> sets;
  final DateTime createdDate;  // New property

  Workout({
    required this.id,
    required this.sets,
    required this.createdDate,  // Include the new property in the constructor
  });

  @override
  List<Object?> get props => [id, sets, createdDate];  // Include in props

  Workout copyWith({
    String? id,
    List<WorkoutSet>? sets,
    DateTime? createdDate,  // Include in copyWith
  }) {
    return Workout(
      id: id ?? this.id,
      sets: sets ?? this.sets,
      createdDate: createdDate ?? this.createdDate,
    );
  }
}

class WorkoutSet extends Equatable {
  final String exercise;
  final double weight;
  final int reps;

  WorkoutSet({
    required this.exercise,
    required this.weight,
    required this.reps,
  });

  @override
  List<Object?> get props => [exercise, weight, reps];

  WorkoutSet copyWith({
    String? exercise,
    double? weight,
    int? reps,
  }) {
    return WorkoutSet(
      exercise: exercise ?? this.exercise,
      weight: weight ?? this.weight,
      reps: reps ?? this.reps,
    );
  }
}
