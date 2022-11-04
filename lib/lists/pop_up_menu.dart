import 'package:flutter/material.dart';

PopupMenuItem<PopUp> createItem(PopUp other) {
  return PopupMenuItem<PopUp>(
    value: other,
    child: other,
  );
}

class PopUp extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function? onClicked;
  const PopUp({
    super.key,
    required this.title,
    required this.icon,
    required this.onClicked,
  });
  @override
  PopUpState createState() => PopUpState();
}

class PopUpState extends State<PopUp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Icon(
            widget.icon,
            color: Colors.grey,
          ),
        ),
        Expanded(
          flex: 5,
          child: Text(widget.title),
        )
      ],
    );
  }
}
