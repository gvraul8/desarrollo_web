import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/note.dart';

class NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onEdit;

  NoteCard({required this.note, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: ListTile(
        title: Text(
          note.title,
          style: Theme.of(context).textTheme.headline6,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.description,
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              'Última edición: ${DateFormat('dd/MM/yyyy HH:mm').format(note.lastEdited)}',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: onEdit,
        ),
        onTap: () {
          _showNoteDetails(context, note);
        },
      ),
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
