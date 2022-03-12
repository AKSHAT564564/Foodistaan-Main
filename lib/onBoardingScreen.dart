import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodistan/UserLogin/LoginScreen.dart';
import 'package:foodistan/constants.dart';
import 'package:sizer/sizer.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 1.5.w),
      height: isActive ? 2.h : 1.2.h,
      width: isActive ? 2.h : 1.2.h,
      decoration: BoxDecoration(
          color: isActive ? kGreyDark : kGreyOf,
          // borderRadius: BorderRadius.all(Radius.circular(12)),
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.5,
            color: isActive ? kGreyDark : kGrey,
          )),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageChangeAutomation();
  }

  void pageChangeAutomation() {
    if (_currentPage != _numPages - 1 && _currentPage < 2) {
      Timer(Duration(seconds: 5), () {
        setState(() {
          _pageController.nextPage(
            duration: Duration(milliseconds: 500),
            curve: Curves.ease,
          );
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  height: 8.h,
                  child: _currentPage != _numPages - 1
                      ? Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // _pageController.nextPage(
                              //   duration: Duration(milliseconds: 500),
                              //   curve: Curves.ease,
                              // );

                              _pageController.animateToPage(
                                2,
                                curve: Curves.ease,
                                duration: Duration(milliseconds: 500),
                              );

                              print('Skip');
                            },
                            child: Text(
                              'SKIP>>',
                              style: TextStyle(
                                color: kBlack,
                                fontSize: 10.5.sp,
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Container(
                  height: 82.h,
                  // color: Colors.red,
                  child: PageView(
                    physics: ClampingScrollPhysics(),
                    // physics: NeverScrollableScrollPhysics(),
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                      pageChangeAutomation();
                      print(page);
                    },
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          right: 3.h,
                          left: 3.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Street food on doorstep',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlack,
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/mega-creator.png',
                                ),
                                fit: BoxFit.fill,
                                height: 40.h,
                                width: 40.h,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'We deliver from smallest to largest vendors near you and that too at your doorstep in least time possible.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlack,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              height: 6.h,
                              width: 50.w,
                              child: ElevatedButton(
                                onPressed: () async {},
                                child: Text(
                                  'Experience Now',
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: kBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2.5.w),
                                        ),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(4.sp)),
                              ),
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 3.h,
                          left: 3.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Look for',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlack,
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: Image(
                                image: AssetImage(
                                  'assets/images/Streato plus tag (3).png',
                                ),
                                fit: BoxFit.fitWidth,
                                height: 40.h,
                                width: 40.h,
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'We assure everything that’s makes up your meal, from ingredients to hygiene at vendor’s place.\nWe have got you back.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlack,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              height: 6.h,
                              width: 50.w,
                              child: ElevatedButton(
                                onPressed: () async {},
                                child: Text(
                                  'Be Assured',
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: kBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2.5.w),
                                        ),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(4.sp)),
                              ),
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: 3.h,
                          left: 3.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Streato Points',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 32.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlack,
                              ),
                            ),
                            Spacer(),
                            Center(
                              child: Container(
                                padding: EdgeInsets.only(
                                  bottom: 6.h,
                                ),
                                child: Image(
                                  image: AssetImage(
                                    'assets/images/token 1.png',
                                  ),
                                  fit: BoxFit.fill,
                                  height: 30.h,
                                  width: 30.h,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              'Every penny and every order counts. Get Streato points on every order and redeem them on next order for existing offers.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.5.sp,
                                fontWeight: FontWeight.w600,
                                color: kBlack,
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Container(
                              height: 6.h,
                              width: 50.w,
                              child: ElevatedButton(
                                onPressed: () async {
                                  Navigator.of(context)
                                      .pushReplacement(MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        LoginScreen(),
                                  ));
                                },
                                child: Text(
                                  'Register Now',
                                  style: TextStyle(
                                    fontSize: 17.5,
                                    color: kBlack,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                style: ButtonStyle(
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                      Colors.white,
                                    ),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(2.5.w),
                                        ),
                                      ),
                                    ),
                                    elevation: MaterialStateProperty.all(4.sp)),
                              ),
                            ),
                            SizedBox(height: 5.h),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  // color: Colors.red,
                  height: 5.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  ),
                ),
                // _currentPage != _numPages - 1
                //     ? Expanded(
                //         child: Align(
                //           alignment: FractionalOffset.bottomRight,
                //           child: TextButton(
                //             onPressed: () {
                //               _pageController.nextPage(
                //                 duration: Duration(milliseconds: 500),
                //                 curve: Curves.ease,
                //               );
                //               // print(_currentPage);
                //               // print(_numPages - 1);
                //             },
                //             child: Row(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               mainAxisSize: MainAxisSize.min,
                //               children: <Widget>[
                //                 Text(
                //                   'Next',
                //                   style: TextStyle(
                //                     color: Colors.black,
                //                     fontSize: 14.5.sp,
                //                     fontWeight: FontWeight.w600,
                //                   ),
                //                 ),
                //                 SizedBox(width: 0.5.w),
                //                 Icon(
                //                   Icons.arrow_forward_ios_rounded,
                //                   color: Colors.black,
                //                   size: 14.sp,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       )
                //     : Text(''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
