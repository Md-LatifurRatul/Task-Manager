import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';

class StatusListItem extends StatelessWidget {
  final String status;
  final bool isSelected;
  final Function(String) onTap;

  const StatusListItem({
    required this.status,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(status),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () {
        if (!isSelected) {
          onTap(status);
          Get.back();
          // Navigator.pop(context);
        }
      },
    );
  }
}
