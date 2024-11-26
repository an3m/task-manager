
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasks_manager/controllers/landing_page_controller.dart';
import 'package:tasks_manager/controllers/task_controller.dart';

class FavoriteTasksPage extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();
  final LandingPageController landingPageController = Get.find<LandingPageController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Tasks'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) => taskController.searchFavoriteTasks(value),
              decoration: InputDecoration(
                labelText: 'Search favorite tasks',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              final favoriteTasks =
                  taskController.favoriteTasks; // Reactive filtered list

              if (favoriteTasks.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.favorite_border, size: 50),
                      const SizedBox(height: 10),
                      Text(
                        'No favorite tasks yet!',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => landingPageController.tabIndex.value = 0,
                        child: const Text('Add Tasks'),
                      ),
                    ],
                  ),
                );
              }

              return ListView.builder(
                itemCount: favoriteTasks.length,
                itemBuilder: (context, index) {
                  final task = favoriteTasks[index];
                  return Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border.all(
                          color: Theme.of(context).colorScheme.primary),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                task.title ?? 'Untitled Task',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      decoration: task.isCompleted
                                          ? TextDecoration.lineThrough
                                          : TextDecoration.none,
                                    ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                task.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onPressed: () {
                                taskController.toggleFavoriteStatus(task);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          task.description ?? 'No description',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Date: ${task.date?.toLocal().toString().split(' ')[0] ?? 'N/A'}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                task.isCompleted
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              onPressed: () {
                                taskController.toggleTaskCompletion(task);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
