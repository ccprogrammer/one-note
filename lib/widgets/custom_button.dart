import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:one_note/widgets/constants.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.title,
    this.margin,
    this.padding,
    this.buttonColor,
    this.borderColor,
    this.titleColor,
    this.isIcon = false,
    this.icon,
    required this.onPressed,
    this.style,
  }) : super(key: key);
  final double? height;
  final double? width;
  final String? title;
  final Color? titleColor;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? borderColor;
  final Color? buttonColor;
  final Function onPressed;
  final bool isIcon;
  final IconData? icon;
  final TextStyle? style;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      padding: widget.padding,
      height: widget.height ?? 50.h,
      width: widget.width ?? double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: widget.buttonColor ?? Color(0xff8687E7),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.r),
          ),
          side: BorderSide(
            color: widget.borderColor ?? Color(0xff8687E7),
            width: 1.w,
          ),
        ),
        onPressed: () {
          widget.onPressed();
        },
        child: widget.isIcon
            ? Icon(
                widget.icon,
                color: Colors.white,
                size: 30.w,
              )
            : Text(
                widget.title ?? 'onPressed',
                style: widget.style ??
                    TextStyle(
                      fontFamily: Constants.lato,
                      fontSize: 16.sp,
                      color: widget.titleColor ?? Colors.white,
                    ),
              ),
      ),
    );
  }
}
