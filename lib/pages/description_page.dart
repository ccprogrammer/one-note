import 'dart:math';

import 'package:flutter/material.dart';
import 'package:list_todo/widgets/custom_button.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage({Key? key, required this.item, required this.onSaveData})
      : super(key: key);

  final dynamic item;

  // Controller
  final Function onSaveData;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool exit = false;
  bool save = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    final textNote = TextEditingController(text: widget.item['note']);
    final textDesc = TextEditingController(text: widget.item['description']);
    // Memilih posisi kursor saat textfield di klik, kasus ini kursor akan berada di akhir text
    textNote.selection =
        TextSelection.fromPosition(TextPosition(offset: textNote.text.length));
    textDesc.selection =
        TextSelection.fromPosition(TextPosition(offset: textDesc.text.length));

    void onFocusChange() {
      save = !save;
      setState(() {});
    }

    void removeFocus() {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    void saveNote() {
      widget.item['note'] = textNote.text;
      widget.item['description'] = textDesc.text;

      widget.onSaveData();
    }

    void handleSaveIcon() {
      saveNote();
      removeFocus();
    }

    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff121212),
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
                child: Image.asset(
                  'assets/icon_close.png',
                  width: 32,
                ),
              ),
            ),
            GestureDetector(
              onTap: (){
                handleSaveIcon();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
                child: save
                    ? Icon(
                        Icons.check,
                      )
                    : SizedBox(width: 24),
              ),
            )
          ],
        ),
      ),
      body: GestureDetector(
        onTap: () {
          removeFocus();
        },
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(24, 0, 24, 0),
              child: Focus(
                onFocusChange: (focus) {
                  onFocusChange();
                },
                child: TextField(
                  controller: textNote,
                  textAlignVertical: TextAlignVertical.center,
                  // expands: false,
                  maxLines: null,
                  onChanged: (value) {
                    saveNote();
                  },
                  onEditingComplete: () {
                    saveNote();
                    removeFocus();
                  },
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 26,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.fromLTRB(24, 6, 24, 18),
              child: Focus(
                onFocusChange: (focus) {
                  onFocusChange();
                },
                child: TextField(
                  controller: textDesc,
                  maxLines: null,
                  onChanged: (value) {
                    saveNote();
                  },
                  onEditingComplete: () {
                    saveNote();
                    removeFocus();
                  },
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
