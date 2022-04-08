import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:list_todo/pages/description_page.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    Key? key,
    required this.item,
    required this.deleteItem,
    required this.index,
    required this.onSaveData,
  }) : super(key: key);
  final dynamic item;
  final int index;

  final Function deleteItem;
  final Function onSaveData;

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      height: height * 0.08,
      margin: EdgeInsets.fromLTRB(24, 0, 24, 0),

      // OpenContainer animasi dari package animations
      child: OpenContainer(
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(0.0),
          ),
        ),
        openColor: Color(0xff4C4C4C),
        closedColor: Color(0xff4C4C4C),
        transitionDuration: Duration(milliseconds: 600),
        closedBuilder: (context, action) {
          return Padding(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
            child: Row(
              children: [
                // Note
                Expanded(
                  child: Text(
                    widget.item['note'] ?? 'Empty Error',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Divider
                SizedBox(width: 16),
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
            onSaveData: () {
              widget.onSaveData();
            },
          );
        },
      ),
    );
  }
}
