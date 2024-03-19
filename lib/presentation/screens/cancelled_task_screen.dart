import 'package:flutter/material.dart';
import 'package:project_task_manager/data/models/task_list_counter.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
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
  bool _getCancelledTaskListInProgress = false;
  TaskListCounter _cancelledTaskList = TaskListCounter();

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
        child: Visibility(
          visible: _getCancelledTaskListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              _getCancelledTaskList();
            },
            child: Visibility(
              visible: _cancelledTaskList.taskList?.isNotEmpty ?? false,
              replacement: const EmpltyListRefresh(),
              child: ListView.builder(
                itemCount: _cancelledTaskList.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskCounterItem: _cancelledTaskList.taskList![index],
                    refreshList: () async {
                      _getCancelledTaskList();
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

  Future<void> _getCancelledTaskList() async {
    _getCancelledTaskListInProgress = false;
    setState(() {});

    final reponse = await NetworkCaller.getRequest(Urls.cancellTaskList);

    if (reponse.isSucess) {
      _cancelledTaskList = TaskListCounter.fromJson(reponse.responseBody);
      _getCancelledTaskListInProgress = false;
      setState(() {});
    } else {
      _getCancelledTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBarMessage(context,
            reponse.errorMessage ?? 'Cancelled task list has been failed');
      }
    }
  }
}
