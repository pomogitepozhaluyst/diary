import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWindow extends StatefulWidget {
  final String hintText;
  final String title;
  final String initialInput;
  final void Function(String) onSubmit;

  const InputWindow({
    super.key,
    required this.title,
    required this.hintText,
    required this.onSubmit,
    this.initialInput = '',
  });

  @override
  InputWindowState createState() => InputWindowState();
}

class InputWindowState extends State<InputWindow> {
  String? errorMessage;
  late String stringFromInputField;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    stringFromInputField = widget.initialInput;
    controller = TextEditingController();
    controller.text = stringFromInputField;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        onChanged: (value) => stringFromInputField = value,
        controller: controller,
        maxLength: 40,
        maxLengthEnforcement: MaxLengthEnforcement.none,
        decoration: InputDecoration(
          errorText: errorMessage,
          hintText: widget.hintText,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            errorMessage = null;
            stringFromInputField = '';
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            if (stringFromInputField.isEmpty) {
              setState(() {
                errorMessage = 'Название не может быть пустым';
              });
            } else if (stringFromInputField.length >= 40) {
              setState(() {
                errorMessage = 'Слишком длинное название';
              });
            } else {
              Navigator.of(context).pop();
              widget.onSubmit(stringFromInputField);
            }
          },
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
