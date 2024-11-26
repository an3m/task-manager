import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tasks_manager/views/theming_screen.dart';
import 'package:tasks_manager/widgets/input_form.dart';
import 'package:tasks_manager/widgets/task_items.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  // final TaskController taskController = Get.put(TaskController()); // Initialize controller

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Header Section
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: height * 0.25,
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(50, 30),
                    bottomRight: Radius.elliptical(50, 30),
                  ),
                  gradient: LinearGradient(
                    colors: [Color(0xFF8A2BE2), Color(0xFF1E90FF)],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.toNamed(ThemingScreen.routeName);
                          },
                          icon: Icon(
                            Icons.color_lens,
                            color: Colors.white,
                            size: width * 0.08,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search,
                            color: Colors.white,
                            size: width * 0.08,
                          ),
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
                          progressColor: Theme.of(context).colorScheme.primary,
                          backgroundColor: Colors.white.withOpacity(0.2),
                          center: CircleAvatar(
                            radius: 35,
                            backgroundImage:
                                AssetImage('assets/images/avatar.png'),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'John Doe',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            Text(
                              'App Developer',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: Colors.white70,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Task Items Section
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  height: height * 0.61, // 62% of the height for TaskItems
                  child: TaskItems(),
                ),
              ]),
            ),
          ],
        ),
      ),
      floatingActionButton: Align(
        child: InputForm(),
        alignment: Alignment.bottomCenter,
      ),
    );
  }
}
