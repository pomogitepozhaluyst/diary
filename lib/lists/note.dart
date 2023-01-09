import 'package:diary/lists/step_note.dart';

class Note {
  final String id;
  final String title;
  final bool isFavorite;
  final bool isCompleted;
  final String dateOfCreation;
  final String notice;
  List<StepNote> stepsNote;

  Note({
    required this.title,
    required this.isFavorite,
    required this.isCompleted,
    required this.id,
    required this.dateOfCreation,
    this.notice = '',
    required this.stepsNote,
  });

  Note copyWith({
    String? id,
    bool? isFavorite,
    bool? isCompleted,
    String? title,
    List<StepNote>? stepsNote,
    List<StepNote>? shownStepsNote,
    String? dateOfCreation,
    String? notice,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      isCompleted: isCompleted ?? this.isCompleted,
      dateOfCreation: dateOfCreation ?? this.dateOfCreation,
      stepsNote: stepsNote ?? this.stepsNote,
      notice: notice ?? this.notice,
    );
  }
}
