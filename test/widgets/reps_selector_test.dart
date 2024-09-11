import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/widgets/reps_selector.dart';
import 'package:workout_tracker/core/constants.dart';

void main() {
  testWidgets('RepsSelector displays reps and triggers callback', (WidgetTester tester) async {
    // Arrange
    int selectedReps = 10;
    int? changedReps;

    // Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RepsSelector(
            selectedReps: selectedReps,
            onRepsChanged: (reps) {
              changedReps = reps;
            },
          ),
        ),
      ),
    );

    // Verify DropdownButton is shown with correct items
    expect(find.byType(DropdownButton<int>), findsOneWidget);
    for (int i = 1; i <= 20; i++) {
      expect(find.text('$i reps'), findsOneWidget);
    }

    // Tap the dropdown and select a new value
    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();

    await tester.tap(find.text('15 reps').last);
    await tester.pumpAndSettle();

    // Verify callback is triggered with the new value
    expect(changedReps, 15);
  });
}
