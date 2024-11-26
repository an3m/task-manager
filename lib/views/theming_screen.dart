import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
// import 'theme_controller.dart';

class ThemingScreen extends StatelessWidget {
  static const routeName = '/theming_screen';

  final ThemeController themeController = Get.find();

  void _showColorPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text('Pick a Color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: themeController.primaryColor.value,
              onColorChanged: (color) {
                themeController.updatePrimaryColor(color);
              },
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App Themes'),
      ),
      body: Column(
        children: [
          const Text('Choose a theme:'),
          Obx(
            () => SwitchListTile(
              title: const Text('Dark Mode'),
              value: themeController.isDarkMode.value,
              onChanged: themeController.toggleTheme,
            ),
          ),
          const SizedBox(height: 20),
          const Text('Choose a primary color:'),
          ElevatedButton(
            onPressed: () => _showColorPicker(context),
            child: const Text('Pick Color'),
          ),
        ],
      ),
    );
  }
}
