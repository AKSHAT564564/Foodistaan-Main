import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:sizer/sizer.dart';

class Help extends StatelessWidget {
  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        title: const Text(
          'Help Desk',
        ),
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: HelpDeskScreen(),
      ),
      //  Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Center(
      //       child: Text(
      //         'Today, 1:30 pm',
      //         style: TextStyle(
      //           color: Colors.grey,
      //         ),
      //       ),
      //     ),
      //     Row(
      //       mainAxisAlignment: MainAxisAlignment.start,
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: const [
      //         SizedBox(
      //           width: 11,
      //         ),
      //         CircleAvatar(
      //           backgroundColor: Colors.white,
      //           radius: 25,
      //           child: Image(
      //             image: AssetImage('Images/helpbot.png'),
      //           ),
      //         ),
      //       ],
      //     ),
      //     Stack(
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.only(
      //             left: 5,
      //             right: 20,
      //             bottom: 5,
      //           ),
      //           child: Center(
      //             child: Image.asset(
      //               'Images/helptext.png',
      //               width: double.infinity,
      //             ),
      //           ),
      //         ),
      //         Column(
      //           children: [
      //             const SizedBox(
      //               height: 25,
      //             ),
      //             Row(
      //               children: const [
      //                 SizedBox(
      //                   width: 90,
      //                 ),
      //                 SizedBox(
      //                   width: 225,
      //                   child: Text(
      //                     'Welcome to Foodistaan Chat Support Help Desk. Let us know how can we help you with your query!',
      //                     style: TextStyle(color: Colors.black, fontSize: 17.5),
      //                     textAlign: TextAlign.left,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }
}

class HelpDeskScreen extends StatefulWidget {
  const HelpDeskScreen({Key? key}) : super(key: key);

  @override
  _HelpDeskScreenState createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String message = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   titleSpacing: 0,
      //   leadingWidth: 40,
      //   leading: Builder(
      //     builder: (BuildContext context) {
      //       return IconButton(
      //         icon: const Icon(
      //           Icons.arrow_back_ios_rounded,
      //           color: Colors.black,
      //         ),
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //       );
      //     },
      //   ),
      //   title: Text('Add a Place'),
      //   titleTextStyle: TextStyle(
      //     color: Colors.black,
      //     fontSize: 20,
      //   ),
      // ),
      body: Container(
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 8,
              ),
              Container(
                // height: 45,
                width: double.infinity,
                margin: EdgeInsets.only(left: 30, right: 30),
                padding: EdgeInsets.only(left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 0, 0, 0.06),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 12,
                  decoration: const InputDecoration(
                    hintText:
                        'We are really sorry you faced a problem, Let us know where it went wrong.',
                    hintStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    border: InputBorder.none,
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe the message';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    message = newValue!;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: InkWell(
                  onTap: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.

                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save(); // Save our form now.

                      print('Describe message: ${message}');
                    }
                  },
                  child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: double.infinity,
                      margin: EdgeInsets.only(left: 55, right: 55, top: 10),
                      decoration: BoxDecoration(
                        // color: Color.fromRGBO(250, 184, 76, 1),
                        color: kYellow,
                        borderRadius: BorderRadius.circular(10.sp),
                      ),
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  Text('or shoot us a mail at'),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    'Foodistaan2021@gmail.com',
                    style: TextStyle(
                        color: Color.fromRGBO(0, 41, 255, 1), fontSize: 17),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
