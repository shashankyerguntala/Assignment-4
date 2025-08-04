import 'package:flutter/material.dart';
import 'package:note_app/constants/constants.dart';

import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/screens/edit_page.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final query = searchController.text.toLowerCase();

    return SafeArea(
      top: true,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 0,
          title: Container(
            height: 50,
            margin: EdgeInsets.fromLTRB(27, 0, 27, 0),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(59, 59, 59, 1),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                    child: TextField(
                      controller: searchController,
                      autofocus: true,
                      style: Constants().nunitoMed.copyWith(
                        color: Colors.white,
                      ),
                      cursorColor: Colors.white,
                      decoration: InputDecoration(
                        hintText: 'Search by the keyword...',
                        hintStyle: Constants().nunitoMed.copyWith(fontSize: 20),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                        ),
                      ),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),

        body: Consumer<NoteProvider>(
          builder: (context, provider, _) {
            final notes = provider.notesList;
            final filteredNotes = query.isEmpty
                ? []
                : notes
                      .where((note) => note.title.toLowerCase().contains(query))
                      .toList();

            if (query.isEmpty) {
              return Center(
                child: Text(
                  'Search by title...',
                  style: Constants().nunitoMed.copyWith(
                    fontSize: 24,
                    color: const Color.fromARGB(255, 119, 119, 119),
                  ),
                ),
              );
            }

            if (filteredNotes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/cuate.png', height: 200),
                    const SizedBox(height: 10),
                    Text(
                      'File not found. Try searching again!',
                      style: Constants().nunitoMed.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 12),
              itemCount: filteredNotes.length,
              separatorBuilder: (context, builder) =>
                  const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final note = filteredNotes[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EditPage(note: note)),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 20,
                    ),
                    decoration: BoxDecoration(
                      color: note.color,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      note.title,
                      style: Constants().nunitoBold.copyWith(
                        fontSize: 22,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
