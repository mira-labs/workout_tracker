import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/widgets/workout_set_item.dart';
import 'package:workout_tracker/models/workout_set.dart';

void main() {
  testWidgets('WorkoutSetItem displays workout set and handles callbacks', (WidgetTester tester) async {
    final workoutSet = WorkoutSet(
      id: '1',
      exercise: 'Squat',
      weight: 50.0,
      reps: 10,
      workoutId: 'workout_1',
    );

    String? selectedExercise;
    double? selectedWeight;
    int? selectedReps;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WorkoutSetItem(
            workoutSet: workoutSet,
            onExerciseChanged: (exercise) {
              selectedExercise = exercise;
            },
            onWeightChanged: (weight) {
              selectedWeight = weight;
            },
            onRepsChanged: (reps) {
              selectedReps = reps;
            },
            onRemove: () {},
          ),
        ),
      ),
    );

    expect(find.text('Squat'), findsOneWidget);
    expect(find.text('50.0 kg'), findsOneWidget);
    expect(find.text('10 reps'), findsOneWidget);

    await tester.tap(find.text('Bench Press').last);
    await tester.pump();
    expect(selectedExercise, 'Bench Press');

    await tester.tap(find.text('60.0 kg').last);
    await tester.pump();
    expect(selectedWeight, 60.0);

    await tester.tap(find.text('15 reps').last);
    await tester.pump();
    expect(selectedReps, 15);
  });
}
