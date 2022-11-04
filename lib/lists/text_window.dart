import 'package:flutter/material.dart';

class TextWindow extends StatefulWidget {
  final String title;
  final String text;
  final Function()? submit;
  const TextWindow({
    super.key,
    required this.title,
    required this.text,
    required this.submit,
  });

  @override
  TextWindowState createState() => TextWindowState();
}

class TextWindowState extends State<TextWindow> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Text(widget.text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            widget.submit!();
            Navigator.of(context).pop();
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
