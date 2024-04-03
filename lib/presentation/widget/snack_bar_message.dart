import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showSnackBarMessage(String message, [bool isErrorMessage = false]) {
  Get.snackbar('', message,
      backgroundColor: isErrorMessage ? Colors.red : Colors.greenAccent,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 1));
}
