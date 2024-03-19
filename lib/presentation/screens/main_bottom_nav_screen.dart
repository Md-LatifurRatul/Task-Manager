import 'package:flutter/material.dart';
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
  int _currentSelectedIndex = 0;
  final List<Widget> _screens = [
    const NewTaskScreen(),
    const CompleteTaskScreen(),
    const ProgressTaskScreen(),
    const CancelledTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentSelectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentSelectedIndex,
        selectedItemColor: AppColors.themeColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: true,
        onTap: (index) {
          _currentSelectedIndex = index;
          if (mounted) {
            setState(() {});
          }
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
  }
}
