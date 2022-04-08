import 'package:intl/intl.dart';

class NoteControler {
  // SET CONTROLLER
  var noteList = [];

  // DateTime.now() akan mendapatkan waktu saat ini berbentuk angka, lalu DateFormat dari package intl adalah format untuk mengubah DateTime.now() menjadi yang di inginkan contoh MMMMd() akan menampilkan format 'month' 'day/tanggal' 
  String dateTime = DateFormat.MMMMd().format(DateTime.now());
  void addNote(id, note, description) {
    noteList.add({
      'id': id,
      'note': note,
      'description': description,
      'date': dateTime,
    });
  }

  void deleteNote(id) {
    noteList.removeWhere((element) => element['id'] == id);
  }
}
