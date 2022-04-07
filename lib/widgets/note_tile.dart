import 'package:flutter/material.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    Key? key,
    required this.item,
    required this.deleteItem,
    required this.onPressed,
    required this.index,
  }) : super(key: key);
  final dynamic item;
  final int index;
  final Function onPressed;
  final Function deleteItem;

  @override
  State<NoteTile> createState() => _NoteTileState();
}

class _NoteTileState extends State<NoteTile> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.fromLTRB(24, 16, 24, 0),
      height: height * 0.07,
      decoration: BoxDecoration(
        color: Color(0xff4C4C4C),
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextButton(
        onPressed: () {
          widget.onPressed();
        },
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: Row(
              children: [
                // Note
                Expanded(
                  child: Text(
                    widget.item['note'] ?? 'Empty Error',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),

                // Divider
                SizedBox(width: 16),
                Container(
                  height: double.infinity,
                  width: 2,
                  color: Color(0xff979797),
                ),

                // Icon Delete
                SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    widget.deleteItem(widget.item['id']);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(4, 4, 4, 4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.red,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
