import 'package:diary/lists/note.dart';
import 'package:flutter/material.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final void Function(String, bool) setFavorite;
  final void Function(String) setCompleted;
  final void Function(Note) dismissCard;
  final void Function(Note) goToNextScreen;

  const NoteCard({
    super.key,
    required this.note,
    required this.goToNextScreen,
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
              child: InkWell(
                onTap: () {
                  goToNextScreen(note);
                },
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: note.stepsNote.isNotEmpty
                      ? Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                note.title,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${note.stepsNote.where((iteratorStepsNote) => iteratorStepsNote.isCompleted).length} из ${note.stepsNote.length}',
                                style: const TextStyle(color: Colors.black45, fontSize: 13),
                              ),
                            ),
                          ],
                        )
                      : Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            note.title,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                ),
              ),
            ),
            IconButton(
              icon: Icon(note.isFavorite ? Icons.star : Icons.star_border, color: Colors.yellow),
              onPressed: () => setFavorite(note.id, !note.isFavorite),
            )
          ],
        ),
      ),
    );
  }
}
