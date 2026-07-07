import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/todo.dart';

class TodoProvider extends ChangeNotifier {
  final Box<Todo> _box = Hive.box<Todo>('tasks');

  List<Todo> get todos => _box.values.toList();

  Future<void> addTask(Todo todo) async {
    await _box.put(todo.id, todo);
    notifyListeners();
  }

  Future<void> updateTask(Todo todo) async {
    await todo.save();
    notifyListeners();
  }

  Future<void> deleteTask(String id) async {
    await _box.delete(id);
    notifyListeners();
  }

  Future<void> toggleTask(String id) async {
    final todo = _box.get(id);
    if (todo != null) {
      todo.isDone = !todo.isDone;
      await todo.save();
      notifyListeners();
    }
  }
}
