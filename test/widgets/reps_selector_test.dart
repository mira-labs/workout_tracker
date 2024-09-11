import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/widgets/reps_selector.dart';
import 'package:workout_tracker/core/constants.dart';

void main() {
  testWidgets('RepsSelector displays reps and triggers callback', (WidgetTester tester) async {
    int selectedReps = 5;
    int? newReps;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RepsSelector(
            selectedReps: selectedReps,
            onRepsChanged: (reps) {
              newReps = reps;
            },
          ),
        ),
      ),
    );

    // Verify the dropdown contains the initial selected reps
    expect(find.text('5 reps'), findsOneWidget);

    // Open the dropdown
    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();

    // Verify dropdown items
    for (int reps in repetitions) {
      expect(find.text('$reps reps'), findsOneWidget);
    }

    // Select new reps
    await tester.tap(find.text('10 reps').last);
    await tester.pumpAndSettle();

    // Verify the callback was triggered with the correct reps
    expect(newReps, 10);
  });
}
