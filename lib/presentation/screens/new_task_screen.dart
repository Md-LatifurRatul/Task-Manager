import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/data/models/task_by_status_data.dart';

import 'package:project_task_manager/presentation/controllers/count_by_status_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/new_task_controller.dart';

import 'package:project_task_manager/presentation/screens/add_new_task.dart';
import 'package:project_task_manager/presentation/utils/app_colors.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/empty_list_refresh.dart';
import 'package:project_task_manager/presentation/widget/profile_app_bar.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/task_card.dart';
import 'package:project_task_manager/presentation/widget/task_counter_card.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreensState();
}

class _NewTaskScreensState extends State<NewTaskScreen> {
  final CountByStatusTaskController _countByStatusTaskController =
      Get.find<CountByStatusTaskController>();
  final NewTaskController _newTaskController = Get.find<NewTaskController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(((timeStamp) {
      _getTaskDataFromApis();
    }));
  }

  Future<void> _getTaskDataFromApis() async {
    await _getAllTaskCountByStatus();
    await _getAllNewTaskListItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar,
      body: BackGroundWidget(
        child: Column(
          children: [
            GetBuilder<CountByStatusTaskController>(
                builder: (countByStatusTaskController) {
              return Visibility(
                  visible: countByStatusTaskController.inProgress == false,
                  replacement: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(),
                  ),
                  child: taskCounterSection(countByStatusTaskController
                          .countByStatusTask.listOfTaskByStatusData ??
                      []));
            }),
            Expanded(
              child:
                  GetBuilder<NewTaskController>(builder: (newTaskController) {
                return Visibility(
                  visible: newTaskController.inProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async => _getTaskDataFromApis(),
                    child: Visibility(
                      visible: newTaskController
                              .taskListCounter.taskList?.isNotEmpty ??
                          false,
                      replacement: const EmptyListRefresh(),
                      child: ListView.builder(
                        itemCount:
                            newTaskController.taskListCounter.taskList?.length,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskCounterItem: newTaskController
                                .taskListCounter.taskList![index],
                            refreshList: () {
                              _getTaskDataFromApis();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => const AddNewTaskScreen());

          if (result != null && result == true) {
            _getTaskDataFromApis();
          }
        },
        backgroundColor: AppColors.themeColor,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget taskCounterSection(List<TaskByStatusData> listOfTaskCounterStatus) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskCounterStatus.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title: listOfTaskCounterStatus[index].sId ?? '',
              amount: listOfTaskCounterStatus[index].sum ?? 0,
            );
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }

  Future<void> _getAllTaskCountByStatus() async {
    final result = await _countByStatusTaskController.getCountByStatusTask();
    if (!result) {
      showSnackBarMessage(_countByStatusTaskController.errorMessage);
    }
  }

  Future<void> _getAllNewTaskListItem() async {
    final result = await _newTaskController.getNewTaskController();
    if (!result) {
      showSnackBarMessage(_newTaskController.errorMessage);
    }
  }
}
