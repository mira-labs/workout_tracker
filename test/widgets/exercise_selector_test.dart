import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/widgets/exercise_selector.dart';
import 'package:workout_tracker/core/constants.dart';

void main() {
  testWidgets('ExerciseSelector displays exercises and triggers callback', (WidgetTester tester) async {
    // Arrange
    String selectedExercise = 'Squat';
    String? changedExercise;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ExerciseSelector(
            selectedExercise: selectedExercise,
            onExerciseChanged: (exercise) {
              changedExercise = exercise;
            },
          ),
        ),
      ),
    );

    // Verify DropdownButton is shown with correct items
    expect(find.byType(DropdownButton<String>), findsOneWidget);
    expect(find.text('Squat'), findsOneWidget);
    expect(find.text('Bench Press'), findsOneWidget);
    expect(find.text('Deadlift'), findsOneWidget);
    expect(find.text('Overhead Press'), findsOneWidget);

    // Tap the dropdown and select a new value
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Bench Press').last);
    await tester.pumpAndSettle();

    // Verify callback is triggered with the new value
    expect(changedExercise, 'Bench Press');
  });
}
