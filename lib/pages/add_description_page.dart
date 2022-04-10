import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:list_todo/widgets/custom_button.dart';
import 'package:list_todo/widgets/custom_icon.dart';

class AddDescriptionPage extends StatefulWidget {
  AddDescriptionPage(
      {Key? key, required this.onSaveData})
      : super(key: key);

  // Controller
  final Function onSaveData;

  @override
  State<AddDescriptionPage> createState() => _AddDescriptionPageState();
}

class _AddDescriptionPageState extends State<AddDescriptionPage> {
  bool exit = false;
  bool save = false;

  final textNote = TextEditingController();
  final textDesc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    void onFocusChange() {
      save = !save;
      setState(() {});
    }

    void removeFocus() {
      FocusManager.instance.primaryFocus?.unfocus();
    }

    void handleSave() {
      if (textNote.text != '' && textDesc.text != '') {
        widget.onSaveData(textNote.text, textDesc.text);
      }
    }

    return WillPopScope(
      onWillPop: () async {
        handleSave();
        return true;
      },
      child: Scaffold(
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
                  handleSave();
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
                      // saveNote();
                    },
                    onEditingComplete: () {
                      // saveNote();
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
                      // saveNote();
                    },
                    onEditingComplete: () {
                      // saveNote();
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
      ),
    );
  }
}
