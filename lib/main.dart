import 'package:calendartask/model/task.dart';
import 'package:calendartask/screens/home.dart';
import 'package:calendartask/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TaskAdapter());
  await Hive.openBox<Task>('task');


  runApp(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
          home: SplashScreen()
      )
  );
}
