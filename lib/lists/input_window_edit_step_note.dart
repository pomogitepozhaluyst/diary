import 'package:diary/lists/note.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputWindowEditNote extends StatefulWidget {
  final String hintText;
  final String title;
  final String initialInput;
  final void Function(String) onSubmit;
  final void Function(String, bool) onSetFavorite;
  final Note note;

  const InputWindowEditNote({
    super.key,
    required this.title,
    required this.hintText,
    required this.onSubmit,
    this.initialInput = '',
    required this.onSetFavorite,
    required this.note,
  });

  @override
  InputWindowEditNoteState createState() => InputWindowEditNoteState();
}

class InputWindowEditNoteState extends State<InputWindowEditNote> {
  String? errorMessage;
  late String stringFromInputField;
  late final TextEditingController controller;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    stringFromInputField = widget.initialInput;
    controller = TextEditingController();
    controller.text = stringFromInputField;
    isFavorite = widget.note.isFavorite;
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            onChanged: (value) => stringFromInputField = value,
            controller: controller,
            maxLength: 40,
            maxLengthEnforcement: MaxLengthEnforcement.none,
            decoration: InputDecoration(
              errorText: errorMessage,
              hintText: widget.hintText,
            ),
          ),
          Row(
            children: [
              IconButton(
                icon: Icon(isFavorite ? Icons.star : Icons.star_border, color: Colors.yellow),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                  });
                },
              ),
              const Text('Избранное'),
            ],
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            List<dynamic> returnValue = [widget.note.title, widget.note.isFavorite];
            Navigator.of(context).pop(returnValue);
          },
          child: const Text('Отмена'),
        ),
        TextButton(
          onPressed: () {
            if (stringFromInputField.isEmpty) {
              setState(() {
                errorMessage = 'Название не может быть пустым';
              });
            } else if (stringFromInputField.length > 40) {
              setState(() {
                errorMessage = 'Слишком длинное название';
              });
            } else {
              List<dynamic> returnValue = [stringFromInputField, isFavorite];
              Navigator.of(context).pop(returnValue);

              widget.onSubmit(stringFromInputField);
              widget.onSetFavorite(widget.note.id, isFavorite);
            }
          },
          child: const Text('Ок'),
        ),
      ],
    );
  }
}
