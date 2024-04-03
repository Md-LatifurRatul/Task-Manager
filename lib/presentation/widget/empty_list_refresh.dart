import 'package:flutter/material.dart';
import 'package:project_task_manager/presentation/widget/empty_list_message_widget.dart';

class EmptyListRefresh extends StatelessWidget {
  const EmptyListRefresh({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: EmptyListMessageWidget()),
    );
  }
}
