import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notes/constants/colors.dart';
import 'package:notes/models/note.dart';
import 'package:notes/screens/edit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filteredNotes = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
    filteredNotes = samplenotes;
  }

  getRandomColor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  void deleteitem(int index) {
    setState(() {
      Note note = filteredNotes[index];
      samplenotes.remove(note);
      filteredNotes.removeAt(index);
    });
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredNotes = samplenotes
          .where((note) =>
              note.content.toLowerCase().contains(searchText.toLowerCase()) ||
              note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if (sorted) {
      notes.sort((a, b) => a.modifiedtime.compareTo(b.modifiedtime));
    } else {
      notes.sort((b, a) => a.modifiedtime.compareTo(b.modifiedtime));
    }
    sorted = !sorted;
    return notes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 0),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notes',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    filteredNotes = sortNotesByModifiedTime(filteredNotes);
                  });
                },
                icon: Container(
                  padding: EdgeInsets.all(0),
                  height: 40,
                  width: 40,
                  child: Icon(Icons.sort),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10)),
                ),
                color: Colors.white,
              )
            ],
          ),
          SizedBox(
            height: 20,
          ),
          TextField(
            onChanged: onSearchTextChanged,
            style: TextStyle(fontSize: 16, color: Colors.white),
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              hintText: 'Search Notes',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.grey,
              ),
              fillColor: Colors.grey.shade800,
              filled: true,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.transparent)),
            ),
          ),
          Expanded(
              child: ListView.builder(
            padding: EdgeInsets.only(top: 30.0),
            itemCount: filteredNotes.length,
            itemBuilder: (context, index) {
              return Card(
                margin: EdgeInsets.only(bottom: 20),
                color: getRandomColor(),
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ListTile(
                    onTap: () async {
                      final result = await Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                EditScreen(note: filteredNotes[index]),
                          ));
                    },
                    title: RichText(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: '${filteredNotes[index].title} \n',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                height: 1.5),
                            children: [
                              TextSpan(
                                  text: '${filteredNotes[index].content}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14,
                                      height: 1.5))
                            ])),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '${DateFormat('EEE MMM d, yyyy h:mm a').format(filteredNotes[index].modifiedtime)}',
                        style: TextStyle(
                            fontSize: 10,
                            fontStyle: FontStyle.italic,
                            color: Colors.grey.shade800),
                      ),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          deleteitem(index);
                        },
                        icon: Icon(Icons.delete)),
                  ),
                ),
              );
            },
          ))
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute<void>(
                  builder: (BuildContext context) => const EditScreen()));
        },
        backgroundColor: Colors.grey.shade800,
        child: Icon(
          Icons.add,
          size: 38,
        ),
      ),
    );
  }
}
