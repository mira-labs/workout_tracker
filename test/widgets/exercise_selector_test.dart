import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/widgets/exercise_selector.dart';
import 'package:workout_tracker/core/constants.dart';

void main() {
  testWidgets('ExerciseSelector displays exercises and triggers callback', (WidgetTester tester) async {
    String selectedExercise = 'Squat';
    String? newExercise;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExerciseSelector(
            selectedExercise: selectedExercise,
            onExerciseChanged: (exercise) {
              newExercise = exercise;
            },
          ),
        ),
      ),
    );

    // Verify the dropdown contains the initial selected exercise
    expect(find.text('Squat'), findsOneWidget);

    // Open the dropdown
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    // Verify dropdown items
    for (String exercise in exercises) {
      expect(find.text(exercise), findsOneWidget);
    }

    // Select new exercise
    await tester.tap(find.text('Bench Press').last);
    await tester.pumpAndSettle();

    // Verify the callback was triggered with the correct exercise
    expect(newExercise, 'Bench Press');
  });
}
