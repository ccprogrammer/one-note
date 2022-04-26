import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:list_todo/widgets/constants.dart';

class CustomInputTextField extends StatefulWidget {
  CustomInputTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.fontSize,
    this.color,
  }) : super(key: key);

  final String hintText;
  final dynamic controller;
  final double? fontSize;
  final Color? color;

  @override
  State<CustomInputTextField> createState() => _CustomInputTextFieldState();
}

class _CustomInputTextFieldState extends State<CustomInputTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      textAlignVertical: TextAlignVertical.center,
      maxLines: null,
      style: TextStyle(
        fontFamily: Constants.lato,
        color: Colors.white.withOpacity(0.85),
        fontSize: widget.fontSize ?? 26.sp,
      ),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          fontFamily: Constants.lato,
          color: widget.color ?? Colors.white54,
        ),
        border: InputBorder.none,
      ),
    );
  }
}
