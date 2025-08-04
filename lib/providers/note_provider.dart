import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> notesList = [];

  void addNote(NoteModel note) {
    notesList.add(note);
    notifyListeners();
  }

  void deleteNote(NoteModel note) {
    notesList.remove(note);
    notifyListeners();
  }

  void updateNote(NoteModel newNote, NoteModel oldNote) {
    final index = notesList.indexOf(oldNote);
    if (index != -1) {
      notesList[index] = newNote;
      notifyListeners();
    }
  }
}
