import 'dart:math';

import 'package:flutter/material.dart';
import 'package:list_todo/widgets/custom_button.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class TodoDescription extends StatefulWidget {
  TodoDescription({Key? key, required this.item, this.c}) : super(key: key);

  final dynamic item;

  // Controller
  final dynamic c;

  @override
  State<TodoDescription> createState() => _TodoDescriptionState();
}

class _TodoDescriptionState extends State<TodoDescription> {
  final _panelC = PanelController();
  final textAddController = TextEditingController();

  bool exit = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xff121212),
        title: Text(
          widget.item['todo'],
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          // Combo Section Title
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.fromLTRB(24, 18, 24, 18),
            child: Text(
              widget.item['description'],
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
