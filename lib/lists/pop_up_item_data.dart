import 'package:flutter/material.dart';

class PopupMenuItemData {
  final IconData icon;
  final String title;
  final VoidCallback onClicked;

  const PopupMenuItemData({
    required this.icon,
    required this.title,
    required this.onClicked,
  });
}
