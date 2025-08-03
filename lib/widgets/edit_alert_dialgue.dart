import 'package:flutter/material.dart';
import 'package:note_app/constants/constants.dart';
import 'package:note_app/models/note_model.dart';
import 'package:note_app/providers/note_provider.dart';

class EditAlertDialgue extends StatelessWidget {
  final NoteModel oldNote;
  final NoteProvider noteProvider;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  const EditAlertDialgue({
    super.key,
    required this.oldNote,
    required this.noteProvider,
    required this.titleController,
    required this.descriptionController,
  });

  @override
  Widget build(BuildContext context) {
    final updatedNote = NoteModel(
      title: titleController.text,
      description: descriptionController.text,
      color: oldNote.color,
    );

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      icon: Padding(
        padding: const EdgeInsets.fromLTRB(125, 21, 125, 16),
        child: const Icon(Icons.info, size: 30),
      ),
      title: Padding(
        padding: const EdgeInsets.fromLTRB(38, 0, 30, 15),
        child: Text(
          "Save Changes?",
          textAlign: TextAlign.center,
          style: Constants().nunitoMed.copyWith(color: Colors.white),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  titleController.text = oldNote.title;
                  descriptionController.text = oldNote.description;

                  Navigator.pop(context);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Changes discarded.',
                        style: Constants().nunitoMed.copyWith(fontSize: 16),
                      ),
                    ),
                  );
                },
                child: const Text('Discard', style: TextStyle(fontSize: 16)),
              ),
            ),
            const SizedBox(width: 17.5),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(48, 190, 113, 1),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  noteProvider.updateNote(updatedNote, oldNote);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Note updated successfully!')),
                  );
                },
                child: const Text('Save', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
