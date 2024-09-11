import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../providers/workout_provider.dart';
import '../models/workout.dart';
import '../widgets/workout_list_item.dart';

class WorkoutListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Workout List'),
      ),
      body: Consumer<WorkoutProvider>(
        builder: (context, workoutProvider, child) {
          final workouts = workoutProvider.workouts;

          // Print all workouts to the console for debugging
          print('--- All Workouts ---');
          workouts.forEach((workout) {
            print('Workout ID: ${workout.id}');
            print('Workout Date: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(workout.createdDate))}');
            print('Workout Sets: ${workout.sets.map((set) => set.toMap()).toList()}'); // Use toMap() for better readability
            print('---------------------');
          });

          return workouts.isEmpty
              ? Center(child: Text('No workouts available'))
              : ListView.builder(
            itemCount: workouts.length,
            itemBuilder: (context, index) {
              final workout = workouts[index];
              return WorkoutListItem(
                workoutDescription: '${workout.id} - ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(workout.createdDate))}',
                onDelete: () {
                  workoutProvider.deleteWorkout(workout.id).then((_) {
                    print('Workout deleted successfully.');
                  }).catchError((error) {
                    print('Failed to delete workout: $error');
                  });
                },
                onEdit: () {
                  Navigator.pushNamed(
                    context,
                    '/details',
                    arguments: workout,
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/details');
        },
        child: Icon(Icons.add),
        tooltip: 'Add Workout',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 5.0,
      ),
    );
  }
}
