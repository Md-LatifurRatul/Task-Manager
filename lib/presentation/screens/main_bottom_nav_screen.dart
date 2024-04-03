import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:project_task_manager/presentation/controllers/main_bottom_nav_controller.dart';

import 'package:project_task_manager/presentation/screens/cancelled_task_screen.dart';
import 'package:project_task_manager/presentation/screens/complete_task_screen.dart';
import 'package:project_task_manager/presentation/screens/new_task_screen.dart';
import 'package:project_task_manager/presentation/screens/progress_task_screen.dart';
import 'package:project_task_manager/presentation/utils/app_colors.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompleteTaskScreen(),
    const ProgressTaskScreen(),
    const CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainBottomNavController>(
        builder: (mainBottomNavController) {
      return Scaffold(
        body: _screens[mainBottomNavController.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: mainBottomNavController.currentIndex,
          selectedItemColor: AppColors.themeColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          onTap: (index) {
            mainBottomNavController.changeIndex(index);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.list_alt),
                label: 'New Task',
                tooltip: 'New Task'),
            BottomNavigationBarItem(
                icon: Icon(Icons.check_circle_outline),
                label: 'Completed',
                tooltip: 'Completed'),
            BottomNavigationBarItem(
                icon: Icon(Icons.access_time_rounded),
                label: 'Progress',
                tooltip: 'Progress'),
            BottomNavigationBarItem(
                icon: Icon(Icons.cancel_outlined),
                label: 'Cancelled',
                tooltip: 'Cancelled'),
          ],
        ),
      );
    });
  }
}
