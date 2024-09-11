import 'package:hive/hive.dart';
import 'workout_set.dart';
part 'workout.g.dart';

@HiveType(typeId: 0)
class Workout extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String createdDate;

  @HiveField(2)
  final List<WorkoutSet> sets;

  Workout({
    required this.id,
    required this.createdDate,
    required this.sets,
  });

  // CopyWith method for immutability
  Workout copyWith({
    String? id,
    String? createdDate,
    List<WorkoutSet>? sets,
  }) {
    return Workout(
      id: id ?? this.id,
      createdDate: createdDate ?? this.createdDate,
      sets: sets ?? this.sets,
    );
  }

  // Convert Workout to Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'createdDate': createdDate,
      'sets': sets.map((set) => set.toMap()).toList(),
    };
  }

  // Create Workout from Map
  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      id: map['id'],
      createdDate: map['createdDate'],
      sets: (map['sets'] as List).map((setMap) => WorkoutSet.fromMap(setMap)).toList(),
    );
  }
}
