import 'dart:math';

import 'package:flutter/material.dart';
import 'package:note_app/constants/constants.dart';
import 'package:note_app/models/note_model.dart';

import 'package:note_app/providers/note_provider.dart';

import 'package:note_app/widgets/chips.dart';
import 'package:provider/provider.dart';

class AddNotePage extends StatefulWidget {
  const AddNotePage({super.key});

  @override
  State<AddNotePage> createState() => _AddNotePageState();
}

class _AddNotePageState extends State<AddNotePage> {
  late TextEditingController titleController;
  late TextEditingController desController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    desController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final random = Random();
    final colors = Constants().noteColors;
    final color = colors[random.nextInt(colors.length)];
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
            padding: const EdgeInsets.only(right: 21),
            child: Chips(icon: Icons.remove_red_eye),
          ),

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

                  final note = NoteModel(
                    title: title,
                    description: desc,
                    color: color,
                  );
                  noteProvider.addNote(note);

                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Your changes have been saved successfully!',
                      ),
                    ),
                  );
                },

                child: Chips(icon: Icons.save),
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
