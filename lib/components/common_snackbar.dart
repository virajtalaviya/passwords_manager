import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommonSnackBar {
  static void showsnackBar(String message) {
    Get.rawSnackbar(
      message: message,
      margin: const EdgeInsets.all(10),
      borderRadius: 10,
      snackStyle: SnackStyle.FLOATING,
    );
  }
}
