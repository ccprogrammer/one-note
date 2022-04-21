import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:list_todo/widgets/custom_icon.dart';
import 'package:list_todo/widgets/custom_input_textfield.dart';

class AddDescriptionPage extends StatefulWidget {
  AddDescriptionPage({Key? key, required this.onSaveData}) : super(key: key);

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

  void onFocusChange() {
    save = !save;
    setState(() {});
  }

  void removeFocus() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void handleSave() {
    if (textNote.text == '' && textDesc.text == '') {
    } else {
      widget.onSaveData(textNote.text, textDesc.text);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  removeFocus();
                  handleSave();
                  // it's a weird bug, the add button will stay in center for a few milliseconds then move to bottom if Future.delayed not applied wait... it's not a bug it's a new hidden feature !!!! AMAZING !!!
                  Future.delayed(Duration(milliseconds: 100), () {
                    return Navigator.pop(context);
                  });
                },
                icon: Icons.close,
                margin: EdgeInsets.fromLTRB(24.w, 0, 0, 0),
              ),
              save
                  ? CustomIcon(
                      onTap: () {
                        removeFocus();
                      },
                      icon: Icons.check,
                      margin: EdgeInsets.fromLTRB(0, 0, 24.w, 0),
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
              // Title TextField
              Container(
                margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
                child: Focus(
                  onFocusChange: (focus) {
                    onFocusChange();
                  },
                  child: CustomInputTextField(
                    controller: textNote,
                    hintText: 'Title',
                    color: Colors.white54,
                    fontSize: 26.sp,
                  ),
                ),
              ),

              // Description TextField
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.fromLTRB(24.w, 6.h, 24.w, 18.h),
                child: Focus(
                  onFocusChange: (focus) {
                    onFocusChange();
                  },
                  child: CustomInputTextField(
                    controller: textDesc,
                    hintText: 'Description',
                    color: Colors.white38,
                    fontSize: 16.sp,
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
