class NoteControler {
  // SET CONTROLLER
  var noteList = [];

  void addNote(id, note, description) {
    noteList.add({
      'id': id,
      'note': note,
      'description': description,
    });
  }

  void deleteNote(id) {
    noteList.removeWhere((element) => element['id'] == id);
  }
}
