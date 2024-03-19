import 'package:flutter/material.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
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
  bool _getAllCompletedTaskListInProgress = false;
  TaskListCounter _completedTaskListCounter = TaskListCounter();

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
        child: Visibility(
          visible: _getAllCompletedTaskListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              setState(() {});
              await _getAllCompletedTaskListItem();
            },
            child: Visibility(
              visible: _completedTaskListCounter.taskList?.isNotEmpty ?? false,
              replacement: const EmpltyListRefresh(),
              child: ListView.builder(
                itemCount: _completedTaskListCounter.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskCounterItem: _completedTaskListCounter.taskList![index],
                    refreshList: () async {
                      await _getAllCompletedTaskListItem();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCompletedTaskListItem() async {
    _getAllCompletedTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedTaskList);
    _getAllCompletedTaskListInProgress = false;

    if (response.isSucess) {
      _completedTaskListCounter =
          TaskListCounter.fromJson(response.responseBody);

      _getAllCompletedTaskListInProgress = false;
      setState(() {});
    } else {
      _getAllCompletedTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Get completed task list has been has been failed');
      }
    }
  }
}
