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
