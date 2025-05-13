import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/task.dart';
import '../viewmodels/task_viewmodel.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;

  const EditTaskDialog({super.key, required this.task});

  @override
  State<EditTaskDialog> createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descController = TextEditingController(text: widget.task.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context, listen: false);

    return AlertDialog(
      title: const Text('تعديل المهمة'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'عنوان المهمة'),
          ),
          TextField(
            controller: _descController,
            decoration: const InputDecoration(labelText: 'الوصف'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('إلغاء'),
          onPressed: () => Navigator.pop(context),
        ),
        ElevatedButton(
          child: const Text('حفظ'),
          onPressed: () {
            final updatedTask = Task(
              id: widget.task.id,
              title: _titleController.text,
              description: _descController.text,
              isCompleted: widget.task.isCompleted,
            );
            taskViewModel.updateTask(updatedTask);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
