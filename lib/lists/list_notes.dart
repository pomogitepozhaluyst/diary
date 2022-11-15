import 'package:diary/lists/empty_list_view.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/note_card_view.dart';
import 'package:flutter/material.dart';

class ListNotes extends StatelessWidget {
  final void Function(Note) setFavorite;
  final void Function(Note) setCompleted;
  final void Function(Note) dismissCard;

  final List<Note> notes;
  final List<Note> showNotes;

  const ListNotes({
    super.key,
    required this.notes,
    required this.showNotes,
    required this.setFavorite,
    required this.dismissCard,
    required this.setCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return showNotes.isEmpty
        ? const EmptyList()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ListView.builder(
              itemCount: showNotes.length,
              itemBuilder: (BuildContext context, int index) {
                return NoteCardView(
                  thisNote: showNotes[index],
                  notes: notes,
                  setCompleted: setCompleted,
                  setFavorite: setFavorite,
                  dismissCard: dismissCard,
                );
              },
            ),
          );
  }
}
