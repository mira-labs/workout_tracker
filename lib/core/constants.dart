// lib/core/constants.dart

// Exercises
const List<String> exercises = [
  'Squat',
  'Bench Press',
  'Deadlift',
  'Overhead Press',
];

// Repetitions from 1 to 20
List<int> repetitions = [
  for (int i = 1; i <= 20; i++) i
];

// Weights from 0.5 kg to 120.0 kg (in 0.5 kg increments)
List<double> weights = [
  for (double w = 0.5; w <= 120.0; w += 0.5) w
];
