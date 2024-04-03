import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/cancelled_task_controller.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/empty_list_refresh.dart';
import 'package:project_task_manager/presentation/widget/profile_app_bar.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/task_card.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<CancelledTaskScreen> {
  final CancelledTaskController _cancelledTaskController =
      Get.find<CancelledTaskController>();

  @override
  void initState() {
    super.initState();
    _getCancelledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar,
      body: BackGroundWidget(
        child: GetBuilder<CancelledTaskController>(
            builder: (cancelledTaskController) {
          return Visibility(
            visible: cancelledTaskController.inProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async {
                _getCancelledTaskList();
              },
              child: Visibility(
                visible: cancelledTaskController
                        .cancelledTaskList.taskList?.isNotEmpty ??
                    false,
                replacement: const EmptyListRefresh(),
                child: ListView.builder(
                  itemCount: cancelledTaskController
                          .cancelledTaskList.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskCounterItem: cancelledTaskController
                          .cancelledTaskList.taskList![index],
                      refreshList: () async {
                        _getCancelledTaskList();
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

  Future<void> _getCancelledTaskList() async {
    final result = await _cancelledTaskController.getCancelledTaskController();

    if (!result) {
      showSnackBarMessage(_cancelledTaskController.errorMessage);
    }
  }
}
