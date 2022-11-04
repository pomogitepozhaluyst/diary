import 'package:uuid/uuid.dart';

class Note {
  final id = const Uuid().v4();
  String title = '';
  bool isFavorite = false;
  bool isCompleted = false;

  Note(
      {required this.title,
      required this.isFavorite,
      required this.isCompleted});
}
