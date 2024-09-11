
import package:flutter/material.dart;
import package:flutter_test/flutter_test.dart;
import ../lib/widgets/workout_list_item.dart;

void main() {
  testWidgets(WorkoutListItem displays and interacts correctly, (WidgetTester tester) async {
    String workoutDescription = Test Workout;
    bool deleteCalled = false;
    bool editCalled = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: WorkoutListItem(
          workoutDescription: workoutDescription,
          onDelete: () {
            deleteCalled = true;
          },
          onEdit: () {
            editCalled = true;
          },
        ),
      ),
    ));

    expect(find.text(workoutDescription), findsOneWidget);

    // Simulate delete button press
    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();
    expect(deleteCalled, isTrue);

    // Simulate edit button press
    await tester.tap(find.byIcon(Icons.edit));
    await tester.pump();
    expect(editCalled, isTrue);
  });
}

