import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWindow extends StatefulWidget {
  final String hintText;
  final String title;
  final String userInput;

  final Function(String)? submit;
  const InputWindow({
    super.key,
    required this.title,
    required this.hintText,
    required this.submit,
    this.userInput = '',
  });

  @override
  InputWindowState createState() => InputWindowState();
}

class InputWindowState extends State<InputWindow> {
  String? errorMessage;
  String userInput = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    userInput = widget.userInput;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.text = userInput;
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: controller,
        onChanged: (String value) {
          userInput = value;
        },
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
            errorMessage = null;
            Navigator.of(context).pop();
            userInput = '';
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            if (userInput.isEmpty) {
              setState(
                () {
                  errorMessage = 'Название не может быть пустым';
                },
              );
            } else if (userInput.length <= 40) {
              errorMessage = null;
              widget.submit!(userInput);
              Navigator.of(context).pop();
              userInput = '';
            } else {
              setState(
                () {
                  errorMessage = 'Слишком длинное название';
                },
              );
            }
          },
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
