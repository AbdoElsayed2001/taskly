import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskly/models/task.dart';
import 'package:taskly/widgets/task_item.dart';
import '../viewmodels/task_viewmodel.dart';


class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<TaskViewModel>(context, listen: false).loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    final taskViewModel = Provider.of<TaskViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Taskly'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: DropdownButton<TaskFilter>(
              value: taskViewModel.filter,
              onChanged: (newFilter) {
                if (newFilter != null) {
                  taskViewModel.setFilter(newFilter);
                }
              },
              items: const [
                DropdownMenuItem(
                  value: TaskFilter.all,
                  child: Text('كل المهام'),
                ),
                DropdownMenuItem(
                  value: TaskFilter.completed,
                  child: Text('المنجزة فقط'),
                ),
                DropdownMenuItem(
                  value: TaskFilter.incomplete,
                  child: Text('غير المنجزة'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskViewModel.filteredTasks.length,
              itemBuilder: (_, index) {
                final task = taskViewModel.filteredTasks[index];
                return TaskItem(task: task);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final _titleController = TextEditingController();
    final _descController = TextEditingController();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('إضافة مهمة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'العنوان'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'الوصف'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          ElevatedButton(
            onPressed: () {
              final title = _titleController.text.trim();
              final description = _descController.text.trim();
              if (title.isNotEmpty && description.isNotEmpty) {
                final newTask = Task(title: title, description: description);
                Provider.of<TaskViewModel>(context, listen: false).addTask(newTask);
                Navigator.pop(context);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
}