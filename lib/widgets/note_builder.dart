import 'package:flutter/material.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/widgets/notes_cards.dart';
import 'package:provider/provider.dart';

class NoteBuilder extends StatefulWidget {
  const NoteBuilder({super.key});

  @override
  State<NoteBuilder> createState() => _NoteBuilderState();
}

class _NoteBuilderState extends State<NoteBuilder> {
  @override
  Widget build(BuildContext context) {
    return Consumer<NoteProvider>(
      builder: (context, noteProvider, child) => Expanded(
        child: ListView.builder(
          itemCount: noteProvider.notesList.length,
          itemBuilder: (context, index) {
            return NotesCards(
              note: noteProvider.notesList[index],
              noteProvider: noteProvider,
            );
          },
        ),
      ),
    );
  }
}
