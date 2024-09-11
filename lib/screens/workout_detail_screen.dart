import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; // For date formatting
import '../providers/workout_provider.dart';
import '../models/workout.dart';
import '../models/workout_set.dart';
import '../widgets/workout_set_item.dart';

class WorkoutDetailScreen extends StatefulWidget {
  @override
  _WorkoutDetailScreenState createState() => _WorkoutDetailScreenState();
}

class _WorkoutDetailScreenState extends State<WorkoutDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  late Workout _currentWorkout;
  final List<WorkoutSet> _sets = [];
  late String _formattedDate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments;
    if (args != null && args is Workout) {
      _currentWorkout = args;
      _sets.addAll(_currentWorkout.sets);
      _formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.parse(_currentWorkout.createdDate));
    } else {
      DateTime now = DateTime.now();
      _currentWorkout = Workout(
        id: DateTime.now().toIso8601String(),
        sets: [],
        createdDate: now.toIso8601String(),
      );
      _formattedDate = DateFormat('yyyy-MM-dd HH:mm').format(now);
    }
  }

  void _saveWorkout() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);

      // Log the current state of the workout
      print('Saving workout...');
      print('Workout ID: ${_currentWorkout.id}');
      print('Workout Date: $_formattedDate');
      print('Workout Sets: ${_sets.map((set) => set.toMap()).toList()}');

      // Update the workout object with new values
      _currentWorkout = _currentWorkout.copyWith(
        sets: _sets,
        createdDate: DateFormat('yyyy-MM-dd HH:mm').parse(_formattedDate).toIso8601String(),
      );

      // Log the updated workout object
      print('Updated Workout Object: ${_currentWorkout.toMap()}');

      // Add or update the workout in the provider
      if (_currentWorkout.id.isEmpty) {
        workoutProvider.addWorkout(_currentWorkout).then((_) {
          print('Workout added successfully.');
          Navigator.pop(context);
        }).catchError((error) {
          print('Failed to add workout: $error');
        });
      } else {
        workoutProvider.updateWorkout(_currentWorkout).then((_) {
          print('Workout updated successfully.');
          Navigator.pop(context);
        }).catchError((error) {
          print('Failed to update workout: $error');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_currentWorkout.id.isEmpty ? 'Add Workout' : 'Edit Workout'),
        actions: [
          if (!_currentWorkout.id.isEmpty)
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                final workoutProvider = Provider.of<WorkoutProvider>(context, listen: false);
                workoutProvider.deleteWorkout(_currentWorkout.id).then((_) {
                  print('Workout deleted successfully.');
                  Navigator.pop(context);
                }).catchError((error) {
                  print('Failed to delete workout: $error');
                });
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.0),
              Text('Workout Date', style: Theme.of(context).textTheme.titleLarge),
              Text(
                _formattedDate,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 16.0),
              Text('Workout Sets', style: Theme.of(context).textTheme.titleLarge),
              SizedBox(height: 16.0),
              Expanded(
                child: _sets.isEmpty
                    ? Center(child: Text('No sets added'))
                    : ListView.builder(
                  itemCount: _sets.length,
                  itemBuilder: (context, index) {
                    return WorkoutSetItem(
                      workoutSet: _sets[index],
                      onExerciseChanged: (exercise) {
                        setState(() {
                          _sets[index] = _sets[index].copyWith(exercise: exercise);
                        });
                      },
                      onWeightChanged: (weight) {
                        setState(() {
                          _sets[index] = _sets[index].copyWith(weight: weight);
                        });
                      },
                      onRepsChanged: (reps) {
                        setState(() {
                          _sets[index] = _sets[index].copyWith(reps: reps);
                        });
                      },
                      onRemove: () {
                        setState(() {
                          _sets.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _sets.add(WorkoutSet(
                      id: DateTime.now().toIso8601String(), // Generate a new ID
                      exercise: 'Exercise Name', // Replace with actual data
                      weight: 0.0, // Replace with actual data
                      reps: 0, // Replace with actual data
                      workoutId: _currentWorkout.id,
                    ));
                  });
                },
                child: Text('Add Set'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveWorkout,
                child: Text('Save Workout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
