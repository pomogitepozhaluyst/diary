import 'package:diary/lists/variables.dart';
import 'package:flutter/material.dart';

class NoteCardView extends StatefulWidget {
  final String key2;

  final Function()? updateDisplayListByConditions;

  const NoteCardView({
    super.key,
    required this.key2,
    required this.updateDisplayListByConditions,
  });

  @override
  NoteCardViewState createState() => NoteCardViewState();
}

class NoteCardViewState extends State<NoteCardView> {
  @override
  Widget build(BuildContext context) {
    final elId = Variable.listView.indexOf(Variable.listView.firstWhere((element) => element.id == widget.key2));
    return Dismissible(
      key: Key(widget.key2),
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
        Variable.listView.removeWhere((element) => element.id == widget.key2);
        widget.updateDisplayListByConditions!();
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
                value: Variable.listView[elId].isCompleted,
                onChanged: (value) {
                  Variable.listView[elId].isCompleted = !Variable.listView[elId].isCompleted;
                  widget.updateDisplayListByConditions!();
                },
              ),
            ),
            Expanded(
              flex: 6,
              child: ListTile(
                title: Text(Variable.listView[elId].title),
              ),
            ),
            Expanded(
              child: IconButton(
                icon: Icon(Variable.listView[elId].isFavorite ? Icons.star : Icons.star_border, color: Colors.yellow),
                onPressed: () => {
                  Variable.listView[elId].isFavorite = !Variable.listView[elId].isFavorite,
                  widget.updateDisplayListByConditions!(),
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
