import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';
import 'package:project_task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:project_task_manager/presentation/screens/main_bottom_nav_screen.dart';
import 'package:project_task_manager/presentation/widget/app_logo.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }

  Future<void> _moveToNextScreen() async {
    await Future.delayed(const Duration(seconds: 1));

    bool isLoggedIn = await AuthController.isUserLoggedIn();

    if (isLoggedIn) {
      Get.off(() => const MainBottomNavScreen());
    } else {
      Get.off(() => const SignInScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: BackGroundWidget(
        child: Center(
          child: AppLogo(),
        ),
      ),
    );
  }
}
