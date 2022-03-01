import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';

class CustomSplashScreen extends StatefulWidget {
  final childScreen;
  const CustomSplashScreen({Key? key, @required this.childScreen})
      : super(key: key);

  @override
  _CustomSplashScreenState createState() => _CustomSplashScreenState();
}

class _CustomSplashScreenState extends State<CustomSplashScreen>
    with TickerProviderStateMixin {
  double _fontSize = 2;
  double _containerSize = 1.5;
  double _textOpacity = 0.0;
  double _containerOpacity = 0.0;

  late AnimationController _controller;
  late Animation<double> animation;

  bool _isAuth = false;

  @override
  void initState() {
    super.initState();

    _isAuth = FirebaseAuth.instance.currentUser != null;

    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

    animation = Tween<double>(begin: 40, end: 20).animate(CurvedAnimation(
        parent: _controller, curve: Curves.fastLinearToSlowEaseIn))
      ..addListener(() {
        setState(() {
          _textOpacity = 1.0;
        });
      });

    _controller.forward();

    Timer(Duration(seconds: 2), () {
      setState(() {
        _fontSize = 1.06;
      });
    });

    Timer(Duration(seconds: 2), () {
      setState(() {
        _containerSize = 2;
        _containerOpacity = 1;
      });
    });

    Timer(Duration(seconds: 5), () {
      setState(() {
        Navigator.of(context)
            .pushReplacement(SplashScreenTransition(widget.childScreen));
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kYellowSS,
      body: Center(
        child: Container(
            child: Image.asset(
          'assets/images/Final-2K-30-fps-1-1.gif',
          fit: BoxFit.contain,
        )),
      ),
      // backgroundColor: kYellowL,
      // body: Stack(
      //   children: [
      //     Column(
      //       children: [
      //         AnimatedContainer(
      //           duration: Duration(milliseconds: 2000),
      //           curve: Curves.fastLinearToSlowEaseIn,
      //           height: _height / _fontSize,
      //         ),
      //         AnimatedOpacity(
      //           opacity: _textOpacity,
      //           duration: Duration(milliseconds: 1000),
      //           child: Text(
      //             'Streato',
      //             style: TextStyle(
      //               color: Colors.white,
      //               fontWeight: FontWeight.bold,
      //               fontSize: animation.value,
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      //     Center(
      //       child: AnimatedOpacity(
      //         opacity: _containerOpacity,
      //         duration: Duration(milliseconds: 2000),
      //         curve: Curves.fastLinearToSlowEaseIn,
      //         child: AnimatedContainer(
      //           duration: Duration(milliseconds: 2000),
      //           curve: Curves.fastLinearToSlowEaseIn,
      //           height: _width / _containerSize,
      //           width: _width / _containerSize,
      //           alignment: Alignment.center,
      //           decoration: BoxDecoration(
      //             color: Colors.white,
      //             borderRadius: BorderRadius.circular(30),
      //           ),
      //           child: Image.asset('assets/images/logotp.png'),
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class SplashScreenTransition extends PageRouteBuilder {
  final Widget screen;
  SplashScreenTransition(this.screen)
      : super(
            pageBuilder: (context, animation, anotherAnimation) => screen,
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
              );
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizeTransition(
                  sizeFactor: animation,
                  child: screen,
                  axisAlignment: 0,
                ),
              );
            });
}
