import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:list_todo/pages/home.dart';
import 'package:list_todo/widgets/custom_button.dart';
import 'package:page_transition/page_transition.dart';

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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          // Index Dot
          _buildPageIndexIndicator(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Color(0xff121212),
      elevation: 0,
      automaticallyImplyLeading: false,
      title: TextButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: AppHome(),
            ),
            (route) => false,
          );
        },
        child: Text(
          'SKIP',
          style: TextStyle(
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
        margin: EdgeInsets.fromLTRB(0, 24.h, 24.h, 24.h),
        child: Row(
          children: [
            CustomButton(
              width: 90.w,
              onPressed: () {
                _pageBoardController.previousPage(
                  duration: Duration(microseconds: 500),
                  curve: Curves.linear,
                );
              },
              title: 'BACK',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16.sp,
                color: Colors.white.withOpacity(0.4),
              ),
              buttonColor: Colors.transparent,
              borderColor: Colors.transparent,
            ),
            Spacer(),
            CustomButton(
              width: currentPage == pages.length - 1 ? 140.sp : 90.sp,
              onPressed: () {
                _pageBoardController.nextPage(
                  duration: Duration(microseconds: 500),
                  curve: Curves.linear,
                );
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
      top: 140.sp,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var i = 0; i < pages.length; i++)
            AnimatedContainer(
              duration: Duration(milliseconds: 200),
              width: currentPage == i ? 20.0.sp : 8.0.sp,
              height: 4.0.sp,
              margin: EdgeInsets.fromLTRB(4.sp, 0, 4.sp, 0),
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
                width: 270.sp,
                height: 300.sp,
              ),
            ),
            Spacer(),
            Container(
              margin: EdgeInsets.fromLTRB(24.sp, 0, 24.sp, 0),
              child: Text(
                widget.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.87),
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(24.sp, 38.sp, 24.sp, 40.sp),
              child: Text(
                widget.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(
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
