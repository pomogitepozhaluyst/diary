import 'package:flutter/material.dart';

class TextWindow extends StatelessWidget {
  final String title;
  final String text;
  final Function() submit;

  const TextWindow({
    super.key,
    required this.title,
    required this.text,
    required this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(text),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            submit();
            Navigator.of(context).pop();
          },
          child: const Text('Подтвердить'),
        ),
      ],
    );
  }
}
