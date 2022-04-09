import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_todo/widgets/custom_button.dart';
import 'package:list_todo/widgets/custom_icon.dart';

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
      String dateTime = DateFormat.MMMMd().format(DateTime.now());
      String hourTime = DateFormat.jm().format(DateTime.now());
      widget.item['note'] = textNote.text;
      widget.item['description'] = textDesc.text;
      widget.item['date'] = dateTime;
      widget.item['hour'] = hourTime;

      widget.onSaveData();
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
            CustomIcon(
              onTap: () {
                Navigator.pop(context);
              },
              icon: Icons.close,
              margin: EdgeInsets.fromLTRB(24, 0, 0, 0),
            ),
            save
                ? CustomIcon(
                    onTap: () {
                      removeFocus();
                    },
                    icon: Icons.check,
                    margin: EdgeInsets.fromLTRB(0, 0, 24, 0),
                  )
                : Container(),
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
                    hintText: 'Title',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
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
                    hintText: 'Description',
                    hintStyle: TextStyle(
                      color: Colors.white54,
                    ),
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
