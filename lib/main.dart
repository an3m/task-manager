import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tasks_manager/models/task.dart';
import 'package:tasks_manager/views/home_view.dart';

void main()  {
  WidgetsFlutterBinding.ensureInitialized();
  //  Open the box
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        
        theme: ThemeData(
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
          // colorSchemeSeed: Colors.amberAccent,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue,brightness: Brightness.light),
          useMaterial3: true,
        ),
        home: HomeView());
  }
}
