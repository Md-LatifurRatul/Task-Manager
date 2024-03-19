import 'package:flutter/material.dart';
import 'package:project_task_manager/data/models/count_by_status_task.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
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
  bool _getAllTaskCountByStatusProgress = false;
  bool _getNewTaskListInProgress = false;

  CountByStatusTask _countByStatusTask = CountByStatusTask();

  TaskListCounter _newTaskListCounter = TaskListCounter();

  @override
  void initState() {
    super.initState();
    _getTaskDataFromApis();
  }

  void _getTaskDataFromApis() {
    _getAllTaskCountByStatus();
    _getAllNewTaskListItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: profileAppbar,
      body: BackGroundWidget(
        child: Column(
          children: [
            Visibility(
                visible: _getAllTaskCountByStatusProgress == false,
                replacement: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection),
            Expanded(
              child: Visibility(
                visible: _getNewTaskListInProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: RefreshIndicator(
                  onRefresh: () async => _getTaskDataFromApis(),
                  child: Visibility(
                    visible: _newTaskListCounter.taskList?.isNotEmpty ?? false,
                    replacement: const EmpltyListRefresh(),
                    child: ListView.builder(
                      itemCount: _newTaskListCounter.taskList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return TaskCard(
                          taskCounterItem: _newTaskListCounter.taskList![index],
                          refreshList: () {
                            _getTaskDataFromApis();
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewTaskScreen()),
          );
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

  Widget get taskCounterSection {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: _countByStatusTask.listOfTaskByStatusData?.length ?? 0,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
              title:
                  _countByStatusTask.listOfTaskByStatusData![index].sId ?? '',
              amount:
                  _countByStatusTask.listOfTaskByStatusData![index].sum ?? 0,
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
    _getAllTaskCountByStatusProgress = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.taskStatusCount);

    if (response.isSucess) {
      _countByStatusTask = CountByStatusTask.fromJson(response.responseBody);
      _getAllTaskCountByStatusProgress = false;
      setState(() {});
    } else {
      _getAllTaskCountByStatusProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get Task count by status has been failed');
      }
    }
  }

  Future<void> _getAllNewTaskListItem() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.newlistTaskByStatus);
    if (response.isSucess) {
      _newTaskListCounter = TaskListCounter.fromJson(response.responseBody);

      _getNewTaskListInProgress = false;
      setState(() {});
    } else {
      _getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get new task list has been has been failed');
      }
    }
  }
}
