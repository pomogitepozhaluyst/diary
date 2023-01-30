import 'package:diary/lists/colors_all_screens.dart';
import 'package:diary/lists/data_popup_menu_item.dart';
import 'package:diary/lists/note.dart';
import 'package:diary/lists/pop_up_item_data.dart';
import 'package:flutter/material.dart';

class NoteScreenAppBar extends StatelessWidget {
  final void Function() deleteNote;
  final VoidCallback editNote;
  final String titleNote;
  final Function() deleteStepsNoteCompleted;
  final Note note;

  const NoteScreenAppBar({
    super.key,
    required this.deleteNote,
    required this.editNote,
    required this.titleNote,
    required this.deleteStepsNoteCompleted,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      snap: true,
      floating: true,
      expandedHeight: 160.0,
      flexibleSpace: Padding(
        padding: const EdgeInsets.only(left: 80.0, right: 60.0),
        child: FlexibleSpaceBar(
          title: Text(titleNote),
          centerTitle: true,
        ),
      ),
      backgroundColor: ColorsScreens.appBarColor,
      actions: [
        PopupMenuButton<PopupMenuItemData>(
          onSelected: (item) => {
            item.onClicked(),
          },
          itemBuilder: (context) => [
            DataPopupMenuItem(
              data: PopupMenuItemData(
                title: 'Редактировать',
                icon: Icons.edit_outlined,
                onClicked: editNote,
              ),
            ),
            DataPopupMenuItem(
              data: PopupMenuItemData(
                title: 'Удалить задачу',
                icon: Icons.delete_outline,
                onClicked: deleteNote,
              ),
            ),
            DataPopupMenuItem(
              data: PopupMenuItemData(
                title: 'Удалить выполненные шаги',
                icon: Icons.delete_sweep_outlined,
                onClicked: deleteStepsNoteCompleted,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
