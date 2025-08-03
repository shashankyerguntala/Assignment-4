import 'package:flutter/material.dart';
import 'package:note_app/models/note_model.dart';

class NoteProvider extends ChangeNotifier {
  List<NoteModel> notesList = [];

  bool _isSearching = false;
  String _searchQuery = '';

  bool get isSearching => _isSearching;
  String get searchQuery => _searchQuery;

  List<NoteModel> get filteredNotes {
    if (_searchQuery.isEmpty) {
      return [];
    }
    return notesList
        .where(
          (note) =>
              note.title.toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
  }

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

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void startSearch() {
    _isSearching = true;
    notifyListeners();
  }

  void stopSearch() {
    _isSearching = false;
    _searchQuery = '';
    notifyListeners();
  }
}
