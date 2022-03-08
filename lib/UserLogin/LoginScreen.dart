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
  late FocusNode phoneFocusNode;

  @override
  void initState() {
    super.initState();

    phoneFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    phoneFocusNode.dispose();

    super.dispose();
  }

  getMobileFormWidget(context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin:
                EdgeInsets.only(bottom: phoneFocusNode.hasFocus ? 2.h : 3.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello FOODIES",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    // color: Color(0xFFF7C12B),
                    color: kYellowL,
                    fontSize: 26.sp,
                  ),
                ),
                Text(
                  "Let’s get Started",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    color: kYellowL,
                    // Color(0xFF0F1B2B),
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.h,
          ),
          // AnimatedContainer(
          //   alignment: Alignment.center,
          //   duration: Duration(
          //     seconds: 1,
          //   ),
          //   curve: Curves.fastOutSlowIn,
          //   height: !focusNode.hasFocus ? 45.h : 0.h,
          //   width: 100.h,
          //   child: Column(
          //     children: [
          //       Image.asset(
          //         'assets/images/cartgif.gif',
          //         height: 35.h,
          //         fit: BoxFit.fill,
          //       ),
          //       Text(
          //         "Jump the Queue - Enjoy Your Favourite \nStreet Food Delivered to you in Minutes",
          //         style: TextStyle(fontWeight: FontWeight.w600),
          //       )
          //     ],
          //   ),
          // ),
          Container(
            // height: MediaQuery.of(context).size.height * 0.07,
            width: 100.w,
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
                focusNode: phoneFocusNode,
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
            height: 1.5.h,
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.07,
              width: 100.w,
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
                    elevation: MaterialStateProperty.all(4.sp)),
              ),
            ),
          ),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              height: 100.h,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              top: phoneFocusNode.hasFocus ? -25.h : 0,
              child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  // height: MediaQuery.of(context).size.height * 0.65,
                  height: 90.h,
                  child: Image.asset('assets/images/loginBG.png',
                      // height: 20,
                      fit: BoxFit.fill)),
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

            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              top: phoneFocusNode.hasFocus ? 25.h : 50.h,
              child: getMobileFormWidget(context),
            ),
          ],
        ),
      ),
    );
  }
}
