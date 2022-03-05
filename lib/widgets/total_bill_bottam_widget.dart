import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/global/global_variables.dart';
import 'package:sizer/sizer.dart';

class TotalBillBottomWidget extends StatefulWidget {
  const TotalBillBottomWidget({Key? key}) : super(key: key);

  @override
  _TotalBillBottomWidgetState createState() => _TotalBillBottomWidgetState();
}

class _TotalBillBottomWidgetState extends State<TotalBillBottomWidget> {
  String? userNumber;
  String cartId = '';
  var stream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    CartFunctions().getCartId(userNumber).then((value) {
      setState(() {
        cartId = value;
        stream = FirebaseFirestore.instance
            .collection('cart')
            .doc(cartId)
            .collection('items')
            .snapshots();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return cartId == ''
        ? CircularProgressIndicator()
        : StreamBuilder(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length != 0) {
                  var itemsNumber = snapshot.data!.docs.length;

                  return Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.09,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(11),
                        topRight: Radius.circular(11),
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.07,
                        decoration: BoxDecoration(
                          color: kGreen,
                          borderRadius: BorderRadius.circular(11),
                        ),
                        child: Center(
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("$itemsNumber Items in the Cart",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.044)),
                                      SizedBox(
                                        height: 3,
                                      ),
                                      Text("Extra charges may apply",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.035)),
                                    ],
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (c) => Scaffold(
                                                        // appBar: PreferredSize(
                                                        //     preferredSize:
                                                        //         Size.fromHeight(
                                                        //             4.8.h),
                                                        //     child: AppBar(
                                                        //       backgroundColor:
                                                        //           Colors.white,
                                                        //       elevation: 0,
                                                        //       titleSpacing: 0,
                                                        //       leadingWidth: 40,
                                                        //       iconTheme:
                                                        //           IconThemeData(
                                                        //               color: Colors
                                                        //                   .black,
                                                        //               size: 25),

                                                        //     )),
                                                        appBar: PreferredSize(
                                                          preferredSize:
                                                              Size.fromHeight(
                                                                  4.8.h),
                                                          child: AppBar(
                                                            backgroundColor:
                                                                Colors.white,
                                                            elevation: 0,
                                                            titleSpacing: 0,
                                                            leadingWidth: 40,
                                                            titleTextStyle:
                                                                TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        20),
                                                            leading: IconButton(
                                                              onPressed: () {
                                                                Navigator.popUntil(
                                                                    context,
                                                                    (Route<dynamic>
                                                                            route) =>
                                                                        route
                                                                            .isFirst);
                                                                // Navigator.pushNamedAndRemoveUntil(
                                                                //     context,
                                                                //     'H',
                                                                //     (route) =>
                                                                //         false);
                                                              },
                                                              icon: const Icon(
                                                                Icons
                                                                    .arrow_back_ios,
                                                                color: Colors
                                                                    .black,
                                                                size: 25,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        body:
                                                            CartScreenMainLogin(),
                                                      )));
                                        },
                                        child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(11),
                                          ),
                                          child: Center(
                                            child: Text(
                                              "View Bill",
                                              style: TextStyle(
                                                color: kGreen,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.035,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 11,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center();
                }
              } else
                return Center();
            });
  }
}
