import 'package:flutter/material.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
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
  State<TodoTile> createState() => _SetsTileState();
}

class _SetsTileState extends State<TodoTile> {
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
                Container(
                  padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${widget.index}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                // Title
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    widget.item['todo'] ?? 'Empty Error',
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
