import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/src/size_extension.dart';
import 'package:one_note/pages/home.dart';
import 'package:one_note/pages/intro_page/introduction_page.dart';
import 'package:one_note/widgets/constants.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future intro() async {
    final SharedPreferences prefs = await _prefs;
    Timer(Duration(seconds: 2), () {
      if (prefs.containsKey(Constants.isVisited)) {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: AppHome(),
          ),
          (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: IntroductionPage(),
          ),
          (route) => false,
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    intro();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Center(
        child: Image.asset(
          'assets/logo_start.png',
          width: 113.w,
        ),
      ),
    );
  }
}
