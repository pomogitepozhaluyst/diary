import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_step.dart';
import 'package:diary/lists/step_note_card.dart';
import 'package:flutter/material.dart';

class StepsNoteList extends StatefulWidget {
  final Note note;
  final void Function() addStepNote;
  final Future<void> Function(NoteStep) deleteStepNote;
  final Future<void> Function(NoteStep) setCompletedStepNote;
  final void Function(Note) changeNoteNotice;
  final void Function(NoteStep) changeStepNoteTitle;

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
  late String stringFromInputFieldNotice;
  late final TextEditingController controllerForInputNotice;
  @override
  void initState() {
    super.initState();
    stringFromInputFieldNotice = widget.note.notice;
    controllerForInputNotice = TextEditingController();
    controllerForInputNotice.text = stringFromInputFieldNotice;
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
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            dateOfCreation(),
            ListView.builder(
              itemCount: widget.note.stepsNote.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  key: Key(widget.note.stepsNote[index].id),
                  child: StepNoteCard(
                    note: widget.note,
                    stepNote: widget.note.stepsNote[index],
                    deleteCard: widget.deleteStepNote,
                    setCompleted: widget.setCompletedStepNote,
                    changeTitleStepNote: widget.changeStepNoteTitle,
                  ),
                );
              },
            ),
            addWidgetStepNote(),
            lineUnderAddWidgetStepNote(),
            noticeWidget(),
          ],
        ),
      ),
    );
  }

  Padding dateOfCreation() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 10),
      child: Align(
        alignment: Alignment.topLeft,
        child: Text('Создано: ${widget.note.dateOfCreation}'),
      ),
    );
  }

  Padding addWidgetStepNote() {
    return Padding(
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
    );
  }

  Container lineUnderAddWidgetStepNote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Colors.black45),
        ),
      ),
    );
  }

  Padding noticeWidget() {
    return Padding(
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
    );
  }
}
