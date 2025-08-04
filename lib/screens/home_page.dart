import 'package:flutter/material.dart';
import 'package:note_app/constants/constants.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/screens/add_note_page.dart';
import 'package:note_app/screens/search_screen.dart';
import 'package:note_app/widgets/chips.dart';
import 'package:note_app/widgets/note_builder.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text('Notes', style: Constants().nunitoBold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 21),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              ),
              child: Chips(icon: Icons.search),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Chips(icon: Icons.info_outline_rounded),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Consumer<NoteProvider>(
          builder: (context, provider, child) {
            final notes = provider.notesList;

            if (notes.isEmpty) {
              return Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height / 6),
                    Image.asset('assets/rafiki.png'),
                    Text(
                      'Create your first note !',
                      style: Constants().nunitoMed.copyWith(fontSize: 20),
                    ),
                  ],
                ),
              );
            } else {
              return const NoteBuilder();
            }
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        splashColor: Colors.grey,
        shape: const CircleBorder(),
        elevation: 5,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddNotePage()),
        ),
        backgroundColor: const Color.fromRGBO(37, 37, 37, 1),
        child: const Icon(Icons.add, size: 45),
      ),
    );
  }
}
