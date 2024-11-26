import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tasks_manager/controllers/task_controller.dart';
import 'package:tasks_manager/controllers/theme_controller.dart';
import 'package:tasks_manager/views/body.dart';
import 'package:tasks_manager/views/theming_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  // Initialize GetStorage
  await GetStorage.init();

  // Initialize controllers
  Get.put(TaskController());
  final themeController = Get.put(ThemeController());

  runApp(MyApp(themeController: themeController));
}

class MyApp extends StatelessWidget {
  final ThemeController themeController;

  MyApp({Key? key, required this.themeController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use Obx to reactively update the theme based on themeController's changes
    return Obx(
      () => GetMaterialApp(
        title: 'Flutter Demo',
        theme: themeController.themeData, // Use reactive theme data
        debugShowCheckedModeBanner: false,
        home: BodyView(),
        getPages: [
          GetPage(name: ThemingScreen.routeName, page: () => ThemingScreen()),
        ],
      ),
    );
  }
}
