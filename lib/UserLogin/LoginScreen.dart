import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodistan/UserLogin/OTPScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneNumberController = TextEditingController();

  bool text = false;

  getMobileFormWidget(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                  "Welcome To",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFFF7C12B),
                    fontSize: 30,
                  ),
                ),
                Text(
                  "STREATO",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF0F1B2B),
                    fontSize: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 11,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
          ),
          child: GestureDetector(
            onTap: () {
              setState(() {
                text = true;
              });
            },
            child: TextFormField(
              keyboardType: TextInputType.number,
              maxLength: 10,
              textAlign: TextAlign.center,
              controller: _phoneNumberController,
              decoration: const InputDecoration(
                focusColor: Color(0xFFF7C12B),
                hintText: 'Phone Number',
                prefix: Text(
                  '+91',
                  // textAlign: TextAlign.end,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.5),
                  ),
                  borderSide: BorderSide(color: Color(0xFFF7C12B), width: 3),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(7.5),
                  ),
                  borderSide: BorderSide(
                    color: Color(0xFFF7C12B),
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
            width: MediaQuery.of(context).size.height * 0.3,
            child: ElevatedButton(
              onPressed: () async {
                if (_phoneNumberController.text != "" &&
                    _phoneNumberController.text.length == 10) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          OTPScreen(phone: "+91" + _phoneNumberController.text),
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
                  Color(0xFFF7C12B),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Color(0xFFF7C12B),
                ),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(7.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'Images/welcometopleft.svg',
                  width: MediaQuery.of(context).size.width * 0.44,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 11,
                    ),
                    Image.asset(
                      'Images/welcometopright.png',
                      width: MediaQuery.of(context).size.width * 0.33,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'Images/welcomebottomleft.png',
                  width: MediaQuery.of(context).size.width * 0.33,
                ),
                SizedBox(
                  height: 11,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SvgPicture.asset(
                      'Images/welcomebottomright.svg',
                      width: MediaQuery.of(context).size.width * 0.44,
                    ),
                  ],
                ),
              ],
            ),
            getMobileFormWidget(context),
          ],
        ),
      ),
    );
  }
}
