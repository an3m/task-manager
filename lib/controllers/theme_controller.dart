import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _storage = GetStorage();
  var isDarkMode = false.obs;
 var primaryColor = Colors.blue.shade500.obs; // Define as Color, not MaterialColor

  @override
  void onInit() {
    super.onInit();
    // Load theme settings from storage
    isDarkMode.value = _storage.read('isDarkMode') ?? false;
primaryColor.value = _storage.read('primaryColor') != null 
    ? Color(_storage.read('primaryColor')) 
    : const Color(0xFF2196F3); // Use a hex code directly for Colors.blue
  }

  ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor.value,
        brightness: isDarkMode.value ? Brightness.dark : Brightness.light,
      ),
    );
  }

  void toggleTheme(bool value) {
    isDarkMode.value = value;
    _storage.write('isDarkMode', value);
    update();  // notify listeners
  }

  void updatePrimaryColor(Color color) {
    primaryColor.value = color;
    _storage.write('primaryColor', color.value);
    update();  // notify listeners
  }
}
