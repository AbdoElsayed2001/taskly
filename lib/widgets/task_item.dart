import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/widgets/edit_task_dialog.dart';
import '../viewmodels/task_viewmodel.dart';

class TaskItem extends StatelessWidget {
  final Task task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: GestureDetector(
        onLongPress: () {
          showDialog(
            context: context,
            builder: (_) => EditTaskDialog(task: task),
          );
        },
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) {
                    taskViewModel.toggleTaskCompletion(task);
                  },
                  activeColor: Colors.indigo,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        task.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          decoration: task.isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: task.isCompleted ? Colors.grey : Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        task.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: task.isCompleted ? Colors.grey : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () {
                    taskViewModel.deleteTask(task.id!);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
