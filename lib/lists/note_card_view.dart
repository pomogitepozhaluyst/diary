import 'package:diary/lists/note.dart';
import 'package:flutter/material.dart';

class NoteCardView extends StatelessWidget {
  final Note thisNote;
  final List<Note> notes;
  final void Function(Note) setFavorite;
  final void Function(Note) setCompleted;
  final void Function(Note) dismissCard;

  const NoteCardView({
    super.key,
    required this.notes,
    required this.thisNote,
    required this.setCompleted,
    required this.setFavorite,
    required this.dismissCard,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(thisNote.id),
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.centerLeft,
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Container(
          margin: const EdgeInsets.all(10.0),
          child: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        dismissCard(thisNote);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        child: Row(
          children: [
            Expanded(
              child: Checkbox(
                shape: const CircleBorder(),
                value: thisNote.isCompleted,
                onChanged: (value) {
                  setCompleted(thisNote);
                },
              ),
            ),
            Expanded(
              flex: 6,
              child: ListTile(
                title: Text(thisNote.title),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(thisNote.isFavorite ? Icons.star : Icons.star_border, color: Colors.yellow),
                onPressed: () => {
                  setFavorite(thisNote),
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
