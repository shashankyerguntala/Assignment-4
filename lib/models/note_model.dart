import 'dart:ui';

class NoteModel {
  final String title;
  final String description;
  final Color? color;
  const NoteModel({required this.title, required this.description, this.color});
}
