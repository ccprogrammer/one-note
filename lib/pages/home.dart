import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:list_todo/controllers/todo_controller.dart';
import 'package:list_todo/pages/description_page.dart';
import 'package:list_todo/widgets/custom_button.dart';
import 'package:list_todo/widgets/custom_input_text.dart';
import 'package:list_todo/widgets/todo_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  bool exit = false;

  // Controller
  final c = TodoControler();
  final _panelC = PanelController();
  final textTodoName = TextEditingController();
  final textTodoDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Shared Preferences Section
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future saveData() async {
    final SharedPreferences prefs = await _prefs;

    // Tampung list note yang muncul di ui kedalam notes
    List notes = c.noteList;

    // lalu simpan notes ke dalam localstorage dengan di encode terlebih dahulu
    prefs.setString('notes', jsonEncode(notes));
  }

  Future loadData() async {
    final SharedPreferences prefs = await _prefs;

    // null check
    if (prefs.containsKey('notes')) {
      // ambil list notes dari localstorage dan tampung kedalam noteList
      final noteList = prefs.getString('notes');

      // lalu noteList di decode dan di simpan kedalam notes lalu notes akan berupa jadi list
      final notes = jsonDecode(noteList!);

      // notes di looping dan item di dalamnya di masukan kedalam c.noteList yang akan muncul di ui, notes[i] adalah itemnya
      for (var i = 0; i < notes.length; i++) {
        c.noteList.add(notes[i]);
        setState(() {});
      }
    }
  }

  Future deleteData() async {
    final SharedPreferences prefs = await _prefs;

    // semua key di hapus
    prefs.clear();

    // setelah di hapus akan di simpan kembail data ke localstorage, jadi di penyimpanan sementara/c.noteList itemnya terhapus lalu c.noteList yang sudah terhapus itemnya tadi akan di simpan kembali ke localstorage
    saveData();
  }

// Handler
  void handlePopPanel() {
    if (_panelC.isPanelOpen) {
      _panelC.close();
    } else {
      this.exit = true;
    }
  }

  void handleAdd() {
    c.addTodo(
      Random().nextInt(100),
      textTodoName.text,
      textTodoDesc.text,
    );
    saveData();
    _panelC.close();
    setState(() {});

    // dismiss keyboard on complete
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void clearTextField() {
    textTodoName.text = '';
    textTodoDesc.text = '';
  }

  void handleCancel() {
    _panelC.close();
  }

  void handleDeleteSet(id) {
    c.deleteTodo(id);
    deleteData();
    setState(() {});
  }

  void handleFieldValidation() {}

  @override
  Widget build(BuildContext context) {
    // Size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    // Custom Widget
    Widget _panel(controller) {
      return Container(
        decoration: BoxDecoration(
          color: Color(0xff363636),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        width: double.infinity,
        child: Column(
          children: [
            CustomInputText(
              onPressed: () {
                handleAdd();
              },
              expandField: false,
              title: 'Note',
              controller: textTodoName,
            ),
            CustomInputText(
              onPressed: () {
                handleAdd();
              },
              expandField: true,
              title: 'Description',
              controller: textTodoDesc,
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomButton(
                    height: 48,
                    width: 154,
                    title: 'Cancel',
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    buttonColor: Colors.transparent,
                    borderColor: Colors.red,
                    onPressed: () {
                      handleCancel();
                    },
                  ),
                  CustomButton(
                    height: 48,
                    width: 154,
                    title: 'Add',
                    margin: EdgeInsets.fromLTRB(0, 12, 0, 0),
                    buttonColor: Color(0xff8687E7),
                    onPressed: () {
                      handleAdd();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return WillPopScope(
      onWillPop: () async {
        handlePopPanel();
        return this.exit;
      },
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Color(0xff121212),
          title: Text(
            'NOTE',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: SlidingUpPanel(
            controller: _panelC,
            maxHeight: height * 0.5,
            minHeight: 1,
            onPanelClosed: () {
              clearTextField();
            },
            color: Colors.transparent,
            panelBuilder: (controller) => _panel(controller),
            body: ListView(
              children: [
                for (var i = 0; i < c.noteList.length; i++)
                  TodoTile(
                    index: i + 1,
                    item: c.noteList[i],
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TodoDescription(
                            item: c.noteList[i],
                            c: this.c,
                          ),
                        ),
                      );
                    },
                    deleteItem: (id) {
                      handleDeleteSet(id);
                    },
                  ),
                CustomButton(
                  width: width,
                  title: 'Add Note',
                  titleColor: Colors.white,
                  margin: EdgeInsets.fromLTRB(24, 32, 24, 0),
                  buttonColor: Colors.transparent,
                  onPressed: () {
                    _panelC.open();
                  },
                ),
              ],
            )),
      ),
    );
  }
}
