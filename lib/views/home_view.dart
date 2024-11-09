import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tasks_manager/widgets/task_items.dart';

import '../controllers/task_controller.dart';
import '../models/task.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: AppBar(
      //   systemOverlayStyle: SystemUiOverlayStyle(),
      //   backgroundColor: Colors.amber,
      //   title: const Text(''),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width,
              height: 350,
              padding: EdgeInsets.all(15),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(50, 30),
                    bottomRight: Radius.elliptical(50, 30)),
                gradient: LinearGradient(colors: [
                  Color.fromARGB(150, 136, 93, 255),
                  Color.fromARGB(150, 29, 153, 255)
                ], begin: Alignment.bottomRight, end: Alignment.topLeft),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.search),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularPercentIndicator(
                        radius: 50,
                        lineWidth: 5,
                        animation: true,
                        percent: 0.75,
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: Theme.of(context).canvasColor,
                        backgroundColor: Colors.transparent,
                        center: CircleAvatar(
                            radius: 35,
                            backgroundImage: Image.asset(
                              'assets/images/avatar.png',
                              fit: BoxFit.cover,
                            ).image
                            // AssetImage(),
                            ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Giga Nigga',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'App Devloper',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: TaskItems(),
                      height: 500,
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowAddTaskDialog._showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class ShowAddTaskDialog {
  // ShowAddTaskDialog(BuildContext context);

  static void _showAddTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
  final TaskController taskController = Get.put(TaskController());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Task"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: "Title"),
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                final task = Task(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: titleController.text,
                  description: descriptionController.text,
                  date: DateTime.now(),
                );
                taskController.addTask(task);
                Navigator.of(context).pop();
              },
              child: Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
