import 'package:diary/lists/pop_up_item_data.dart';
import 'package:diary/lists/pop_up_menu.dart';
import 'package:flutter/material.dart';

class AppBarView extends StatelessWidget implements PreferredSizeWidget {
  final void Function() deleteCompleted;
  final void Function() hideCompleted;
  final void Function() onlyFavorites;
  final void Function() editMainTitle;

  final bool isCompletedHidden;
  final bool isOnlyFavoriteShown;

  final String branchTitle;

  const AppBarView({
    super.key,
    required this.deleteCompleted,
    required this.hideCompleted,
    required this.onlyFavorites,
    required this.isCompletedHidden,
    required this.isOnlyFavoriteShown,
    required this.branchTitle,
    required this.editMainTitle,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(branchTitle),
      centerTitle: true,
      backgroundColor: Colors.deepOrange,
      actions: [
        PopupMenuButton<PopupMenuItemData>(
          onSelected: (item) => item.onClicked(),
          itemBuilder: (context) => [
            PopUp(
              data: PopupMenuItemData(
                title: isCompletedHidden ? 'Показать выполненные' : 'Скрыть выполненные',
                icon: isCompletedHidden ? Icons.check_circle_outline : Icons.check_circle,
                onClicked: hideCompleted,
              ),
            ),
            PopUp(
              data: PopupMenuItemData(
                title: isOnlyFavoriteShown ? 'Все задачи' : 'Только Избранные',
                icon: isOnlyFavoriteShown ? Icons.star_outline : Icons.star,
                onClicked: onlyFavorites,
              ),
            ),
            PopUp(
              data: PopupMenuItemData(
                title: 'Удалить выполненные',
                icon: Icons.delete_outline,
                onClicked: deleteCompleted,
              ),
            ),
            PopUp(
              data: PopupMenuItemData(
                title: 'Редактировать ветку',
                icon: Icons.edit_outlined,
                onClicked: editMainTitle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
