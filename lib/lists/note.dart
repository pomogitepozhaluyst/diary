class Note {
  final String id;
  final String title;
  final bool isFavorite;
  final bool isCompleted;

  Note({
    required this.title,
    required this.isFavorite,
    required this.isCompleted,
    required this.id,
  });

  Note copyWith({String? id, bool? isFavorite, bool? isCompleted, String? title}) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
