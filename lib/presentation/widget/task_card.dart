import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/data/models/task_counter_item.dart';
import 'package:project_task_manager/presentation/controllers/delete_task_controller.dart';
import 'package:project_task_manager/presentation/controllers/update_task_controller.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/status_list_item.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(
      {super.key, required this.taskCounterItem, required this.refreshList});

  final TaskCounterItem taskCounterItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final UpdateTaskController updateTaskController =
      Get.find<UpdateTaskController>();

  final DeleteTaskController _deleteTaskController =
      Get.find<DeleteTaskController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskCounterItem.title ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.taskCounterItem.description ?? ''),
            Text("Date: ${widget.taskCounterItem.createdDate}"),
            Row(
              children: [
                Chip(
                  label: Text(widget.taskCounterItem.status ?? ''),
                ),
                const Spacer(),
                GetBuilder<UpdateTaskController>(
                    builder: (updateTaskController) {
                  return Visibility(
                    visible: updateTaskController.inProgress == false,
                    replacement: const CircularProgressIndicator(),
                    child: IconButton(
                        onPressed: () {
                          _showUpdateDialogue(widget.taskCounterItem.sId ?? '');
                        },
                        icon: const Icon(Icons.edit)),
                  );
                }),
                GetBuilder<DeleteTaskController>(
                    builder: (deleteTaskController) {
                  return Visibility(
                    visible: deleteTaskController.inProgress == false,
                    replacement: const CircularProgressIndicator(),
                    child: IconButton(
                        onPressed: () {
                          _deleteTaskById(widget.taskCounterItem.sId ?? '');
                        },
                        icon: const Icon(Icons.delete_outline)),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateDialogue(String id) {
    Get.dialog(
      AlertDialog(
        title: const Text("Select status"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatusListItem(
              status: 'New',
              isSelected: _isCurrentSelectStatus('New'),
              onTap: (status) => _updateTaskById(id, status),
            ),
            StatusListItem(
              status: 'Completed',
              isSelected: _isCurrentSelectStatus('Completed'),
              onTap: (status) => _updateTaskById(id, status),
            ),
            StatusListItem(
              status: 'Progress',
              isSelected: _isCurrentSelectStatus('Progress'),
              onTap: (status) => _updateTaskById(id, status),
            ),
            StatusListItem(
              status: 'Cancelled',
              isSelected: _isCurrentSelectStatus('Cancelled'),
              onTap: (status) => _updateTaskById(id, status),
            ),
          ],
        ),
      ),
    );
  }

  bool _isCurrentSelectStatus(String status) {
    return widget.taskCounterItem.status == status;
  }

  Future<void> _updateTaskById(String id, String status) async {
    final result = await updateTaskController.getUpdateTaskController(
        id, status, widget.refreshList);

    if (result) {
      return;
    } else {
      showSnackBarMessage(updateTaskController.errorMessage);
    }
  }

  Future<void> _deleteTaskById(String id) async {
    final result = await _deleteTaskController.getDeleteTaskController(
        id, widget.refreshList);

    if (result) {
      return;
    } else {
      showSnackBarMessage(_deleteTaskController.errorMessage);
    }
  }
}
