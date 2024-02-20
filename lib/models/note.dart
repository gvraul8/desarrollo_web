class Note {
  String title;
  String description;
  DateTime lastEdited;

  Note({this.title = '', this.description = '', DateTime? lastEdited})
      : lastEdited = lastEdited ?? DateTime.now();
}
