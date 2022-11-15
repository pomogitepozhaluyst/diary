import 'package:diary/lists/pop_up_item_data.dart';
import 'package:flutter/material.dart';

class PopUp extends PopupMenuItem<PopupMenuItemData> {
  final PopupMenuItemData data;

  PopUp({super.key, required this.data})
      : super(
          value: data,
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Icon(
                  data.icon,
                  color: Colors.grey,
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(data.title),
              )
            ],
          ),
        );
}
