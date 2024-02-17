import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notas App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Roboto',
        textTheme: TextTheme(
          headline6: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyText2: TextStyle(fontSize: 16),
        ),
      ),
      home: NoteList(),
    );
  }
}

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
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
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: ListTile(
              title: Text(
                notes[index].title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notes[index].description,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  Text(
                    'Última edición: ${DateFormat('dd/MM/yyyy HH:mm').format(notes[index].lastEdited)}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  _editNoteDialog(context, index);
                },
              ),
              onTap: () {
                _showNoteDetails(context, notes[index]);
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
    return showDialog(
      context: context,
      builder: (context) {
        Note newNote = Note();

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
    return showDialog(
      context: context,
      builder: (context) {
        Note editedNote = notes[index];

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

class Note {
  String title;
  String description;
  DateTime lastEdited;

  Note({this.title = '', this.description = '', DateTime? lastEdited})
      : lastEdited = lastEdited ?? DateTime.now();
}
