class StepNote {
  final String id;
  final String title;
  final bool isCompleted;

  const StepNote({
    required this.title,
    required this.isCompleted,
    required this.id,
  });

  StepNote copyWith({String? id, bool? isCompleted, String? title}) {
    return StepNote(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
