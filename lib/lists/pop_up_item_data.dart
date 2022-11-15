import 'package:flutter/material.dart';

class PopupMenuItemData {
  final IconData icon;
  final String title;
  final Function onClicked;

  const PopupMenuItemData({
    required this.icon,
    required this.title,
    required this.onClicked,
  });
}
