class NoteStep {
  final String id;
  final String title;
  final bool isCompleted;

  const NoteStep({
    required this.title,
    required this.isCompleted,
    required this.id,
  });

  NoteStep copyWith({String? id, bool? isCompleted, String? title}) {
    return NoteStep(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
