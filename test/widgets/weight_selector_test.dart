import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workout_tracker/widgets/weight_selector.dart';
import 'package:workout_tracker/core/constants.dart';

void main() {
  testWidgets('WeightSelector displays weights and triggers callback', (WidgetTester tester) async {
    double selectedWeight = 10.0;
    double? newWeight;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WeightSelector(
            selectedWeight: selectedWeight,
            onWeightChanged: (weight) {
              newWeight = weight;
            },
          ),
        ),
      ),
    );

    expect(find.text('10.0 kg'), findsOneWidget);

    await tester.tap(find.byType(DropdownButton<double>));
    await tester.pumpAndSettle();

    for (double weight in weights) {
      expect(find.text('${weight.toStringAsFixed(1)} kg'), findsOneWidget);
    }

    await tester.tap(find.text('20.0 kg').last);
    await tester.pumpAndSettle();

    expect(newWeight, 20.0);
  });
}
