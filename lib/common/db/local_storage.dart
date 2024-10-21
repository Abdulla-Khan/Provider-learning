import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_todo/model/task_model.dart';

class LocalStorage {
  String userTasksKey = 'userTasks';

  // Get tasks from local storage
  Future<List<Task>> getUserTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? tasksJson = prefs.getStringList(userTasksKey);

    if (tasksJson != null) {
      // Convert JSON string back to List<Task>
      return tasksJson.map((task) => Task.fromJson(jsonDecode(task))).toList();
    } else {
      return [];
    }
  }

  // Save tasks to local storage
  Future<void> saveUserTasks(List<Task> taskList) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasksJson =
        taskList.map((task) => jsonEncode(task.toJson())).toList();
    await prefs.setStringList(userTasksKey, tasksJson);
  }
}
