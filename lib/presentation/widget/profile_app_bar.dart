import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/auth_controller.dart';
import 'package:project_task_manager/presentation/screens/auth/sign_in_screen.dart';
import 'package:project_task_manager/presentation/screens/update_profile_screen.dart';
import 'package:project_task_manager/presentation/utils/app_colors.dart';

PreferredSizeWidget get profileAppbar {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: AppColors.themeColor,
    title: GestureDetector(
      onTap: () async {
        if (!Get.isPopGestureEnable) {
          Get.to(() => const UpdateProfileScreen());
        }
        // if (!Navigator.canPop(TaskManager.navigatorKey.currentContext!)) {
        //   Navigator.push(
        //       TaskManager.navigatorKey.currentContext!,
        //       MaterialPageRoute(
        //           builder: (context) => const UpdateProfileScreen()));
        // }
      },
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: photoImage(),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AuthController.userData?.fullName ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                Text(
                  AuthController.userData?.email ?? '',
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () async {
                await AuthController.clearUserData();

                Get.offUntil(
                    GetPageRoute(
                      page: () => const SignInScreen(),
                    ),
                    (route) => false);

                // Navigator.pushAndRemoveUntil(
                //     TaskManager.navigatorKey.currentState!.context,
                //     MaterialPageRoute(
                //         builder: (context) => const SignInScreen()),
                //     (route) => false);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
    ),
  );
}

MemoryImage? photoImage() {
  try {
    return MemoryImage(base64Decode(AuthController.userData!.photo!));
  } catch (e) {
    return null;
  }
}
