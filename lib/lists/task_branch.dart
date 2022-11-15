import 'package:diary/lists/app_bar.dart';
import 'package:diary/lists/input_window.dart';
import 'package:diary/lists/list_notes.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/text_window.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TaskBranchScreen extends StatefulWidget {
  const TaskBranchScreen({super.key});

  @override
  TaskBranchScreenState createState() => TaskBranchScreenState();
}

class TaskBranchScreenState extends State<TaskBranchScreen> {
  late List<Note> notes;
  late List<Note> showNotes;

  late bool isOnlyFavoriteShown;
  late bool isCompletedHidden;

  late String branchTitle;

  @override
  void initState() {
    super.initState();
    branchTitle = "Учеба";
    isOnlyFavoriteShown = false;
    isCompletedHidden = false;
    notes = [];
    showNotes = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBarView(
        isOnlyFavoriteShown: isOnlyFavoriteShown,
        isCompletedHidden: isCompletedHidden,
        branchTitle: branchTitle,
        deleteCompleted: _showDeleteCompletedConfirmationDialog,
        hideCompleted: _hideCompleted,
        onlyFavorites: _onlyFavorites,
        editMainTitle: _editBranchTitle,
      ),
      body: ListNotes(
        notes: notes,
        showNotes: showNotes,
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
          submit: _submitAddNote,
        );
      },
    );
  }

  void _submitAddNote(String nameNote) {
    notes.add(
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
    isCompletedHidden = !isCompletedHidden;
    _updateDisplayListByConditions();
  }

  void _onlyFavorites() {
    isOnlyFavoriteShown = !isOnlyFavoriteShown;
    _updateDisplayListByConditions();
  }

  void _deleteCompleted() {
    notes.removeWhere((note) => note.isCompleted);
    _updateDisplayListByConditions();
  }

  void _updateDisplayListByConditions() {
    showNotes = notes;
    setState(() {
      if (isOnlyFavoriteShown && isCompletedHidden) {
        showNotes = showNotes.where((element) => (element.isFavorite && !element.isCompleted)).toList();
      } else if (isOnlyFavoriteShown) {
        showNotes = showNotes.where((element) => element.isFavorite).toList();
      } else if (isCompletedHidden) {
        showNotes = showNotes.where((element) => !element.isCompleted).toList();
      }
    });
  }

  void _editBranchTitle() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputWindow(
          title: 'Редактировать ветку',
          hintText: 'Введите название ветки',
          submit: _submitEditBranchTitle,
          startInput: branchTitle,
        );
      },
    );
  }

  void _submitEditBranchTitle(String newMainTitle) {
    setState(() {
      branchTitle = newMainTitle;
    });
  }

  void _showDeleteCompletedConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TextWindow(
          title: 'Подтвердите удаление',
          text: 'Удалить выполненные задачи? Это действие необратимо.',
          submit: _deleteCompleted,
        );
      },
    );
  }

  void _setFavorite(Note thisNote) {
    thisNote.isFavorite = !thisNote.isFavorite;
    _updateDisplayListByConditions();
  }

  void _setCompleted(Note thisNote) {
    thisNote.isCompleted = !thisNote.isCompleted;
    _updateDisplayListByConditions();
  }

  void _dismissCard(Note thisNote) {
    notes.removeWhere((element) => element.id == thisNote.id);
    _updateDisplayListByConditions();
  }
}
