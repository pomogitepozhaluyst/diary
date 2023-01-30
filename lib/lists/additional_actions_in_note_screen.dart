import 'package:flutter/material.dart';

class AdditionalActionsInNoteScreen extends StatelessWidget {
  const AdditionalActionsInNoteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            _buildItem(
              icon: const Icon(
                Icons.notifications_active_outlined,
              ),
              title: 'Напомнить',
              onTap: () {},
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black45),
                ),
              ),
            ),
            _buildItem(
              icon: const Icon(
                Icons.date_range,
              ),
              title: 'Добавить дату выполнения',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem({required Icon icon, required String title, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            icon,
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Text(
                title,
                //'Напомнить',
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
