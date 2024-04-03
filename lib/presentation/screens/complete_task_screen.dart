import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/completed_task_controller.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/empty_list_refresh.dart';
import 'package:project_task_manager/presentation/widget/profile_app_bar.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/task_card.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<CompleteTaskScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskListItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar,
      body: BackGroundWidget(
        child: GetBuilder<CompletedTaskController>(
            builder: (completedTaskController) {
          return Visibility(
            visible: completedTaskController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                await _getAllCompletedTaskListItem();
              },
              child: Visibility(
                visible: completedTaskController
                        .completedTaskListCounter.taskList?.isNotEmpty ??
                    false,
                replacement: const EmptyListRefresh(),
                child: ListView.builder(
                  itemCount: completedTaskController
                          .completedTaskListCounter.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskCounterItem: completedTaskController
                          .completedTaskListCounter.taskList![index],
                      refreshList: () async {
                        await _getAllCompletedTaskListItem();
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _getAllCompletedTaskListItem() async {
    final result = await _completedTaskController.getCancelledTaskController();

    if (result) {
      return;
    } else {
      showSnackBarMessage(_completedTaskController.errorMessage);
    }
  }
}
