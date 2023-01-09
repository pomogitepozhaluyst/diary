import 'package:diary/lists/additional_actions_in_note_screen.dart';
import 'package:diary/lists/colors_all_screens.dart';
import 'package:diary/lists/confirmation_dialog.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/pictures_in_note_screen.dart';
import 'package:diary/lists/step_note.dart';
import 'package:diary/lists/step_note_screen_app_bar.dart';
import 'package:diary/lists/steps_note_list.dart';
import 'package:flutter/material.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  final void Function(Note) deleteNote;
  final Future<List<dynamic>> Function(Note) editNote;
  final void Function(Note) deleteStepsNoteCompleted;
  final void Function(String) setCompletedNote;
  final bool Function(String) getStatusFavorite;
  final bool Function(Note, StepNote) setCompletedStepNote;
  final void Function(Note) addStepNote;
  final void Function(Note, StepNote) deleteStepNote;
  final void Function(Note) changeNoteNotice;

  const NoteScreen({
    super.key,
    required this.setCompletedNote,
    required this.getStatusFavorite,
    required this.note,
    required this.deleteNote,
    required this.deleteStepsNoteCompleted,
    required this.editNote,
    required this.setCompletedStepNote,
    required this.addStepNote,
    required this.deleteStepNote,
    required this.changeNoteNotice,
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
            deleteStepsNoteCompleted: _deleteStepsNoteCompleted,
            note: widget.note,
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: 1,
              (BuildContext context, int index) {
                return Column(
                  children: [
                    StepsNoteList(
                      note: note,
                      addStepNote: _addStepNote,
                      setCompletedStepNote: _setCompletedStepNote,
                      changeNoteNotice: widget.changeNoteNotice,
                      deleteStepNote: _deleteStepNote,
                      changeStepNoteTitle: _changeStepNoteTitle,
                    ),
                    /*
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Material(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
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
                                      deleteCard: _deleteStepNote,
                                      setCompleted: _setCompletedStepNote,
                                      changeTitleStepNote: _changeStepNoteTitle,
                                    ),
                                  );
                                }),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 17, left: 15, right: 15, top: 5),
                              child: InkWell(
                                onTap: _addStepNote,
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
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),*/
                    const AdditionalActionsInNoteScreen(),
                    const PicturesInNoteScreen(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFabChangeCompleteState(),
    );
  }

  Widget _buildFabChangeCompleteState() {
    return FloatingActionButton(
      child: Icon(note.isCompleted ? Icons.check : Icons.close),
      onPressed: () {
        setState(() {
          widget.setCompletedNote(widget.note.id);
          note = note.copyWith(isCompleted: !note.isCompleted);
        });
      },
    );
  }

  Future<void> _editNote() async {
    List<dynamic> getValue = await widget.editNote(note);
    setState(() {
      note = note.copyWith(title: getValue[0], isFavorite: getValue[1]);
    });
  }

  void _changeStepNoteTitle(StepNote newStepNote) {
    final index = widget.note.stepsNote.indexWhere((note) => note.id == newStepNote.id);

    widget.note.stepsNote[index] = widget.note.stepsNote[index].copyWith(title: newStepNote.title);
  }

  Future<void> _deleteStepNote(StepNote stepNote) async {
    if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
          title: 'Удалить шаг',
          text: 'Это действие нельзя отменить',
        );
      },
    )) {
      setState(() {
        widget.deleteStepNote(note, stepNote);
      });
    }
  }

  void _addStepNote() {
    setState(() {
      widget.addStepNote(widget.note);
    });
  }

  Future<void> _setCompletedStepNote(StepNote stepNote) async {
    if (widget.setCompletedStepNote(note, stepNote)) {
      if (await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const ConfirmationDialog(
            title: 'Все шаги выполнены',
            text: 'Хотите завершить задание?',
          );
        },
      )) {
        setState(() {
          widget.setCompletedNote(widget.note.id);
          note = note.copyWith(isCompleted: !note.isCompleted);
        });
      }
    }
  }

  Future<void> _deleteNote() async {
    if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
          title: 'Удалить задачу',
          text: 'Это действие нельзя отменить',
        );
      },
    )) {
      setState(() {
        widget.deleteNote(widget.note);
      });
    }
  }

  Future<void> _deleteStepsNoteCompleted() async {
    if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
          title: 'Подтвердите удаление',
          text: 'Удалить выполненые шаги? Это действие не обратимо',
        );
      },
    )) {
      setState(() {
        widget.deleteStepsNoteCompleted(widget.note);
      });
    }
  }
}
