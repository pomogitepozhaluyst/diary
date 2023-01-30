import 'package:diary/lists/note_step.dart';

class Note {
  final String id;
  final String title;
  final bool isFavorite;
  final bool isCompleted;
  final String dateOfCreation;
  final String notice;
  final List<NoteStep> stepsNote;
  final String countCompletedAndNotCompleted;

  Note({
    required this.title,
    required this.isFavorite,
    required this.isCompleted,
    required this.id,
    required this.dateOfCreation,
    this.countCompletedAndNotCompleted = '',
    this.notice = '',
    this.stepsNote = const [],
  });

  Note copyWith({
    String? id,
    bool? isFavorite,
    bool? isCompleted,
    String? title,
    List<NoteStep>? stepsNote,
    List<NoteStep>? shownStepsNote,
    String? dateOfCreation,
    String? notice,
    String? countCompletedAndNotCompleted,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      isFavorite: isFavorite ?? this.isFavorite,
      isCompleted: isCompleted ?? this.isCompleted,
      dateOfCreation: dateOfCreation ?? this.dateOfCreation,
      stepsNote: stepsNote ?? this.stepsNote,
      notice: notice ?? this.notice,
      countCompletedAndNotCompleted: countCompletedAndNotCompleted ?? this.countCompletedAndNotCompleted,
    );
  }
}
