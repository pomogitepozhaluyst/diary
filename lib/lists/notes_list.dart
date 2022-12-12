import 'package:diary/lists/empty_task_list.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_card.dart';
import 'package:flutter/material.dart';

class NotesList extends StatelessWidget {
  final void Function(String) setFavorite;
  final void Function(String) setCompleted;
  final void Function(Note) dismissCard;

  final List<Note> notes;

  const NotesList({
    super.key,
    required this.notes,
    required this.setFavorite,
    required this.dismissCard,
    required this.setCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return notes.isEmpty
        ? const EmptyTaskList()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ListView.builder(
              itemCount: notes.length,
              itemBuilder: (BuildContext context, int index) {
                return NoteCard(
                  note: notes[index],
                  setCompleted: setCompleted,
                  setFavorite: setFavorite,
                  dismissCard: dismissCard,
                );
              },
            ),
          );
  }
}
