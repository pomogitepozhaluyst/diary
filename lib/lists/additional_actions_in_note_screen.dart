import 'package:flutter/material.dart';

class AdditionalActionsInNoteScreen extends StatelessWidget {
  const AdditionalActionsInNoteScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Material(
        color: Colors.white,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.notifications_active_outlined,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Напомнить',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.black45),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: InkWell(
                onTap: () {},
                child: Row(
                  children: const [
                    Icon(
                      Icons.date_range,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        'Добавить дату выполнения',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
