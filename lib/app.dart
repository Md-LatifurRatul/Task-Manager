import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/controller_binder.dart';
import 'package:project_task_manager/presentation/screens/splash_screen.dart';
import 'package:project_task_manager/presentation/utils/app_colors.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Task manager',
      home: const SplashScreen(),
      theme: _themeData,
      initialBinding: ControllerBinder(),
    );
  }

  final ThemeData _themeData = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: 18,
        horizontal: 24,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: AppColors.themeColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.themeColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w600,
      ),
    ),
    chipTheme: ChipThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );
}
