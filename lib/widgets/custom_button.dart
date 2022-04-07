import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.height,
    this.width,
    this.title,
    this.margin,
    this.buttonColor,
    this.borderColor,
    this.titleColor,
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      height: height ?? MediaQuery.of(context).size.height * 0.065,
      width: width ?? double.infinity,
      decoration: BoxDecoration(
        color: buttonColor ?? Color(0xff8687E7),
        border: Border.all(
          color: borderColor ?? Color(0xff8687E7),
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {
          onPressed();
        },
        child: Text(
          title ?? '',
          style: TextStyle(
            fontSize: 16,
            color: titleColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
