import 'package:intl/intl.dart';

class NoteControler {
  // SET CONTROLLER
  var noteList = [];

  String username = '';

  // DateTime.now() akan mendapatkan waktu saat ini berbentuk angka, lalu DateFormat dari package intl adalah format untuk mengubah DateTime.now() menjadi yang di inginkan contoh MMMMd() akan menampilkan format 'month' 'day/tanggal'
  String dateTime = DateFormat.MMMMd().format(DateTime.now());
  String hourTime = DateFormat.jm().format(DateTime.now());
  String yearTime = DateFormat.y().format(DateTime.now());

  void addNote(id, note, description) {
    noteList.add({
      'id': id,
      'note': note,
      'description': description,
      'date': dateTime,
      'hour': hourTime,
      'year': yearTime,
    });
  }

  void addNoteIcon(i, icon)  {
   noteList[i!]['icon'] =  icon;
  }

  void editNote(i, title, desc) {
    if (title == '' && desc == '') {
      noteList.removeWhere((element) => element['id'] == noteList[i]['id']);
    } else {
      noteList[i]['note'] = title;
      noteList[i]['description'] = desc;
      noteList[i]['date'] = dateTime;
      noteList[i]['hour'] = hourTime;
    }
  }

  void deleteNote(id) {
    noteList.removeWhere((element) => element['id'] == id);
  }
}
