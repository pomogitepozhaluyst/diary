import 'package:diary/lists/note.dart';
import 'package:diary/lists/step_note.dart';
import 'package:diary/lists/step_note_card.dart';
import 'package:flutter/material.dart';

class StepsNoteList extends StatefulWidget {
  final Note note;
  final void Function() addStepNote;
  final Future<void> Function(StepNote) deleteStepNote;
  final Future<void> Function(StepNote) setCompletedStepNote;
  final void Function(Note) changeNoteNotice;
  final void Function(StepNote) changeStepNoteTitle;

  const StepsNoteList({
    super.key,
    required this.note,
    required this.addStepNote,
    required this.setCompletedStepNote,
    required this.changeNoteNotice,
    required this.deleteStepNote,
    required this.changeStepNoteTitle,
  });

  @override
  StepsNoteListState createState() => StepsNoteListState();
}

class StepsNoteListState extends State<StepsNoteList> {
  late Note note;

  late String stringFromInputFieldNotice;
  late final TextEditingController controllerForInputNotice;
  @override
  void initState() {
    super.initState();
    stringFromInputFieldNotice = widget.note.notice;
    controllerForInputNotice = TextEditingController();
    controllerForInputNotice.text = stringFromInputFieldNotice;
    note = widget.note;
  }

  @override
  void dispose() {
    controllerForInputNotice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text('Создано: ${note.dateOfCreation}'),
              ),
            ),
            ListView.builder(
                itemCount: note.stepsNote.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    key: Key(note.stepsNote[index].id),
                    child: StepNoteCard(
                      note: widget.note,
                      stepNote: widget.note.stepsNote[index],
                      deleteCard: widget.deleteStepNote,
                      setCompleted: widget.setCompletedStepNote,
                      changeTitleStepNote: widget.changeStepNoteTitle,
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.only(bottom: 17, left: 15, right: 15, top: 5),
              child: InkWell(
                onTap: widget.addStepNote,
                child: Row(
                  children: const [
                    Icon(Icons.add, color: Colors.deepOrange),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        'Добавить шаг',
                        style: TextStyle(color: Colors.deepOrange, fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black45),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: TextField(
                onChanged: (value) {
                  stringFromInputFieldNotice = value;
                  widget.changeNoteNotice(widget.note.copyWith(notice: stringFromInputFieldNotice));
                },
                controller: controllerForInputNotice,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Заметки по задаче...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
