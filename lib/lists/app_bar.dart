import 'package:diary/lists/pop_up_menu.dart';
import 'package:diary/lists/variables.dart';
import 'package:flutter/material.dart';

class AppBarView extends StatefulWidget with Variable implements PreferredSizeWidget {
  final Function(String)? submitEditVector;
  final Function? updateDisplayListByConditions;
  final Function? deleteCompleted;
  final Function? hideCompleted;
  final Function? onlyFavorites;
  final Function? editVector;
  AppBarView({
    super.key,
    required this.submitEditVector,
    required this.updateDisplayListByConditions,
    required this.deleteCompleted,
    required this.hideCompleted,
    required this.onlyFavorites,
    required this.editVector,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  AppBarViewState createState() => AppBarViewState();
}

class AppBarViewState extends State<AppBarView> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(Variable.mainTitle),
      centerTitle: true,
      backgroundColor: Colors.deepOrange,
      actions: [
        PopupMenuButton<PopUp>(
          onSelected: (item) => item.onClicked!(),
          itemBuilder: (context) => [
            createItem(
              PopUp(
                title: Variable.isCompletedHide ? 'Показать выполненные' : 'Скрыть выполненные',
                icon: Variable.isCompletedHide ? Icons.check_circle_outline : Icons.check_circle,
                onClicked: widget.hideCompleted,
              ),
            ),
            createItem(
              PopUp(
                title: Variable.isOnlyFavoriteShown ? 'Все задачи' : 'Только Избранные',
                icon: Variable.isOnlyFavoriteShown ? Icons.star_outline : Icons.star,
                onClicked: widget.onlyFavorites,
              ),
            ),
            createItem(
              PopUp(
                title: 'Удалить выполненные',
                icon: Icons.delete_outline,
                onClicked: widget.deleteCompleted,
              ),
            ),
            createItem(
              PopUp(
                title: 'Редактировать ветку',
                icon: Icons.edit_outlined,
                onClicked: widget.editVector,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
