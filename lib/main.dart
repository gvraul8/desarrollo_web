import 'package:flutter/material.dart';
import 'pages/note_list_page.dart';

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
      home: NoteListPage(),
    );
  }
}
