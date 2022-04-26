import 'dart:async';
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
import 'package:sliding_up_panel/sliding_up_panel.dart';

class AppHome extends StatefulWidget {
  AppHome({Key? key}) : super(key: key);

  @override
  State<AppHome> createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  // Controller
  final c = NoteControler();
  final _panelC = PanelController();
  final textNote = TextEditingController();
  final textDesc = TextEditingController();
  final textUsername = TextEditingController();

  List greetingList = [
    {'value': 'Hi, '},
    {'value': 'Hello, '},
    {'value': 'What\'s up, '},
  ];
  String greetings = 'Hi';

  List noteIcon = [
    {
      'value': 'assets/category/noteicon_playstation.png',
    },
    {
      'value': 'assets/category/noteicon_movie.png',
    },
    {
      'value': 'assets/category/noteicon_home.png',
    },
    {
      'value': 'assets/category/noteicon_health.png',
    },
    {
      'value': 'assets/category/noteicon_music.png',
    },
    {
      'value': 'assets/category/noteicon_social.png',
    },
    // {
    //   'value': 'assets/category/noteicon_university.png',
    // },
    {
      'value': 'assets/category/noteicon_sport.png',
    },
    {
      'value': 'assets/category/noteicon_work.png',
    },
    {
      'value': 'assets/category/noteicon_grocery.png',
    },
  ];
  int? noteIndex;

  double onPanelOpenHeight = 0.16;

  @override
  void initState() {
    super.initState();
    randomGreetings();
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

  void randomGreetings() {
    greetings = greetingList[Random().nextInt(greetingList.length)]['value'];
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

  void handleChangeIcon(value) {
    c.addNoteIcon(noteIndex, value);
    saveData();
    setState(() {});
  }

  void handlePanelOpenHeight(bool open) {
    open == true ? onPanelOpenHeight = 0.65 : onPanelOpenHeight = 0.16;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_panelC.isPanelOpen) {
          _panelC.close();
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        appBar: _buildAppBar(),
        body: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Stack(
            children: [
              _buildNoteList(),
              _buildBottomButton(),
              _buildSlidingUpPanel(),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      centerTitle: false,
      elevation: 0,
      toolbarHeight: 100.h,
      backgroundColor: Color(0xff121212),
      titleSpacing: 24.w,
      title: Row(
        children: [
          Text(
            greetings,
            style: TextStyle(
              fontFamily: Constants.lato,
              fontSize: 22.sp,
            ),
          ),
          Expanded(
            child: TextField(
              textAlignVertical: TextAlignVertical.bottom,
              controller: textUsername,
              maxLength: 16,
              onChanged: (value) {
                prefs().registerName(username: textUsername.text);
              },
              style: TextStyle(
                fontSize: 22.sp,
                fontFamily: Constants.lato,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'What\'s your name?',
                hintStyle: TextStyle(
                  color: Color(0xffB2B2B2),
                ),
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ],
      ),
      actions: [],
    );
  }

  Widget _buildNoteList() {
    if (c.noteList.length > 0) {
      return ListView(
        children: [
          Column(
            children: [
              for (var i = 0; i < c.noteList.length; i++) _buildNotes(i),
              SizedBox(
                  height:
                      MediaQuery.of(context).size.height * onPanelOpenHeight),
            ],
          ),
        ],
      );
    } else {
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
          changeIcon: (_) {
            noteIndex = i;
            _panelC.open();
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

  Widget _buildPanel({context, controller, changeNoteIcon}) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(0.w, 10.h, 0.w, 0.w),
                child: Text(
                  'Choose Category',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5.w, 10.h, 5.w, 10.h),
                child: Divider(
                  color: Color(0xff979797),
                  thickness: 2.h,
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(30.w, 0, 30.w, 0),
                  child: ListView(
                    controller: controller,
                    children: [
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 35.w,
                          mainAxisSpacing: 35.h,
                          // mainAxisExtent: 80,
                        ),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: noteIcon.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                  noteIcon[index]['value'],
                                ),
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  changeNoteIcon(noteIcon[index]['value']);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 24.h,
          left: 24.w,
          right: 24.w,
          child: CustomButton(
            title: 'Close',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
            onPressed: () {
              _panelC.close();
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSlidingUpPanel() {
    return SlidingUpPanel(
      controller: _panelC,
      minHeight: 0,
      onPanelOpened: () {
        handlePanelOpenHeight(true);
      },
      onPanelClosed: () {
        handlePanelOpenHeight(false);
      },
      panelSnapping: false,
      color: Color(0xff363636),
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      panelBuilder: (controller) {
        return _buildPanel(
          context: context,
          controller: controller,
          changeNoteIcon: (value) {
            handleChangeIcon(value);
          },
        );
      },
    );
  }
}
