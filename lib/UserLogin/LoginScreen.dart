import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodistan/UserLogin/OTPScreen.dart';
import 'package:foodistan/constants.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController();

  bool text = false;

  var _height;
  late FocusNode focusNode;

  @override
  void initState() {
    super.initState();

    focusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode.dispose();

    super.dispose();
  }

  getMobileFormWidget(context) {
    return Positioned.fill(
      bottom: focusNode.hasFocus ? 30.h : 8.h,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: focusNode.hasFocus ? 2.h : 3.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 11,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hello..",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF0F1B2B),
                              fontSize: 25.sp,
                            ),
                          ),
                          SizedBox(
                            height: 0.5.h,
                          ),
                          Text(
                            "FOODIES",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              // color: Color(0xFFF7C12B),
                              color: kYellowL,
                              fontSize: 40.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: focusNode.hasFocus ? 15.h : 1.h,
            ),
            AnimatedContainer(
              alignment: Alignment.center,
              duration: Duration(
                seconds: 1,
              ),
              curve: Curves.fastOutSlowIn,
              height: !focusNode.hasFocus ? 45.h : 0.h,
              width: 100.h,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/cartgif.gif',
                    height: 35.h,
                    fit: BoxFit.fill,
                  ),
                  Text(
                    "Jump the Queue - Enjoy Your Favourite \nStreet Food Delivered to you in Minutes",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )
                ],
              ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height * 0.07,

              width: MediaQuery.of(context).size.height * 0.55,
              padding: EdgeInsets.symmetric(
                horizontal: 11,
              ),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    text = true;
                  });
                },
                child: TextFormField(
                  focusNode: focusNode,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  textAlign: TextAlign.center,
                  controller: _phoneNumberController,
                  decoration: const InputDecoration(
                    // focusColor: Color(0xFFF7C12B),
                    focusColor: kYellowL,
                    hintText: 'Phone Number',
                    prefix: Text(
                      '+91',
                      // textAlign: TextAlign.end,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        // color: Color(0xFFF7C12B),
                        color: kYellowL,
                        width: 3,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        // color: Color(0xFFF7C12B),
                        color: kYellowL,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.07,
                width: MediaQuery.of(context).size.height * 0.55,
                padding: EdgeInsets.symmetric(
                  horizontal: 11,
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_phoneNumberController.text != "" &&
                        _phoneNumberController.text.length == 10) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OTPScreen(
                              phone: "+91" + _phoneNumberController.text),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'Send OTP',
                    style: TextStyle(
                      fontSize: 17.5,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        // Color(0xFFF7C12B),
                        kYellowL,
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        // Color(0xFFF7C12B),
                        kYellowL,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                      ),
                      elevation: MaterialStateProperty.all(10.sp)),
                ),
              ),
            ),
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              color: Colors.white,
              // decoration: BoxDecoration(
              //     image: DecorationImage(
              //   fit: BoxFit.fill,
              //   image: AssetImage('assets/images/Login Screen BGImage.png'),
              // )),
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     SvgPicture.asset(
            //       'Images/welcometopleft.svg',
            //       width: MediaQuery.of(context).size.width * 0.44,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         SizedBox(
            //           height: 11,
            //         ),
            //         Image.asset(
            //           'Images/welcometopright.png',
            //           width: MediaQuery.of(context).size.width * 0.33,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Image.asset(
            //       'Images/welcomebottomleft.png',
            //       width: MediaQuery.of(context).size.width * 0.33,
            //     ),
            //     SizedBox(
            //       height: 11,
            //     ),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   crossAxisAlignment: CrossAxisAlignment.end,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       crossAxisAlignment: CrossAxisAlignment.end,
            //       children: [
            //         SvgPicture.asset(
            //           'Images/welcomebottomright.svg',
            //           width: MediaQuery.of(context).size.width * 0.44,
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            // getMobileFormWidget(context),

            Container(
              child: getMobileFormWidget(context),
            ),
          ],
        ),
      ),
    );
  }
}
