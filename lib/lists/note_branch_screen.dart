import 'package:diary/lists/colors_all_screens.dart';
import 'package:diary/lists/confirmation_dialog.dart';
import 'package:diary/lists/input_window.dart';
import 'package:diary/lists/input_window_edit_step_note.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_branch_screen_app_bar.dart';
import 'package:diary/lists/note_screen.dart';
import 'package:diary/lists/note_step.dart';
import 'package:diary/lists/notes_list.dart';
import 'package:diary/lists/resultDialogEditNote.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class NoteBranchScreen extends StatefulWidget {
  const NoteBranchScreen({super.key});

  @override
  NoteBranchScreenState createState() => NoteBranchScreenState();
}

class NoteBranchScreenState extends State<NoteBranchScreen> {
  late List<Note> _notes;
  late List<Note> _shownNotes;

  late bool _isOnlyFavoriteShown;
  late bool _isCompletedHidden;

  late String _branchTitle;

  @override
  void initState() {
    super.initState();
    _branchTitle = "Учеба";
    _isOnlyFavoriteShown = false;
    _isCompletedHidden = false;
    _notes = [];
    _shownNotes = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsScreens.backgroundColor,
      appBar: NoteBranchScreenAppBar(
        isOnlyFavoriteShown: _isOnlyFavoriteShown,
        isCompletedHidden: _isCompletedHidden,
        branchTitle: _branchTitle,
        deleteCompleted: _showDeleteCompletedNotesConfirmationDialog,
        hideCompleted: _hideCompletedNotes,
        onlyFavorites: _onlyFavoritesNotes,
        editMainTitle: _editBranchTitle,
      ),
      body: NotesList(
        notes: _shownNotes,
        setCompleted: _setCompletedNote,
        setFavorite: _setFavoriteNote,
        dismissCard: _dismissCard,
        goToNextScreen: _goToNoteScreen,
      ),
      floatingActionButton: _buildFab(context),
    );
  }

  Widget _buildFab(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        _showAddNoteDialog(context);
      },
      backgroundColor: Colors.deepOrange,
      child: const Icon(Icons.add),
    );
  }

  void _showAddNoteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputWindow(
          title: 'Создать задачу',
          hintText: 'Введите название задачи',
          onSubmit: _addNote,
        );
      },
    );
  }

  void _addNote(String nameNote) {
    _notes.add(
      Note(
        title: nameNote,
        isFavorite: false,
        isCompleted: false,
        id: const Uuid().v4(),
        dateOfCreation: DateFormat('dd.MM.yyyy HH:mm').format(DateTime.now().toLocal()),
      ),
    );
    _updateDisplayListByConditions();
  }

  void _hideCompletedNotes() {
    _isCompletedHidden = !_isCompletedHidden;
    _updateDisplayListByConditions();
  }

  void _onlyFavoritesNotes() {
    _isOnlyFavoriteShown = !_isOnlyFavoriteShown;
    _updateDisplayListByConditions();
  }

  void _deleteCompletedNotes() {
    _notes.removeWhere((note) => note.isCompleted);
    _updateDisplayListByConditions();
  }

  void _updateDisplayListByConditions() {
    setState(() {
      Iterable<Note> shownNotesIterable = _notes;
      if (_isOnlyFavoriteShown) {
        shownNotesIterable = shownNotesIterable.where((note) => note.isFavorite).toList();
      }
      if (_isCompletedHidden) {
        shownNotesIterable = shownNotesIterable.where((note) => !note.isCompleted).toList();
      }
      _shownNotes = shownNotesIterable.toList();
    });
  }

  void _editBranchTitle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputWindow(
          title: 'Редактировать ветку',
          hintText: 'Введите название ветки',
          onSubmit: _setBranchTitle,
          initialInput: _branchTitle,
        );
      },
    );
  }

  void _setBranchTitle(String newMainTitle) {
    setState(() {
      _branchTitle = newMainTitle;
    });
  }

  Future<void> _showDeleteCompletedNotesConfirmationDialog() async {
    bool getValue = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return const ConfirmationDialog(
              title: 'Подтвердите удаление',
              text: 'Удалить выполненные задачи? Это действие необратимо.',
            );
          },
        ) ??
        false;
    if (getValue) {
      _deleteCompletedNotes();
    }
  }

  void _setFavoriteNote(String id, bool statusFavorite) {
    final index = _notes.indexWhere((note) => note.id == id);
    _notes[index] = _notes[index].copyWith(isFavorite: statusFavorite);
    _updateDisplayListByConditions();
  }

  void addStepNote(Note note) {
    final index = _notes.indexWhere((element) => element.id == note.id);
    _notes[index] = note;
    _updateDisplayListByConditions();
  }

  Note _setCompletedNote(String id) {
    final index = _notes.indexWhere((note) => note.id == id);
    _notes[index] = _notes[index].copyWith(isCompleted: !_notes[index].isCompleted);
    _updateDisplayListByConditions();
    return _notes[index];
  }

  void _dismissCard(Note thisNote) {
    _notes.removeWhere((element) => element.id == thisNote.id);
    _updateDisplayListByConditions();
  }

  void _goToNoteScreen(Note note) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => NoteScreen(
        note: note,
        setCompletedNote: _setCompletedNote,
        deleteStepsNoteCompleted: _deleteStepsCompleted,
        deleteNote: _deleteNote,
        editNote: _editNote,
        setCompletedStepNote: _setCompletedNoteStep,
        addStepNote: addStepNote,
        deleteStepNote: _deleteNoteStep,
        changeNoteNotice: _changeNoteNotice,
        changeTitleStepNote: _changeTitleNoteStep,
      ),
    ));
  }

  void _deleteNoteStep(Note note, NoteStep stepNote) {
    final indexNote = _notes.indexWhere((iteratorNote) => (iteratorNote.id == note.id));

    _notes[indexNote].stepsNote.removeWhere((iteratorNote) => (iteratorNote.id == stepNote.id));
    _notes[indexNote] = _notes[indexNote].copyWith(
      countCompletedAndNotCompleted:
          '${note.stepsNote.where((iteratorStepsNote) => iteratorStepsNote.isCompleted).length} из ${note.stepsNote.length}',
    );
    _updateDisplayListByConditions();
  }

  void _deleteNote(Note note) {
    _notes.removeWhere((iteratorNote) => (note.id == iteratorNote.id));
    _updateDisplayListByConditions();
  }

  Future<ResultDialogEditNote> _editNote(Note note) async {
    ResultDialogEditNote resultDialog = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return InputWindowEditNote(
                title: 'Редактировать задачу',
                hintText: 'Введите название задачи',
                onSubmit: (String title) {
                  setState(() {
                    final index = _notes.indexWhere((iteratorNote) => iteratorNote.id == note.id);

                    _notes[index] =
                        _notes.where((iteratorNote) => (iteratorNote.id == note.id)).toList()[0].copyWith(title: title);
                  });
                },
                onSetFavorite: _setFavoriteNote,
                initialInput: note.title,
                note: note);
          },
        ) ??
        ResultDialogEditNote(isFavorite: false, title: note.title);
    return resultDialog;
  }

  void _deleteStepsCompleted(Note note) {
    final indexNote = _notes.indexWhere((iteratorNote) => (iteratorNote.id == note.id));

    _notes
        .where((iteratorNote) => (iteratorNote.id == note.id))
        .first
        .stepsNote
        .removeWhere((iteratorNote) => (iteratorNote.isCompleted));
    _notes[indexNote] = _notes[indexNote].copyWith(
      countCompletedAndNotCompleted:
          '${note.stepsNote.where((iteratorStepsNote) => iteratorStepsNote.isCompleted).length} из ${note.stepsNote.length}',
    );
    _updateDisplayListByConditions();
  }

  bool _setCompletedNoteStep(Note note, NoteStep stepNote) {
    final indexNote = _notes.indexWhere((iteratorNote) => iteratorNote.id == note.id);

    final indexStepNote =
        _notes[indexNote].stepsNote.indexWhere((iteratorStepNote) => iteratorStepNote.id == stepNote.id);
    _notes[indexNote].stepsNote[indexStepNote] = _notes[indexNote]
        .stepsNote[indexStepNote]
        .copyWith(isCompleted: !_notes[indexNote].stepsNote[indexStepNote].isCompleted);
    _notes[indexNote] = _notes[indexNote].copyWith(
      countCompletedAndNotCompleted:
          '${_notes[indexNote].stepsNote.where((iteratorStepsNote) => iteratorStepsNote.isCompleted).length} из ${note.stepsNote.length}',
    );
    _updateDisplayListByConditions();

    return (_notes[indexNote].stepsNote.where((iteratorStepsNote) => iteratorStepsNote.isCompleted).length ==
            _notes[indexNote].stepsNote.length &&
        !_notes[indexNote].isCompleted);
  }

  void _changeNoteNotice(Note note) {
    final index = _notes.indexWhere((iteratorNote) => iteratorNote.id == note.id);
    _notes[index] = note;
    _updateDisplayListByConditions();
  }

  void _changeTitleNoteStep(Note note, NoteStep stepNote) {
    final indexNote = _notes.indexWhere((iteratorNote) => iteratorNote.id == note.id);
    final indexStepNote = _notes[indexNote].stepsNote.indexWhere((note) => note.id == stepNote.id);

    _notes[indexNote].stepsNote[indexStepNote] =
        _notes[indexNote].stepsNote[indexStepNote].copyWith(title: stepNote.title);
  }
}
