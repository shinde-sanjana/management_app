import 'package:flutter/material.dart';

class CustomSnackBar {
  static void show(BuildContext context,
      {required String message, Color bgColor = Colors.green}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
