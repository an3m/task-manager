import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tasks_manager/models/task.dart';

class TaskController extends GetxController {
  var tasks = <Task>[].obs;

  final String baseUrl = 'https://h8l25fgz-3000.inc1.devtunnels.ms';

  // Fetch tasks from the API
  Future<void> fetchTasks() async {
    final response = await http.get(Uri.parse('$baseUrl/tasks'));
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List;
      tasks.value = data.map((task) => Task.fromJson(task)).toList();
    }
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    final response = await http.post(
      Uri.parse('$baseUrl/tasks'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );
    if (response.statusCode == 200) {
      tasks.add(Task.fromJson(json.decode(response.body)));
    }
  }

  // Update task completion
  Future<void> toggleTaskCompletion(int id) async {
    final response =
        await http.patch(Uri.parse('$baseUrl/tasks/$id/completion'));
    if (response.statusCode == 200) {
      var updatedTask = Task.fromJson(json.decode(response.body));
      var taskIndex = tasks.indexWhere((task) => task.id == id);
      tasks[taskIndex] = updatedTask;
    }
  }

  // Edit a task
  Future<void> editTask(int id, String newTitle, String newDescription) async {
    final response = await http.put(
      Uri.parse('$baseUrl/tasks/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': newTitle, 'description': newDescription}),
    );
    if (response.statusCode == 200) {
      var updatedTask = Task.fromJson(json.decode(response.body));
      var taskIndex = tasks.indexWhere((task) => task.id == id);
      tasks[taskIndex] = updatedTask;
      print('object');
    }
  }

  // Delete a task
  Future<void> deleteTask(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/tasks/$id'));
    if (response.statusCode == 204) {
      tasks.removeWhere((task) => task.id == id);
    }
  }
}
