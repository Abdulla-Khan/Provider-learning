import 'package:flutter/material.dart';
import 'package:riverpod_todo/common/db/local_storage.dart';
import 'package:riverpod_todo/model/task_model.dart';

class HomeProvider extends ChangeNotifier {
  TextEditingController todoController = TextEditingController();
  TextEditingController updateTodoController = TextEditingController();
  List<Task> taskList = [];
  String _text = '';
  String get text => _text;

  HomeProvider() {
    
    loadTasks();
  }

  void updateText(String newText) {
    _text = newText;
    notifyListeners(); 
  }

  
  Future<void> loadTasks() async {
    taskList = await LocalStorage().getUserTasks();
    notifyListeners(); 
  }

  
  void addTask() {
    Task task =
        Task(id: DateTime.now().toString(), title: todoController.text.trim());
    taskList.add(task);
    todoController.clear();
    notifyListeners();
    LocalStorage().saveUserTasks(taskList);
  }

  
  void deleteTask(int index) {
    taskList.removeAt(index);
    notifyListeners();
    LocalStorage().saveUserTasks(taskList);
  }

  
  void updateTask(int index) {
    taskList[index].title = updateTodoController.text.trim();
    updateTodoController.clear();
    notifyListeners();
    LocalStorage().saveUserTasks(taskList);
  }

  
  void showDialogForEdit(BuildContext context, int index) {
    updateTodoController.text = taskList[index].title; 
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Edit Task"),
              content: Container(
                margin: const EdgeInsets.all(30),
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(18)),
                child: TextField(
                  controller: updateTodoController,
                  maxLength: 20,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      updateTask(index);
                      Navigator.pop(context);
                    },
                    child: const Text('Update'))
              ],
            ));
  }
}
