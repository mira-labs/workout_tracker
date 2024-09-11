
import package:flutter/material.dart;
import package:flutter_test/flutter_test.dart;
import ../lib/widgets/exercise_selector.dart;
import ../lib/core/constants.dart;

void main() {
  testWidgets(ExerciseSelector displays and changes selected exercise, (WidgetTester tester) async {
    final selectedExercise = exercises[0];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: ExerciseSelector(
          selectedExercise: selectedExercise,
          onExerciseChanged: (value) {},
        ),
      ),
    ));

    expect(find.text(Select Exercise), findsOneWidget);
    expect(find.text(selectedExercise), findsOneWidget);

    // Test the dropdown change
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text(exercises[1]).last);
    await tester.pumpAndSettle();
  });
}

