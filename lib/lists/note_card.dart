import 'package:diary/lists/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final void Function(String) setFavorite;
  final void Function(String) setCompleted;
  final void Function(Note) dismissCard;

  const NoteCard({
    super.key,
    required this.note,
    required this.setCompleted,
    required this.setFavorite,
    required this.dismissCard,
  });

  @override
  Widget build(BuildContext context) {
    const marginNoteCard = EdgeInsets.symmetric(vertical: 5.0);
    return Dismissible(
      key: Key(note.id),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.centerLeft,
        margin: marginNoteCard,
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        dismissCard(note);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: marginNoteCard,
        child: Row(
          children: [
            Checkbox(
              shape: const CircleBorder(),
              value: note.isCompleted,
              onChanged: (value) {
                setCompleted(note.id);
              },
            ),
            Expanded(
              flex: 6,
              child: Text(note.title),
            ),
            IconButton(
              icon: Icon(note.isFavorite ? Icons.star : Icons.star_border, color: Colors.yellow),
              onPressed: () => setFavorite(note.id),
            )
          ],
        ),
      ),
    );
  }
}
