import 'package:flutter/material.dart';

class WorkoutListItem extends StatelessWidget {
  final String workoutDescription;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  WorkoutListItem({
    required this.workoutDescription,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(workoutDescription),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: onEdit,  // Trigger the edit callback
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,  // Trigger the delete callback
          ),
        ],
      ),
    );
  }
}
