import 'package:diary/lists/note.dart';

abstract class Variable {
  static bool isCompletedHide = false;
  static bool isOnlyFavoriteShown = false;
  static List<Note> listView = [];
  static List<Note> displayedListView = [];
  static var mainTitle = 'Учеба';
}
