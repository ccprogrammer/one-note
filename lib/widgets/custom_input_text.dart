import 'package:flutter/material.dart';

class CustomInputText extends StatefulWidget {
  const CustomInputText({
    Key? key,
    required this.onPressed,
    required this.title,
    this.controller,
    this.expandField = false,
  }) : super(key: key);
  final Function onPressed;
  final String title;
  final dynamic controller;
  final bool expandField;

  @override
  State<CustomInputText> createState() => _CustomInputTextState();
}

class _CustomInputTextState extends State<CustomInputText> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(24, 24, 24, 0),
          child: Text(
            widget.title,
            style: widget.expandField
                ? TextStyle(
                    color: Color(0xffAFAFAF),
                    fontSize: 18,
                  )
                : TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
          ),
        ),
        widget.expandField
            ? Container(
                margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                height: height * 0.16,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white60,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: widget.controller,
                  expands: true,
                  maxLines: null,
                  onEditingComplete: () {
                    widget.onPressed();
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              )
            : Container(
                margin: EdgeInsets.fromLTRB(24, 12, 24, 0),
                padding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white60,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: TextField(
                  controller: widget.controller,
                  onEditingComplete: () {
                    widget.onPressed();
                  },
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              ),
      ],
    );
  }
}
