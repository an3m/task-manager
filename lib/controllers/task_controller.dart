import 'package:get/get.dart';
import '../helpers/database_helper.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  final DatabaseHelper _dbHelper = DatabaseHelper();

  // Observable list of tasks
  var tasks = <Task>[].obs;
  var favoriteTasks = <Task>[].obs;

  Future<void> fetchTasks() async {
    try {
      final fetchedTasks = await _dbHelper.getTasks();
      tasks.value = fetchedTasks; // Update the observable list
      updateFavoriteTasks(); // Update favorite tasks
    } catch (e) {
      print("Error fetching tasks: $e");
    }
  }

  // Add a new task
  Future<void> addTask(Task task) async {
    try {
      await _dbHelper.insertTask(task);
      tasks.add(task); // Add directly to the observable list
      updateFavoriteTasks();
    } catch (e) {
      print("Error adding task: $e");
    }
  }

  // Update a task
  Future<void> updateTask(Task task) async {
    try {
      await _dbHelper.updateTask(task);
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = task; // Update the task locally
        tasks.refresh(); // Notify observers of changes
        updateFavoriteTasks();
      }
    } catch (e) {
      print("Error updating task: $e");
    }
  }

  // Delete a task by ID
  Future<void> deleteTask(int? id) async {
    try {
      await _dbHelper.deleteTask(id!);
      tasks.removeWhere((task) => task.id == id);
      updateFavoriteTasks();
    } catch (e) {
      print("Error deleting task: $e");
    }
  }

  // Toggle task completion
  void toggleTaskCompletion(Task task) async {
    try {
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      await updateTask(updatedTask);
    } catch (e) {
      print("Error toggling task completion: $e");
    }
  }

  // Toggle favorite status
  void toggleFavoriteStatus(Task task) async {
    try {
      final updatedTask = task.copyWith(isFavorite: !task.isFavorite);
      await updateTask(updatedTask);
    } catch (e) {
      print("Error toggling favorite status: $e");
    }
  }

  // Search favorite tasks
  void searchFavoriteTasks(String query) {
    favoriteTasks.value = tasks
        .where((task) =>
            task.isFavorite &&
            (task.title?.toLowerCase().contains(query.toLowerCase()) ?? false))
        .toList();
  }

  // Update favorite tasks
  void updateFavoriteTasks() {
    favoriteTasks.value = tasks.where((task) => task.isFavorite).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchTasks(); // Fetch tasks when the controller is initialized
  }
}
