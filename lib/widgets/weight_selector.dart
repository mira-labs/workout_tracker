import 'package:flutter/material.dart';
import '../core/constants.dart';

class WeightSelector extends StatelessWidget {
  final double selectedWeight;
  final ValueChanged<double?>? onWeightChanged;

  WeightSelector({
    required this.selectedWeight,
    this.onWeightChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<double>(
      value: selectedWeight,
      items: weights.map((double weight) {
        return DropdownMenuItem<double>(
          value: weight,
          child: Text('$weight kg'),
        );
      }).toList(),
      onChanged: onWeightChanged,
      hint: Text('Select Weight'),
      isExpanded: true,
    );
  }
}
