import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:list_todo/helper/shared_preferences.dart';
import 'package:list_todo/pages/home.dart';
import 'package:list_todo/widgets/constants.dart';
import 'package:list_todo/widgets/custom_button.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  State<IntroductionPage> createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  PageController _pageBoardController = PageController(initialPage: 0);
  int currentPage = 0;

  List pages = [
    IntroTab(
      image: 'assets/image_intro1.png',
      title: 'Manage your tasks',
      subTitle:
          'You can easily manage all of your daily tasks in DoMe for free',
    ),
    IntroTab(
      image: 'assets/image_intro2.png',
      title: 'Create daily routine',
      subTitle:
          'In Uptodo  you can create your personalized routine to stay productive',
    ),
    IntroTab(
      image: 'assets/image_intro3.png',
      title: 'Orgonaize your tasks',
      subTitle:
          'You can organize your daily tasks by adding your tasks into separate categories',
    ),
    RegisterName(),
  ];

  void handleVisit() {
    prefs().isVisited(
      moreFunction: () {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: AppHome(),
          ),
          (route) => false,
        );
      },
    );
  }

  void nextPage() {
    _pageBoardController.nextPage(
      duration: Duration(microseconds: 500),
      curve: Curves.linear,
    );
  }

  void previousPage() {
    _pageBoardController.previousPage(
      duration: Duration(microseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        previousPage();
        return false;
      },
      child: Scaffold(
        backgroundColor: Color(0xff121212),
        appBar: _buildAppBar(),
        bottomNavigationBar: _buildBottomAppBar(),
        body: Stack(
          children: [
            PageView(
              controller: _pageBoardController,
              onPageChanged: (value) {
                currentPage = value;
                setState(() {});
              },
              pageSnapping: true,
              children: [
                for (var i = 0; i < pages.length; i++) pages[i],
              ],
            ),
            currentPage == pages.length - 1
                ? Container()
                : _buildPageIndexIndicator(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: Color(0xff121212),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: currentPage == pages.length - 1
          ? IconButton(
              onPressed: () {
                previousPage();
              },
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              icon: Icon(
                Icons.chevron_left,
              ),
            )
          : TextButton(
              onPressed: () {
                _pageBoardController.jumpToPage(pages.length - 1);
              },
              child: Text(
                'SKIP',
                style: TextStyle(
                  fontFamily: Constants.lato,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp,
                  color: Colors.white.withOpacity(0.4),
                ),
              ),
            ),
    );
  }

  Widget _buildBottomAppBar() {
    return BottomAppBar(
      color: Color(0xff121212),
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 24.h, 24.w, 24.h),
        child: Row(
          children: [
            CustomButton(
              width: 90.w,
              onPressed: () {
                previousPage();
              },
              title: 'BACK',
              style: TextStyle(
                fontFamily: Constants.lato,
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.4),
              ),
              buttonColor: Colors.transparent,
              borderColor: Colors.transparent,
            ),
            Spacer(),
            CustomButton(
              width: currentPage == pages.length - 1 ? 140.w : 90.w,
              onPressed: () {
                currentPage == pages.length - 1 ? handleVisit() : nextPage();
              },
              title: currentPage == pages.length - 1 ? 'GET STARTED' : 'NEXT',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndexIndicator() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      top: 140.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < pages.length - 1; i++)
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: currentPage == i ? 20.0.w : 8.0.w,
              height: 4.0.h,
              margin: EdgeInsets.fromLTRB(4.w, 0, 4.w, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: currentPage == i
                    ? Colors.white
                    : Colors.white.withOpacity(0.7),
              ),
            ),
        ],
      ),
    );
  }
}

class IntroTab extends StatefulWidget {
  const IntroTab({
    Key? key,
    this.title = 'Title',
    this.subTitle = 'Subtitle',
    this.image = 'assets/image_intro1.png',
  }) : super(key: key);
  final String title;
  final String subTitle;
  final String image;

  @override
  State<IntroTab> createState() => _IntroTabState();
}

class _IntroTabState extends State<IntroTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Center(
        child: Column(
          children: [
            Container(
              child: Image.asset(
                widget.image,
                width: 270.w,
                height: 300.h,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(24.w, 0, 24.w, 0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Constants.lato,
                  color: Colors.white.withOpacity(0.87),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(24.w, 38.h, 24.w, 40.h),
              child: Text(
                widget.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Constants.lato,
                  color: Colors.white.withOpacity(0.87),
                  fontSize: 16.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RegisterName extends StatefulWidget {
  const RegisterName({Key? key}) : super(key: key);

  @override
  State<RegisterName> createState() => _RegisterNameState();
}

class _RegisterNameState extends State<RegisterName> {
  var nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(24.w, 58.h, 24.w, 0),
              child: Text(
                'Welcome to OneNote',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: Constants.lato,
                  color: Colors.white.withOpacity(0.87),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(24.w, 26.h, 24.w, 0),
              child: TextField(
                controller: nameController,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  prefs().registerName(username: nameController.text);
                },
                style: TextStyle(
                  fontFamily: Constants.lato,
                  color: Colors.white.withOpacity(0.87),
                  fontSize: 22.sp,
                ),
                decoration: InputDecoration(
                  hintText: 'Tap to add your name',
                  hintStyle: TextStyle(
                    fontFamily: Constants.lato,
                    color: Colors.white.withOpacity(0.67),
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
