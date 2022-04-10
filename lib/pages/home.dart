import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:list_todo/controllers/note_controller.dart';
import 'package:list_todo/pages/add_description_page.dart';
import 'package:list_todo/pages/description_page.dart';
import 'package:list_todo/widgets/custom_button.dart';
import 'package:list_todo/widgets/custom_input_text.dart';
import 'package:list_todo/widgets/note_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  // jika panelIsOpen/true ketika klik kembali pada back button hp akan menjalankan function _panel.close()/tutup panel jika false akan kembail ke halaman sebelumnya
  // bool exit = false;

  // Controller
  final c = NoteControler();
  final _panelC = PanelController();
  final textNote = TextEditingController();
  final textDesc = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // Shared Preferences Section
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future saveData() async {
    final SharedPreferences prefs = await _prefs;
    List notes = c.noteList;
    prefs.setString('notes', jsonEncode(notes));
    setState(() {});
  }

  Future loadData() async {
    final SharedPreferences prefs = await _prefs;
    if (prefs.containsKey('notes')) {
      final noteList = prefs.getString('notes');
      final notes = jsonDecode(noteList!);
      for (var i = 0; i < notes.length; i++) {
        c.noteList.add(notes[i]);
        setState(() {});
      }
    }
  }

  Future deleteData() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
    saveData();
  }

// Handler

  void handleAdd(title, desc) {
    c.addNote(
      Random().nextInt(100),
      title,
      desc,
    );
  }

  void clearTextField() {
    textNote.text = '';
    textDesc.text = '';
  }

  void handleCancel() {
    _panelC.close();
  }

  void handleDeleteSet(id) {
    c.deleteNote(id);
    deleteData();
    setState(() {});
  }

  void removeEmptyList() {
    for (var i = 0; i < c.noteList.length; i++) {
      if (c.noteList[i]['note'] == '' && c.noteList[i]['description'] == '') {
        c.noteList.removeWhere(
            (element) => element['note'] == '' && element['description'] == '');
      }
      setState(() {});
      saveData();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Size
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async {
        // handlePopPanel();
        return true;
      },
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          toolbarHeight: 65,
          backgroundColor: Color(0xff121212),
          title: Text(
            'NOTE',
            style: TextStyle(
              fontSize: 22,
            ),
          ),
        ),
        body: Stack(
          children: [
            ListView(
              children: [
                Column(
                  children: [
                    for (var i = 0; i < c.noteList.length; i++)
                      _buildNoteList(i),
                    SizedBox(height: height * 0.13),
                  ],
                ),
              ],
            ),

            Positioned(
              bottom: 24,
              right: 24,
              child: OpenContainer(
                transitionDuration: Duration(milliseconds: 650),
                openColor: Color(0xff8687E7),
                closedColor: Color(0xff8687E7),
                tappable: false,
                closedBuilder: (context, action) {
                  return CustomButton(
                    width: width * 0.13,
                    title: 'Add',
                    titleColor: Colors.white,
                    isIcon: true,
                    icon: Icons.add,
                    onPressed: () {
                      action();
                    },
                  );
                },
                openBuilder: (context, action) {
                  return AddDescriptionPage(
                    onSaveData: (title, desc) {
                      handleAdd(title, desc);
                      saveData();
                    },
                  );
                },
              ),
            )

            // SlidingUpPanel(
            //   controller: _panelC,
            //   maxHeight: height * 0.5,
            //   minHeight: 1,
            //   onPanelClosed: () {
            //     clearTextField();
            //   },
            //   color: Colors.transparent,
            //   panel: _buildPanel(context),
            // ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoteList(i) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6, 0, 0),
      // Slidable agar list bisa di swipe dan ini dari package flutter_slidable
      child: Slidable(
        key: ValueKey(
          c.noteList[i]['id'],
        ),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              handleDeleteSet(
                c.noteList[i]['id'],
              );
            },
          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                handleDeleteSet(
                  c.noteList[i]['id'],
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: NoteTile(
          index: i + 1,
          item: c.noteList[i],
          deleteItem: (id) {
            handleDeleteSet(id);
          },
          onSaveData: () {
            saveData();
          },
        ),
      ),
    );
  }
/*
  Widget _buildPanel(context) {
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
          Expanded(
            child: Column(
              // controller: controller,
              children: [
                CustomInputText(
                  onPressed: () {
                    handleAdd();
                  },
                  expandField: false,
                  title: 'Title',
                  controller: textNote,
                ),
                CustomInputText(
                  onPressed: () {
                    handleAdd();
                  },
                  expandField: true,
                  title: 'Description',
                  controller: textDesc,
                ),
              ],
            ),
          ),
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
*/
// function untuk kalo pake panel
  // void handleAdd() {
  //   c.addNote(
  //     Random().nextInt(100),
  //     textNote.text,
  //     textDesc.text,
  //   );
  //   saveData();
  //   _panelC.close();
  //   setState(() {});

  //   // dismiss keyboard on complete
  //   FocusScopeNode currentFocus = FocusScope.of(context);
  //   if (!currentFocus.hasPrimaryFocus) {
  //     currentFocus.unfocus();
  //   }
  // }
  // void handlePopPanel() {
  //   if (_panelC.isPanelOpen) {
  //     _panelC.close();
  //   } else {
  //     // ketika panel terbuka panel akan di tutup, ketika panel tertutup this.exit akan menjadi true dan secara otomatis akan kembail ke halaman sebelumnya
  //     this.exit = true;
  //   }
  // }
}
