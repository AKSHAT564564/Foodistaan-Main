import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/UserLogin/user_detail_form.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  String phone;
  OTPScreen({required this.phone});
  @override
  _OTPScreenState createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool showSpinner = false;
  String? verificationCode;
  // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //for error handling of wrong OTP
  bool wrongOtpEntered = false;

  //generating stream which will keep not of the otp Timer
  StreamController<int> _streamController = StreamController<int>.broadcast();
  //_counter for initializing the otp counter
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    //initializing the variable again
    //adding 60 to the value represnets 60 sec
    _streamController = new StreamController<int>.broadcast();
    _streamController.add(60);
    //calling startTimer method to start the timer as soon as the initState is called
    _startTimer();
    verifyPhoneNumber();
  }

  //timer variable
  //used to keep the timer value in Check
  Timer? _timer;
  void _startTimer() {
    //initializing the counter to 60
    _counter = 60;
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //setState(() {
      (_counter > 0) ? _counter-- : _timer!.cancel();
      //});
      //adding 60 seconds to the stream
      _streamController.add(_counter);
    });
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: Duration(seconds: 2),
      ),
    );
  }

  verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: widget.phone,
        verificationCompleted: (PhoneAuthCredential credential) async {
          User? user;
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) {
            if (value.user != null) {
              user = value.user;
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             UserDetail(phone_number: widget.phone)));
            }
          });
          if (user != null) {
            await FirebaseFirestore.instance
                .collection('users')
                .doc(widget.phone)
                .get()
                .then((value) {
              if (value.exists) {
                if (value.data()!.containsKey('cart-id')) {
                  //check if cart-id exixts for a user or not
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                      (route) => false);
                } else {
                  //if cart-id D.N.E than creates a cart-id then pushes main screen
                  String uId = user!.uid;
                  CartFunctions()
                      .createCartFeild(uId, widget.phone)
                      .then((value) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => MainScreen()),
                        (route) => false);
                  });
                }
              } else {
                //if the user itself is new then proceed to user details
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            UserDetail(phone_number: widget.phone)));
              }
            });
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            duration: Duration(seconds: 2),
          ));
        },
        codeSent: (String vId, int? resendToken) {
          setState(() {
            verificationCode = vId;
          });
        },
        codeAutoRetrievalTimeout: (String vId) {
          setState(() {
            verificationCode = vId;
          });
        },
        timeout: const Duration(seconds: 60));
  }

  final BoxDecoration pinOTPCodeDecoration = BoxDecoration(
    color: Color(0xffFFEEC0),
    borderRadius: BorderRadius.circular(5.0),
    border: Border.all(
      // color: Color(0xffF7C12B),
      color: kYellowL,
    ),
  );

  getOtpFormWidget(context) {
    //Using stream builder to keep the OTP timer in check
    //stream builder streams the value which is INteger in this case
    return StreamBuilder<int>(
      stream: _streamController.stream,
      builder: (BuildContext streamContext, AsyncSnapshot<int> snapshot) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'Images/otpimage.svg',
              height: MediaQuery.of(context).size.width * 0.33,
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "OTP Sent to ${widget.phone}",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: PinCodeTextField(
                  pastedTextStyle: TextStyle(
                    // color: Colors.yellow,
                    color: kYellowL,
                  ),
                  appContext: context,
                  length: 6,
                  onChanged: (v) {},
                  onCompleted: (value) async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      User? user;
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                              verificationId: verificationCode!,
                              smsCode: value))
                          .then((value) {
                        if (value.user != null) {
                          user = value.user;
                        }
                      });
                      if (user != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(widget.phone)
                            .get()
                            .then((value) {
                          if (value.exists) {
                            if (value.data()!.containsKey('cart-id')) {
                              setState(() {
                                showSpinner = false;
                              });
                              Navigator.pushNamed(context, 'H');
                            } else {
                              String uId = user!.uid;
                              CartFunctions()
                                  .createCartFeild(uId, widget.phone)
                                  .then((value) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pushNamed(context, 'H');
                              });
                            }
                          } else {
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserDetail(
                                        phone_number: widget.phone)));
                          }
                        });
                      }
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      if (e.toString().contains(
                          'firebase_auth/invalid-verification-code')) {
                        setState(() {
                          wrongOtpEntered = true;
                        });
                      }
                      FocusScope.of(context).unfocus();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(e.toString()),
                        duration: Duration(
                          seconds: 3,
                        ),
                      ));
                    }
                  },
                  obscureText: false,
                  animationType: AnimationType.fade,
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      inactiveColor: kYellowL,
                      //  Color(0xFFF7C12B),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      activeColor: Colors.black,
                      selectedColor: kYellowL,
                      // Color(0xFFF7C12B),
                      shape: PinCodeFieldShape.box,
                      fieldWidth: MediaQuery.of(context).size.width * 0.12,
                      fieldHeight: MediaQuery.of(context).size.height * 0.05),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                wrongOtpEntered ? "Wrong Otp Entered" : "",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              ),
            ),
            _timer!.isActive == true
                ? Center(
                    child: Text('Resend Otp in: ${snapshot.data.toString()}'),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Didn't receive the code? ",
                        style: TextStyle(color: Colors.black54, fontSize: 15),
                      ),
                      TextButton(
                          onPressed: () async {
                            _startTimer();
                            verifyPhoneNumber();
                            snackBar('Otp Resent!');
                          },
                          child: Text(
                            "RESEND",
                            style: TextStyle(
                                color: Color(0xFF91D3B3),
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ))
                    ],
                  ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              getOtpFormWidget(context),
            ],
          ),
        ),
      ),
    );
  }
}
