import 'package:flutter/material.dart';

class PopupMenuItemDataForNoteScreenAppBar {
  final IconData icon;
  final String title;
  final Function(String) onClicked;

  const PopupMenuItemDataForNoteScreenAppBar({
    required this.icon,
    required this.title,
    required this.onClicked,
  });
}
