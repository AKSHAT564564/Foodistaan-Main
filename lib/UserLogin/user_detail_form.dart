import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/HomeScreenFile.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:sizer/sizer.dart';
import 'LoginScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetail extends StatefulWidget {
  String phone_number;

  UserDetail({required this.phone_number});
  @override
  _UserDetailState createState() => _UserDetailState();
}

addUser(_userData) async {
  await FirebaseFirestore.instance
      .collection('users')
      .doc(_userData['phoneNumber'])
      .set({
    'name': _userData['name'],
    'email': _userData['email'],
    'phoneNumber': _userData['phoneNumber'],
    'dateAndTime': _userData['dateAndTime'],
    'profilePic': _userData['profilePic'],
  });
  String uId = FirebaseAuth.instance.currentUser!.uid;
  await CartFunctions().createCartFeild(uId, _userData['phoneNumber']);
}

class _UserDetailState extends State<UserDetail> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  late FocusNode nameFocusNode;
  late FocusNode emailFocusNode;

  Map<String, dynamic> _userData = {
    'name': '',
    'email': '',
    'phoneNumber': '',
    'dateAndTime': '',
    'profilePic': '',
  };

  @override
  void initState() {
    super.initState();

    nameFocusNode = FocusNode();
    emailFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    nameFocusNode.dispose();
    emailFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var h1 = MediaQuery.of(context).size.height;
    // var w1 = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Color(0xff0F1B2B),
        // ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 100.h,
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              top:
                  nameFocusNode.hasFocus || emailFocusNode.hasFocus ? -30.h : 0,
              child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  // height: MediaQuery.of(context).size.height * 0.65,
                  height: 90.h,
                  child: Image.asset('assets/images/loginBG.png',
                      // height: 20,
                      fit: BoxFit.fill)),
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 1000),
              curve: Curves.fastOutSlowIn,
              top: nameFocusNode.hasFocus || emailFocusNode.hasFocus
                  ? 25.h
                  : 55.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    width: 100.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    child: TextFormField(
                      focusNode: nameFocusNode,
                      textAlign: TextAlign.center,
                      controller: nameController,
                      //keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusColor: Colors.yellow,
                        hintText: 'Name',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          borderSide: BorderSide(
                            color: kYellowL,
                            width: 3,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          borderSide: BorderSide(
                            color: kYellowL,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.01,
                    ),
                    width: 100.w,
                    padding: EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    child: TextFormField(
                      focusNode: emailFocusNode,
                      textAlign: TextAlign.center,
                      controller: emailController,
                      //keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        focusColor: Colors.yellow,
                        hintText: 'Email-id',
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          borderSide: BorderSide(
                            color: kYellowL,
                            width: 3,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                          borderSide: BorderSide(
                            color: kYellowL,
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.03,
                    ),
                    width: 100.w,
                    height: MediaQuery.of(context).size.height * 0.07,
                    padding: EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        _userData['name'] = nameController.text;
                        _userData['email'] = emailController.text;
                        _userData['phoneNumber'] = widget.phone_number;
                        _userData['dateAndTime'] = DateTime.now().toString();
                        addUser(_userData).then((v) {
                          Navigator.of(context).pushNamedAndRemoveUntil(
                              'H', (Route<dynamic> route) => false);
                        });
                      },
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          fontSize: 17.5,
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                            kYellowL,
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            kYellowL,
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.sp),
                              ),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(4.sp)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
