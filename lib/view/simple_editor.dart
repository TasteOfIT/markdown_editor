import 'package:flutter/material.dart';

import 'controller.dart';

class SimpleEditor extends StatefulWidget {
  const SimpleEditor(this.hint, this.controller, {super.key});

  final String hint;
  final Controller controller;

  @override
  State<StatefulWidget> createState() {
    return _SimpleEditorState();
  }
}

class _SimpleEditorState extends State<SimpleEditor> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      widget.controller.notifyContentChanged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: widget.hint,
      ),
      maxLines: 99999,
      scrollPadding: const EdgeInsets.all(20.0),
      keyboardType: TextInputType.multiline,
      autofocus: true,
      controller: widget.controller,
    );
  }
}
