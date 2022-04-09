import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.title,
    this.margin,
    this.buttonColor,
    this.borderColor,
    this.titleColor,
    this.isIcon = false,
    this.icon,
    required this.onPressed,
  }) : super(key: key);
  final double? height;
  final double? width;
  final String? title;
  final Color? titleColor;
  final EdgeInsets? margin;
  final Color? borderColor;
  final Color? buttonColor;
  final Function onPressed;
  final bool isIcon;
  final IconData? icon;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      height: widget.height ?? MediaQuery.of(context).size.height * 0.065,
      width: widget.width ?? double.infinity,
      decoration: BoxDecoration(
        color: widget.buttonColor ?? Color(0xff8687E7),
        border: Border.all(
          color: widget.borderColor ?? Color(0xff8687E7),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {
          widget.onPressed();
        },
        child: widget.isIcon
            ? Icon(
                widget.icon,
                color: Colors.white,
                size: 30,
              )
            : Text(
                widget.title ?? '',
                style: TextStyle(
                  fontSize: 16,
                  color: widget.titleColor ?? Colors.white,
                ),
              ),
      ),
    );
  }
}
