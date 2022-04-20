import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:list_todo/widgets/custom_icon.dart';
import 'package:list_todo/widgets/custom_input_textfield.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage({
    Key? key,
    required this.item,
    required this.onSaveData,
  }) : super(key: key);

  final dynamic item;

  // Controller
  final Function onSaveData;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  bool exit = false;
  bool save = false;

  final textNote = TextEditingController();
  final textDesc = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textNote.text = widget.item['note'];
    textDesc.text = widget.item['description'];
  }

  @override
  Widget build(BuildContext context) {
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

    return WillPopScope(
      onWillPop: () async {
        widget.onSaveData(textNote.text, textDesc.text);
        Navigator.pop(context);

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
                  widget.onSaveData(textNote.text, textDesc.text);
                  Navigator.pop(context);
                },
                icon: Icons.close,
                margin: EdgeInsets.fromLTRB(24.w, 0, 0, 0),
              ),
              save
                  ? CustomIcon(
                      onTap: () {
                        widget.onSaveData(textNote.text, textDesc.text);
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
