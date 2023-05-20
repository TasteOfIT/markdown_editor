import 'package:flutter/material.dart';
import 'package:markdown_editor/view/controller.dart';

class InsertBar extends StatefulWidget {
  final Controller _controller;

  const InsertBar(this._controller, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _InsertBarState();
  }
}

class _InsertBarState extends State<InsertBar> {
  late List<InsertBarItemData> _items;
  late Controller _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget._controller;
    _items = [
      InsertBarItemData(Icons.format_bold, () {
        _insertText('****', isMoveSelectionToInsertEnd: false);
      }),
      InsertBarItemData(Icons.format_italic, () {
        _insertText('**', isMoveSelectionToInsertEnd: false);
      }),
      InsertBarItemData(Icons.format_list_bulleted, () {
        _insertText('- ');
      }),
      InsertBarItemData(Icons.format_list_numbered, () {
        _insertText('1. ');
      }),
      InsertBarItemData(Icons.format_quote, () {
        _insertText('> ');
      }),
      InsertBarItemData(Icons.link, () {
        _insertText('[]()');
      }),
      InsertBarItemData(Icons.image, () {
        _insertText('![]()');
      }),
      InsertBarItemData(Icons.code, () {
        _insertText('``', isMoveSelectionToInsertEnd: false);
      }),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _items.length,
          itemBuilder: (context, index) {
            return InsertBarItem(
              data: _items[index],
              onTap: _items[index].onTap,
            );
          },
        ),
      ),
    );
  }

  void _insertText(String text, {bool isMoveSelectionToInsertEnd = true}) {
    final selection = _controller.selection;
    final start = selection.start;
    final end = selection.end;

    final textBefore = _controller.data.substring(0, start);
    final textAfter = _controller.data.substring(end);
    final newText = textBefore + text + textAfter;

    _controller.data = newText;
    if (isMoveSelectionToInsertEnd) {
      _controller.selection =
          TextSelection.fromPosition(TextPosition(offset: start + text.length));
    } else {
      _controller.selection = TextSelection.fromPosition(
        TextPosition(offset: start + text.length ~/ 2),
      );
    }
  }
}

class InsertBarItem extends StatelessWidget {
  const InsertBarItem({Key? key, required this.data, required this.onTap})
      : super(key: key);

  final InsertBarItemData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Icon(
          data.icon,
          size: 30,
        ));
  }
}

class InsertBarItemData {
  const InsertBarItemData(this.icon, this.onTap);

  final IconData icon;
  final VoidCallback onTap;
}
