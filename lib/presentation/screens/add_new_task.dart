import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_task_manager/presentation/controllers/add_new_task_controller.dart';
import 'package:project_task_manager/presentation/widget/background_widget.dart';
import 'package:project_task_manager/presentation/widget/profile_app_bar.dart';
import 'package:project_task_manager/presentation/widget/snack_bar_message.dart';
import 'package:project_task_manager/presentation/widget/text_field_validator.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AddNewTaskController _addNewTaskControler =
      Get.find<AddNewTaskController>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Get.back(result: _addNewTaskControler.shouldRefreshBackToNewTaskList);
      },
      child: Scaffold(
        appBar: profileAppbar,
        body: BackGroundWidget(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 48,
                    ),
                    Text(
                      'Add New Task',
                      style: Get.theme.textTheme.titleLarge
                          ?.copyWith(fontSize: 24),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(
                        hintText: "Title",
                      ),
                      validator: (value) => TextFieldValidator.textValidator(
                          value, 'Enter your title'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 6,
                      decoration:
                          const InputDecoration(hintText: 'Description'),
                      validator: (value) => TextFieldValidator.textValidator(
                          value, 'Enter your description'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: GetBuilder<AddNewTaskController>(
                          builder: (addNewTaskController) {
                        return Visibility(
                          visible: addNewTaskController.inProgress == false,
                          replacement: const Center(
                            child: CircularProgressIndicator(),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _addNewTask();
                              }
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    final result = await _addNewTaskControler.getAddNewTaskController(
        _titleController, _descriptionController, "New");

    if (result) {
      showSnackBarMessage("New task has been added");
    } else {
      showSnackBarMessage("Adding new task has been failed", true);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
