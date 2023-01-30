import 'package:diary/lists/additional_actions_in_note_screen.dart';
import 'package:diary/lists/colors_all_screens.dart';
import 'package:diary/lists/confirmation_dialog.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_step.dart';
import 'package:diary/lists/pictures_in_note_screen.dart';
import 'package:diary/lists/resultDialogEditNote.dart';
import 'package:diary/lists/step_note_screen_app_bar.dart';
import 'package:diary/lists/steps_note_list.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  final void Function(Note note) deleteNote;
  final Future<ResultDialogEditNote> Function(Note note) editNote;
  final void Function(Note note) deleteStepsNoteCompleted;
  final Note Function(String idNote) setCompletedNote;
  final bool Function(Note note, NoteStep stepNote) setCompletedStepNote;
  final void Function(Note note) addStepNote;
  final void Function(Note note, NoteStep stepNote) deleteStepNote;
  final void Function(Note note) changeNoteNotice;
  final void Function(Note note, NoteStep stepNote) changeTitleStepNote;

  const NoteScreen({
    super.key,
    required this.setCompletedNote,
    required this.note,
    required this.deleteNote,
    required this.deleteStepsNoteCompleted,
    required this.editNote,
    required this.setCompletedStepNote,
    required this.addStepNote,
    required this.deleteStepNote,
    required this.changeNoteNotice,
    required this.changeTitleStepNote,
  });

  @override
  NoteScreenState createState() => NoteScreenState();
}

class NoteScreenState extends State<NoteScreen> {
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
  void didUpdateWidget(NoteScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
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
    return Scaffold(
      backgroundColor: ColorsScreens.backgroundColor,
      body: CustomScrollView(
        slivers: [
          NoteScreenAppBar(
            titleNote: note.title,
            deleteNote: _deleteNote,
            editNote: _editNote,
            deleteStepsNoteCompleted: _deleteNoteStepsCompleted,
            note: widget.note,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                StepsNoteList(
                  note: note,
                  addStepNote: _addNoteStep,
                  setCompletedStepNote: _setCompletedNoteStep,
                  changeNoteNotice: widget.changeNoteNotice,
                  deleteStepNote: _deleteStepNote,
                  changeStepNoteTitle: _changeNoteStepTitle,
                ),
                const AdditionalActionsInNoteScreen(),
                const PicturesInNoteScreen(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFabChangeCompleteState(),
    );
  }

  Widget _buildFabChangeCompleteState() {
    return FloatingActionButton(
      child: Icon(note.isCompleted ? Icons.close : Icons.check),
      onPressed: () {
        setState(() {
          note = widget.setCompletedNote(widget.note.id);
        });
      },
    );
  }

  Future<void> _editNote() async {
    ResultDialogEditNote resultDialogEditNote = await widget.editNote(note);
    setState(() {
      note = note.copyWith(title: resultDialogEditNote.title, isFavorite: resultDialogEditNote.isFavorite);
    });
  }

  void _changeNoteStepTitle(NoteStep newStepNote) {
    widget.changeTitleStepNote(note, newStepNote);
  }

  Future<void> _deleteStepNote(NoteStep stepNote) async {
    bool isConfirmed = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmationDialog(
              title: 'Удалить шаг',
              text: 'Это действие нельзя отменить',
            );
          },
        ) ??
        false;
    if (isConfirmed) {
      setState(() {
        widget.deleteStepNote(note, stepNote);
      });
    }
  }

  void _addNoteStep() {
    setState(() {
      final noteSteps = [
        ...note.stepsNote,
        NoteStep(
          title: '',
          isCompleted: false,
          id: const Uuid().v4(),
        ),
      ];

      note = note.copyWith(
        stepsNote: noteSteps,
        countCompletedAndNotCompleted:
            '${note.stepsNote.where((iteratorStepsNote) => iteratorStepsNote.isCompleted).length} из ${note.stepsNote.length + 1}',
      );
      widget.addStepNote(note);
    });
  }

  Future<void> _setCompletedNoteStep(NoteStep stepNote) async {
    if (widget.setCompletedStepNote(note, stepNote)) {
      bool getValue = await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const ConfirmationDialog(
                title: 'Все шаги выполнены',
                text: 'Хотите завершить задание?',
              );
            },
          ) ??
          false;
      if (getValue) {
        setState(() {
          widget.setCompletedNote(widget.note.id);
          note = note.copyWith(isCompleted: !note.isCompleted);
        });
      }
    }
  }

  Future<void> _deleteNote() async {
    bool getValue = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
          title: 'Удалить задачу',
          text: 'Это действие нельзя отменить',
        );
      },
    );
    if (getValue) {
      setState(() {
        widget.deleteNote(widget.note);
        Navigator.of(context).pop();
      });
    }
  }

  Future<void> _deleteNoteStepsCompleted() async {
    bool getValue = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmationDialog(
              title: 'Подтвердите удаление',
              text: 'Удалить выполненые шаги? Это действие не обратимо',
            );
          },
        ) ??
        false;
    if (getValue) {
      setState(() {
        widget.deleteStepsNoteCompleted(widget.note);
      });
    }
  }
}
