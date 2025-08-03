import 'package:flutter/material.dart';
import 'package:note_app/constants/constants.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/screens/edit_page.dart';

class NotesCards extends StatefulWidget {
  final NoteModel note;
  final NoteProvider noteProvider;

  const NotesCards({super.key, required this.note, required this.noteProvider});

  @override
  State<NotesCards> createState() => _NotesCardsState();
}

class _NotesCardsState extends State<NotesCards> {
  bool isDeleteMode = false;

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1D1E33),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          'Delete Note?',
          style: Constants().nunitoMed.copyWith(color: Colors.white),
        ),
        content: Text(
          'Are you sure you want to delete this note?',
          style: Constants().nunitoMed.copyWith(color: Colors.white70),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pop(ctx);
              setState(() {
                isDeleteMode = false;
              });
            },
            child: const Text('No', style: TextStyle(fontSize: 16)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(48, 190, 113, 1),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              widget.noteProvider.deleteNote(widget.note);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Note deleted successfully.',
                    style: Constants().nunitoMed.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
            child: const Text('Yes', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: GestureDetector(
        onLongPress: () {
          setState(() {
            isDeleteMode = true;
          });
        },
        onTap: () {
          if (!isDeleteMode) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EditPage(note: widget.note),
              ),
            );
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDeleteMode ? Colors.red : widget.note.color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.fromLTRB(46, 22, 29, 21),
              child: Text(
                widget.note.title,
                style: Constants().nunitoNotes.copyWith(
                  color: isDeleteMode ? Colors.red : Colors.black,
                ),
              ),
            ),
            if (isDeleteMode)
              Positioned.fill(
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                    onPressed: () => showDeleteDialog(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
