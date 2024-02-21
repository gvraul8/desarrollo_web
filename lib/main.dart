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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pinkAccent,
        fontFamily: 'Roboto',
        textTheme: const TextTheme(
          titleLarge:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          bodyMedium:  TextStyle(fontSize: 16),
        ),
      ),
      home: NoteListPage(),
    );
  }
}
