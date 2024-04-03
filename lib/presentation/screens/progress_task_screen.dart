import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/progress_task_controller.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/empty_list_refresh.dart';
import 'package:project_task_manager/presentation/widget/profile_app_bar.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/task_card.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<ProgressTaskScreen> {
  final ProgressTaskController _progressTaskController =
      Get.find<ProgressTaskController>();

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar,
      body: BackGroundWidget(
        child: GetBuilder<ProgressTaskController>(
            builder: (progressTaskController) {
          return Visibility(
            visible: progressTaskController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                _getAllProgressTaskList();
              },
              child: Visibility(
                visible: progressTaskController
                        .progressTaskListCounter.taskList?.isNotEmpty ??
                    false,
                replacement: const EmptyListRefresh(),
                child: ListView.builder(
                  itemCount: progressTaskController
                          .progressTaskListCounter.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskCounterItem: progressTaskController
                          .progressTaskListCounter.taskList![index],
                      refreshList: () {
                        _getAllProgressTaskList();
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

  Future<void> _getAllProgressTaskList() async {
    final result = await _progressTaskController.getProgressTaskController();
    if (result) {
      return;
    } else {
      showSnackBarMessage(_progressTaskController.errorMessage);
    }
  }
}
