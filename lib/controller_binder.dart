import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/count_by_status_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/delete_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/image_picker_controller.dart';
import 'package:project_task_manager/presentation/controllers/main_bottom_nav_controller.dart';
import 'package:project_task_manager/presentation/controllers/new_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/pin_verification_controller.dart';
import 'package:project_task_manager/presentation/controllers/profile_update_controller.dart';
import 'package:project_task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/set_password_controller.dart';
import 'package:project_task_manager/presentation/controllers/sign_in_controller.dart';

import 'package:project_task_manager/presentation/controllers/sign_up_controller.dart';

import 'package:project_task_manager/presentation/controllers/update_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/verify_email_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.put(SignInController());
    Get.put(SignUpController());
    Get.put(CountByStatusTaskController());
    Get.put(NewTaskController());
    Get.put(VerifyEmailController());
    Get.put(PinVerificationController());
    Get.put(SetPasswordController());
    Get.put(AddNewTaskController());
    Get.put(CancelledTaskController());
    Get.put(CompletedTaskController());
    Get.put(ProgressTaskController());
    Get.put(UpdateTaskController());
    Get.put(DeleteTaskController());
    Get.put(ImagePickerController());
    Get.put(ProfileUpdateController());
    Get.put(MainBottomNavController());
  }
}
