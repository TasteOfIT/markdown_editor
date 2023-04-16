import 'package:flutter/material.dart';

abstract class EditorCallback {
  void onTitleDetected(String title);

  void onContentChanged(String content);
}

class Controller extends TextEditingController {
  Controller(this.id, String initialData, {this.callback}) : super(text: initialData);

  final String id;
  final EditorCallback? callback;

  String get data => value.text;

  set data(String data) {
    text = data;
  }

  void notifyContentChanged() {
    callback?.onContentChanged(data);
  }

  void notifyTitleDetected(String title) {
    callback?.onTitleDetected(title);
  }
}
