import 'package:flutter/material.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
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
  bool _getProgressTaskInProgess = false;
  TaskListCounter _progressTaskListCounter = TaskListCounter();

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
        child: Visibility(
          visible: _getProgressTaskInProgess == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              _getAllProgressTaskList();
            },
            child: Visibility(
              visible: _progressTaskListCounter.taskList?.isNotEmpty ?? false,
              replacement: const EmpltyListRefresh(),
              child: ListView.builder(
                itemCount: _progressTaskListCounter.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskCounterItem: _progressTaskListCounter.taskList![index],
                    refreshList: () {
                      _getAllProgressTaskList();
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

  Future<void> _getAllProgressTaskList() async {
    _getProgressTaskInProgess = true;
    setState(() {});

    final response = await NetworkCaller.getRequest(Urls.progressTaskList);
    if (response.isSucess) {
      _progressTaskListCounter =
          TaskListCounter.fromJson(response.responseBody);
      _getProgressTaskInProgess = false;
      setState(() {});
    } else {
      _getProgressTaskInProgess = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            response.errorMessage ?? 'Get Progress task list has been failed');
      }
    }
  }
}
