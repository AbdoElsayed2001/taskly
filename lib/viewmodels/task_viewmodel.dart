import 'package:flutter/material.dart';
import 'package:taskly/models/task.dart';

import '../services/database_service.dart';

class TaskViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await _databaseService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _databaseService.insertTask(task);
    await loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _databaseService.updateTask(task);
    final index = _tasks.indexWhere((t) => t.id == task.id);
    if (index != -1) {
      _tasks[index] = task;
      notifyListeners();
    }
  }

  Future<void> deleteTask(int id) async {
    await _databaseService.deleteTask(id);
    await loadTasks();
  }

  Future<void> toggleTaskCompletion(Task task) async {
    Task updatedTask = Task(
      id: task.id,
      title: task.title,
      description: task.description,
      isCompleted: !task.isCompleted,
    );
    await updateTask(updatedTask);
  }
}