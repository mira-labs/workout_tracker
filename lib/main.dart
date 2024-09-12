import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'repositories/workout_repository.dart';
import 'repositories/workout_repository_impl.dart'; // Assuming the actual implementation class
import 'providers/workout_provider.dart';
import 'screens/workout_list_screen.dart';
import 'screens/workout_detail_screen.dart';
import 'models/workout.dart';
import 'models/workout_set.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and register adapters
  await Hive.initFlutter();
  Hive.registerAdapter(WorkoutAdapter());
  Hive.registerAdapter(WorkoutSetAdapter());

  // Open Hive boxes for workouts and sets
  await Hive.openBox<Workout>('workoutBox');
  await Hive.openBox<WorkoutSet>('setBox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutProvider(), // WorkoutProvider handles its own repository
      child: MaterialApp(
        title: 'Workout Tracker',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: WorkoutListScreen(),
        routes: {
          '/details': (context) => WorkoutDetailScreen(),
        },
      ),
    );
  }
}
