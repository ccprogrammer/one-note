import 'package:flutter/material.dart';

class CustomIcon extends StatefulWidget {
  const CustomIcon({
    Key? key,
    required this.onTap,
    required this.icon,
    required this.margin, this.color,
  }) : super(key: key);
  final Function onTap;
  final IconData icon;
  final EdgeInsets margin;
  final Color? color;

  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
      },
      child: Container(
        margin: widget.margin,
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: widget.color ?? Color(0xff1D1D1D),
        ),
        child: Icon(
          widget.icon,
        ),
      ),
    );
  }
}
