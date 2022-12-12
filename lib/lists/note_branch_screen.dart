import 'package:diary/lists/confirmation_dialog.dart';
import 'package:diary/lists/input_window.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_branch_screen_app_bar.dart';
import 'package:diary/lists/notes_list.dart';
import 'package:flutter/material.dart';
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
      backgroundColor: Colors.deepPurple,
      appBar: NoteBranchScreenAppBar(
        isOnlyFavoriteShown: _isOnlyFavoriteShown,
        isCompletedHidden: _isCompletedHidden,
        branchTitle: _branchTitle,
        deleteCompleted: _showDeleteCompletedConfirmationDialog,
        hideCompleted: _hideCompleted,
        onlyFavorites: _onlyFavorites,
        editMainTitle: _editBranchTitle,
      ),
      body: NotesList(
        notes: _shownNotes,
        setCompleted: _setCompleted,
        setFavorite: _setFavorite,
        dismissCard: _dismissCard,
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
      ),
    );
    _updateDisplayListByConditions();
  }

  void _hideCompleted() {
    _isCompletedHidden = !_isCompletedHidden;
    _updateDisplayListByConditions();
  }

  void _onlyFavorites() {
    _isOnlyFavoriteShown = !_isOnlyFavoriteShown;
    _updateDisplayListByConditions();
  }

  void _deleteCompleted() {
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

  Future<void> _showDeleteCompletedConfirmationDialog() async {
    if (await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ConfirmationDialog(
          title: 'Подтвердите удаление',
          text: 'Удалить выполненные задачи? Это действие необратимо.',
        );
      },
    )) {
      _deleteCompleted();
    }
  }

  void _setFavorite(String id) {
    final index = _notes.indexWhere((note) => note.id == id);
    _notes[index] = _notes[index].copyWith(isFavorite: !_notes[index].isFavorite);
    _updateDisplayListByConditions();
  }

  void _setCompleted(String id) {
    final index = _notes.indexWhere((note) => note.id == id);
    _notes[index] = _notes[index].copyWith(isCompleted: !_notes[index].isCompleted);
    _updateDisplayListByConditions();
  }

  void _dismissCard(Note thisNote) {
    _notes.removeWhere((element) => element.id == thisNote.id);
    _updateDisplayListByConditions();
  }
}
