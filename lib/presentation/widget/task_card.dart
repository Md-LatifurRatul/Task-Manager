import 'package:flutter/material.dart';
import 'package:project_task_manager/data/models/task_counter_item.dart';
import 'package:project_task_manager/data/services/network_caller.dart';
import 'package:project_task_manager/data/utility/urls.dart';
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
  bool _updateTaskInProgress = false;
  bool _taskDeleteInProgress = false;

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
                Visibility(
                  visible: _updateTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _showUpdateDialogue(widget.taskCounterItem.sId!);
                      },
                      icon: const Icon(Icons.edit)),
                ),
                Visibility(
                  visible: _taskDeleteInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _deleteTaskById(widget.taskCounterItem.sId!);
                      },
                      icon: const Icon(Icons.delete_outline)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showUpdateDialogue(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
        );
      },
    );
  }

  bool _isCurrentSelectStatus(String status) {
    return widget.taskCounterItem.status! == status;
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskInProgress = true;
    setState(() {});

    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    _updateTaskInProgress = false;
    if (response.isSucess) {
      _updateTaskInProgress = false;
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context,
            response.errorMessage ??
                'Update task status has been has been failed');
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _taskDeleteInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.deleteTaskById(id));
    _taskDeleteInProgress = false;
    if (response.isSucess) {
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBarMessage(
            context, response.errorMessage ?? 'Delete task has been failed');
      }
    }
  }
}
