import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/controllers/task_controller.dart';

class TaskItems extends StatelessWidget {
  // Reference to TaskController
  final TaskController taskController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Get.theme; // Access the current theme using GetX

    return Scaffold(
      body: Obx(
        () => taskController.tasks.isEmpty
            ? Center(
                child: Text(
                  'No tasks available!',
                  style: theme.textTheme.bodyLarge,
                ),
              )
            : ListView.builder(
                itemCount: taskController.tasks.length,
                itemBuilder: (context, index) {
                  final task = taskController.tasks[index];

                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Dismissible(
                      key: ValueKey(task.id),
                      confirmDismiss: (direction) async {
                        final result = await Get.defaultDialog<bool?>(
                          title: 'Are you sure?',
                          middleText: 'Do you want to remove the item from the list?',
                          textCancel: 'No',
                          textConfirm: 'Yes',
                          confirmTextColor: Colors.white,
                          onCancel: () => Get.back(result: false),
                          onConfirm: () => Get.back(result: true),
                        );
                        return result ?? false;
                      },
                      onDismissed: (direction) {
  taskController.deleteTask(task.id!); // Ensure the task is removed from the list
},

                      background: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.only(right: 20),
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      direction: DismissDirection.endToStart,
                      child: InkWell(
                        onTap: () {
                          taskController.toggleTaskCompletion(task);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: task.isCompleted
                                ? theme.colorScheme.primaryContainer.withOpacity(0.3)
                                : theme.colorScheme.surface,
                            border: Border.all(
                              color: task.isCompleted
                                  ? theme.colorScheme.primary.withOpacity(0.5)
                                  : theme.colorScheme.onSurface.withOpacity(0.2),
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: task.isCompleted
                                ? []
                                : [
                                    BoxShadow(
                                      color: theme.shadowColor.withOpacity(0.1),
                                      blurRadius: 6,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title ?? 'Untitled Task',
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: task.isCompleted
                                      ? theme.colorScheme.onSurface.withOpacity(0.5)
                                      : theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                task.description ?? 'No description',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 12,
                                  color: task.isCompleted
                                      ? theme.colorScheme.onSurface.withOpacity(0.6)
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Due Date: ${task.date?.toLocal().toString().split(' ')[0] ?? 'N/A'}',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: Icon(
                                      task.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: theme.colorScheme.secondary,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      taskController.toggleFavoriteStatus(task);
                                    },
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      task.isCompleted
                                          ? Icons.check_box
                                          : Icons.check_box_outline_blank,
                                      color: theme.colorScheme.primary,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      taskController.toggleTaskCompletion(task);
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
