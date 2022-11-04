import 'package:diary/lists/app_bar.dart';
import 'package:diary/lists/empty_list_view.dart';
import 'package:diary/lists/input_window.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_card_view.dart';
import 'package:diary/lists/text_window.dart';
import 'package:diary/lists/variables.dart';
import 'package:flutter/material.dart';

class TaskBranch extends StatefulWidget {
  const TaskBranch({Key? key}) : super(key: key);

  @override
  State<TaskBranch> createState() => _TaskBranchState();
}

class _TaskBranchState extends State<TaskBranch> with Variable {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBarView(
        updateDisplayListByConditions: updateDisplayListByConditions,
        deleteCompleted: confirmDeleteCompleted,
        submitEditVector: submitEditVector,
        hideCompleted: hideCompleted,
        onlyFavorites: onlyFavorites,
        editVector: editVector,
      ),
      body: Variable.displayedListView.isEmpty
          ? const EmptyList()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              child: ListView.builder(
                itemCount: Variable.displayedListView.length,
                itemBuilder: (BuildContext context, int index) {
                  return NoteCardView(
                    key2: Variable.displayedListView[index].id,
                    updateDisplayListByConditions: updateDisplayListByConditions,
                  );
                },
              ),
            ),
      floatingActionButton: buttonCallWindowAddNote(),
    );
  }

  FloatingActionButton buttonCallWindowAddNote() {
    return FloatingActionButton(
      onPressed: () {
        callWindowAddNote();
      },
      backgroundColor: Colors.deepOrange,
      child: const Text(
        '+',
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 30,
        ),
      ),
    );
  }

  void confirmDeleteCompleted() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TextWindow(
          title: 'Подтвердите удаление',
          text: 'Удалить выполненные задачи? Это действие необратимо.',
          submit: deleteCompleted,
        );
      },
    );
  }

  void callWindowAddNote() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputWindow(
          title: 'Создать задачу',
          hintText: 'Введите название задачи',
          submit: submit,
        );
      },
    );
  }

  void deleteCompleted() {
    Variable.listView.removeWhere((note) => note.isCompleted);
    updateDisplayListByConditions();
  }

  void updateDisplayListByConditions() {
    Variable.displayedListView = Variable.listView;
    setState(
      () => {
        if (Variable.isOnlyFavoriteShown)
          {
            Variable.displayedListView = Variable.displayedListView.where((element) => element.isFavorite).toList(),
          },
        if (Variable.isCompletedHide)
          {
            Variable.displayedListView = Variable.displayedListView.where((element) => !element.isCompleted).toList(),
          }
      },
    );
  }

  void editVector() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return InputWindow(
          title: 'Редактировать ветку',
          hintText: 'Введите название ветки',
          submit: submitEditVector,
          userInput: Variable.mainTitle,
        );
      },
    );
  }

  void submitEditVector(String userInput) {
    setState(
      () {
        Variable.mainTitle = userInput;
      },
    );
  }

  void hideCompleted() {
    Variable.isCompletedHide = !Variable.isCompletedHide;
    updateDisplayListByConditions();
  }

  void onlyFavorites() {
    Variable.isOnlyFavoriteShown = !Variable.isOnlyFavoriteShown;
    updateDisplayListByConditions();
  }

  void submit(String userInput) {
    setState(
      () {
        Variable.listView.add(
          Note(
            title: userInput,
            isFavorite: false,
            isCompleted: false,
          ),
        );
        updateDisplayListByConditions();
      },
    );
  }
}
