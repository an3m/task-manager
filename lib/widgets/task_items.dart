import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:tasks_manager/controllers/task_controller.dart';

import '../models/task.dart';

class TaskItems extends StatelessWidget {
  // Reference to TaskController
  final TaskController taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return ListTile(
              title: Text(
                task.title,
                style: TextStyle(
                  decoration: task.isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              subtitle: Text(task.description),
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (value) {
                  taskController.toggleTaskCompletion(task.id);
                },
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  taskController.deleteTask(task.id);
                },
              ),
              onTap: () {
                // Code to edit task can go here
              },
            );
          },
        );
      }),
      
    );
  }

  // Show dialog to add a new task
  
}
