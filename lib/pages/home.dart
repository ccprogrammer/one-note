import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:list_todo/controllers/note_controller.dart';
import 'package:list_todo/helper/shared_preferences.dart';
import 'package:list_todo/pages/add_description_page.dart';
import 'package:list_todo/widgets/constants.dart';
import 'package:list_todo/widgets/custom_button.dart';
import 'package:list_todo/widgets/note_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  // Controller
  final c = NoteControler();
  final textNote = TextEditingController();
  final textDesc = TextEditingController();
  final textUsername = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadUsername();
    loadData();
  }

  // Shared Preferences Section
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void loadUsername() {
    prefs().loadUsername(
      username: (name) {
        textUsername.text = name;
      },
    ).then((_) {
      setState(() {});
    });
  }

  void saveData() {
    prefs().saveData(data: c.noteList);
  }

  void loadData() {
    prefs()
        .loadData(
      noteList: c.noteList,
    )
        .then((_) {
      setState(() {});
    });
  }

// Handler
  void handleAdd(title, desc) {
    c.addNote(
      Random().nextInt(100),
      title,
      desc,
    );
    saveData();
    setState(() {});
  }

  void handleEdit(i, title, desc) {
    c.editNote(i, title, desc);
    saveData();
    setState(() {});
  }

  void handleDelete(id) {
    c.deleteNote(id);
    saveData();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //     final SharedPreferences prefs = await _prefs;
      //     prefs.clear();
      //   },
      //   child: Icon(Icons.clear),
      // ),
      backgroundColor: Color(0xff121212),
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          _buildNoteList(),
          _buildBottomButton(),
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
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      toolbarHeight: 100.h,
      backgroundColor: Color(0xff121212),
      // backgroundColor: Colors.grey,
      titleSpacing: 24.w,
      title: Row(
        children: [
          Text(
            'Hello, ',
            style: TextStyle(
              fontSize: 22.sp,
            ),
          ),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: textUsername,
              onChanged: (value) {
                prefs().registerName(username: textUsername.text);
              },
              style: TextStyle(
                  fontSize: 22.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                hintText: 'What\'s your name?',
                hintStyle: TextStyle(
                  color: Color(0xffB2B2B2),
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
      actions: [
        CircleAvatar(
          radius: 30.0.r,
          child: SizedBox(
            width: 60.w,
            height: 60.h,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(50.r),
                onTap: () {},
              ),
            ),
          ),
          backgroundImage: NetworkImage(
            "https://images.unsplash.com/photo-1531427186611-ecfd6d936c79?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTR8fHBlb3BsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
          ),
          // backgroundImage: AssetImage(
          //   "assets/icon_no_profile.png",
          // ),
          backgroundColor: Colors.transparent,
        ),
        SizedBox(width: 24.w),
      ],
    );
  }

  Widget _buildNoteList() {
    if (c.noteList.length == 0) {
      return Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 75.h, 0, 0),
              width: 227.w,
              height: 227.w,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image_empty.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              child: Text(
                'What do you want to note?',
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10.h, 0, 0),
              child: Text(
                'Tap + to add your note',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return ListView(
        children: [
          Column(
            children: [
              for (var i = 0; i < c.noteList.length; i++) _buildNotes(i),
              SizedBox(height: 120.h),
            ],
          ),
        ],
      );
    }
  }

  Widget _buildNotes(i) {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 6.h, 0, 0),
      // Slidable agar list bisa di swipe dan ini dari package flutter_slidable
      child: Slidable(
        key: ValueKey(
          c.noteList[i]['id'],
        ),
        startActionPane: ActionPane(
          motion: StretchMotion(),
          dismissible: DismissiblePane(
            onDismissed: () {
              handleDelete(
                c.noteList[i]['id'],
              );
            },
          ),
          children: [
            SlidableAction(
              onPressed: (context) {
                handleDelete(
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
            handleDelete(id);
          },
          onSaveData: (title, desc) {
            handleEdit(i, title, desc);
          },
        ),
      ),
    );
  }

  Widget _buildBottomButton() {
    return Positioned(
      bottom: 36.h,
      right: 36.w,
      child: OpenContainer(
        transitionDuration: Duration(milliseconds: 650),
        openColor: Color(0xff8687E7),
        closedColor: Color(0xff8687E7),
        tappable: false,
        closedBuilder: (context, action) {
          return CustomButton(
            width: 50.w,
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
            },
          );
        },
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
