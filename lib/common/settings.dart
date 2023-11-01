import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void lockScreen(bool enable) {
  if (enable) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  } else {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }
}

String textDelimiter(String text, int length) {
  bool isOverflowed = true;

  if (text.length <= length) isOverflowed = false;

  if (isOverflowed) {
    String newText = "";

    for (int i = 0; i < length; i++) {
      newText += text[i];
    }

    newText += "...";

    return newText;
  }

  return text;
}

Future<void> showSuccesfulAlert(BuildContext context, String title,
    String message) async {
  final buttons = [
    // ignore: prefer_const_constructors
    FilledButton(onPressed: () async {
      Navigator.of(context).pop();
    }, child: Text("Ok")),
  ];

  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("ℹ $title"),
          content: Text(message),
          actions: buttons,
        );
      });
}
