
import package:flutter/material.dart;
import package:flutter_test/flutter_test.dart;
import ../lib/widgets/reps_selector.dart;
import ../lib/core/constants.dart;

void main() {
  testWidgets(RepsSelector displays and changes selected reps, (WidgetTester tester) async {
    final selectedReps = repetitions[0];

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: RepsSelector(
          selectedReps: selectedReps,
          onRepsChanged: (value) {},
        ),
      ),
    ));

    expect(find.text(Select Reps), findsOneWidget);
    expect(find.text( reps), findsOneWidget);

    // Test the dropdown change
    await tester.tap(find.byType(DropdownButton<int>));
    await tester.pumpAndSettle();
    await tester.tap(find.text( reps).last);
    await tester.pumpAndSettle();
  });
}

