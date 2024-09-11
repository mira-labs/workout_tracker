import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/widgets/workout_list_item.dart';

void main() {
  testWidgets('WorkoutListItem displays workout and handles edit and delete', (WidgetTester tester) async {
    bool editCalled = false;
    bool deleteCalled = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WorkoutListItem(
            workoutDescription: 'Workout 1: Bench Press - 3 sets',
            onEdit: () => editCalled = true,
            onDelete: () => deleteCalled = true,
          ),
        ),
      ),
    );

    expect(find.text('Workout 1: Bench Press - 3 sets'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.edit));
    expect(editCalled, true);

    await tester.tap(find.byIcon(Icons.delete));
    expect(deleteCalled, true);
  });
}
