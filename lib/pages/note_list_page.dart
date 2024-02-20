import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/note_card.dart';
import '../models/note.dart';

class NoteListPage extends StatefulWidget {
  @override
  _NoteListPageState createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {
  List<Note> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notas'),
      ),
      body: ListView.builder(
        itemCount: notes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              _showNoteDetails(context, notes[index]);
            },
            child: NoteCard(
              note: notes[index],
              onEdit: () {
                _editNoteDialog(context, index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addNoteDialog(context);
        },
        tooltip: 'Agregar Nota',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _addNoteDialog(BuildContext context) async {
    Note newNote = Note();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Nueva Nota'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  newNote.title = value;
                },
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                onChanged: (value) {
                  newNote.description = value;
                },
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                newNote.lastEdited = DateTime.now();
                setState(() {
                  notes.add(newNote);
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _editNoteDialog(BuildContext context, int index) async {
    Note editedNote = notes[index];

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar Nota'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                onChanged: (value) {
                  editedNote.title = value;
                },
                controller: TextEditingController(text: editedNote.title),
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                onChanged: (value) {
                  editedNote.description = value;
                },
                controller: TextEditingController(text: editedNote.description),
                style: Theme.of(context).textTheme.bodyText2,
                decoration: InputDecoration(labelText: 'Descripción'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                editedNote.lastEdited = DateTime.now();
                setState(() {
                  notes[index] = editedNote;
                });
                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _showNoteDetails(BuildContext context, Note note) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            note.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                note.description,
                style: Theme.of(context).textTheme.bodyText2,
              ),
              SizedBox(height: 10),
              Text(
                'Última edición: ${DateFormat('dd/MM/yyyy HH:mm').format(note.lastEdited)}',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
