import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_step.dart';
import 'package:flutter/material.dart';

class StepNoteCard extends StatefulWidget {
  final Note note;
  final NoteStep stepNote;
  final void Function(NoteStep) changeTitleStepNote;
  final Future<void> Function(NoteStep) setCompleted;
  final void Function(NoteStep) deleteCard;

  const StepNoteCard({
    super.key,
    required this.changeTitleStepNote,
    required this.note,
    required this.stepNote,
    required this.setCompleted,
    required this.deleteCard,
  });

  @override
  StepNoteCardState createState() => StepNoteCardState();
}

class StepNoteCardState extends State<StepNoteCard> {
  late String stringFromInputField;
  late final TextEditingController controller;
  late NoteStep stepNote;
  @override
  void initState() {
    super.initState();
    stringFromInputField = widget.stepNote.title;
    controller = TextEditingController();
    controller.text = stringFromInputField;
    stepNote = widget.stepNote;
  }

  @override
  void didUpdateWidget(StepNoteCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    stringFromInputField = widget.stepNote.title;
    //controller = TextEditingController();
    controller.text = stringFromInputField;
    stepNote = widget.stepNote;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 10.0,
        right: 10,
      ),
      child: Row(
        key: Key(stepNote.id),
        children: [
          Checkbox(
            shape: const CircleBorder(),
            value: stepNote.isCompleted,
            onChanged: (value) {
              setState(() {
                stepNote = stepNote.copyWith(isCompleted: !stepNote.isCompleted);
                widget.setCompleted(stepNote);
              });
            },
          ),
          Expanded(
            flex: 6,
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Введите шаг',
                border: InputBorder.none,
              ),
              style: TextStyle(decoration: (stepNote.isCompleted) ? TextDecoration.lineThrough : TextDecoration.none),
              textInputAction: TextInputAction.none,
              maxLines: null,
              onChanged: (value) {
                stringFromInputField = value;
                widget.changeTitleStepNote(widget.stepNote.copyWith(title: stringFromInputField));
              },
            ),
          ),
          InkWell(
            onTap: () {
              widget.deleteCard(widget.stepNote);
            },
            child: const Icon(Icons.close, color: Colors.black),
          ),
        ],
      ),
    );
  }
}
