import 'package:flutter/material.dart';
import 'package:note_app/constants/constants.dart';
import 'package:note_app/models/note_model.dart';

import 'package:note_app/providers/note_provider.dart';

import 'package:note_app/widgets/chips.dart';
import 'package:note_app/widgets/edit_alert_dialgue.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  const EditPage({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController titleController;
  late TextEditingController desController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.note.title);
    desController = TextEditingController(text: widget.note.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Chips(icon: Icons.chevron_left_sharp),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 23),
            child: Consumer<NoteProvider>(
              builder: (context, noteProvider, child) => GestureDetector(
                onTap: () {
                  final title = titleController.text;
                  final desc = desController.text;

                  if (title.isEmpty || desc.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Note is empty!")),
                    );
                    return;
                  }

                  showDialog(
                    context: context,
                    builder: (_) => EditAlertDialgue(
                      oldNote: widget.note,
                      noteProvider: noteProvider,
                      titleController: titleController,
                      descriptionController: desController,
                    ),
                  );
                },

                child: Chips(icon: Icons.mode),
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(24, 40, 24, 40),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                maxLines: null,
                style: Constants().nunitoBold.copyWith(fontSize: 35),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hint: Text('Title', style: Constants().nunitoFaint),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: TextField(
                  controller: desController,
                  maxLines: null,
                  style: Constants().nunitoBold.copyWith(fontSize: 23),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hint: Text(
                      'Type something...',
                      style: Constants().nunitoMed,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
