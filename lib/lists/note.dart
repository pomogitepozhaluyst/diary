class Note {
  String id;
  String title;
  bool isFavorite;
  bool isCompleted;

  Note({
    required this.title,
    required this.isFavorite,
    required this.isCompleted,
    required this.id,
  });
}
