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
      builder: (ctx) => Dialog(
        backgroundColor: const Color(0xFF1D1E33),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.info, size: 28, color: Colors.grey),
              const SizedBox(height: 15),
              Text(
                'Are you sure you want to delete this note?',
                style: Constants().nunitoMed.copyWith(
                  color: Colors.white,
                  fontSize: 23,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        setState(() {
                          isDeleteMode = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF30BE71),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: Constants().nunitoMed.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Delete',
                        style: Constants().nunitoMed.copyWith(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
              Positioned(
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
