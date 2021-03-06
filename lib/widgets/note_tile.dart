import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:one_note/pages/description_page.dart';
import 'package:intl/intl.dart';
import 'package:one_note/widgets/constants.dart';

class NoteTile extends StatefulWidget {
  const NoteTile({
    Key? key,
    required this.item,
    required this.deleteItem,
    required this.index,
    required this.onSaveData,
    this.c,
    required this.changeIcon,
  }) : super(key: key);
  final dynamic item;
  final int index;

  final Function deleteItem;
  final Function onSaveData;
  final Function changeIcon;
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
      height: 120.h,
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
          return InkWell(
            onTap: () {
              action();
            },
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
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
                              fontFamily: Constants.lato,
                              fontSize: 16.sp,
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
                              fontFamily: Constants.lato,
                              fontSize: 12.sp,
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
                  SizedBox(width: 42.w),
                  Container(
                    width: 2.w,
                    color: Color(0xff979797),
                  ),

                  // Icon Delete
                  SizedBox(width: 16.w),
                  Container(
                    width: 55.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          '${widget.item['icon'] ?? 'assets/category/noteicon_add.png'}',
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          widget.changeIcon(widget.index);
                        },
                      ),
                    ),
                  ),
                ],
              ),
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
        style: TextStyle(
          color: Colors.white54,
          fontSize: 12.sp,
          fontFamily: Constants.lato,
        ),
      );
    } else {
      return Text(
        '${widget.item['date']}, ${widget.item['year']}',
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
        style: TextStyle(
          color: Colors.white54,
          fontSize: 12.sp,
          fontFamily: Constants.lato,
        ),
      );
    }
  }
}
