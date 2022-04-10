import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:list_todo/pages/description_page.dart';
import 'package:intl/intl.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    Key? key,
    required this.item,
    required this.deleteItem,
    required this.index,
    required this.onSaveData,
    this.c,
  }) : super(key: key);
  final dynamic item;
  final int index;

  final Function deleteItem;
  final Function onSaveData;
  final dynamic c;

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.125,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      // OpenContainer animasi dari package animations
      child: OpenContainer(
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        closedColor: Color(0xff4C4C4C).withOpacity(0.15),
        openColor: Color(0xff4C4C4C).withOpacity(0.6),
        transitionDuration: Duration(milliseconds: 650),
        closedBuilder: (context, action) {
          return Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              children: [
                // Note
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Note Title
                      Container(
                        child: Text(
                          widget.item['note'] ?? 'Empty Note',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),

                      // Note Description
                      Container(
                        child: Text(
                          widget.item['description'] ?? 'Empty Description',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white70,
                          ),
                        ),
                      ),

                      // Note Date
                      Container(
                        child: _buildDateTiem(),
                      ),
                    ],
                  ),
                ),
                // Divider
                SizedBox(width: 42),
                Container(
                  width: 2,
                  color: Color(0xff979797),
                ),

                // Icon Delete
                SizedBox(width: 16),
                Container(
                  padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.navigate_next,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        openBuilder: (context, action) {
          return DescriptionPage(
            item: widget.item,
            onSaveData: (title, desc) {
              widget.onSaveData(title, desc);
            },
          );
        },
      ),
    );
  }

  Widget _buildDateTiem() {
    // Untuk memunculkan date berformat Bulan Tanggal / Jam saja tergantung last modified kapan kalo sudah beda hari akan muncul jam saja
    String dateTime = DateFormat.MMMMd().format(DateTime.now());
    if (widget.item['date'] == dateTime) {
      return Text(
        widget.item['hour'] ?? 'Empty Hour',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Colors.white54, fontSize: 12),
      );
    } else {
      return Text(
        widget.item['date'] ?? 'Empty Date',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(color: Colors.white54, fontSize: 12),
      );
    }
  }
}
