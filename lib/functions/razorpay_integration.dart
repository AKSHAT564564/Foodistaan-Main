import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/customLoadingSpinner.dart';
import 'package:sizer/sizer.dart';
import 'package:foodistan/MainScreenFolder/mainScreenFile.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:foodistan/profile/your_orders.dart';
import 'package:foodistan/widgets/order_placed_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:foodistan/global/global_variables.dart';

class RazorPayScreen extends StatefulWidget {
  double finalPrice;
  String cartId, vednorId, vendorName;
  Map<String, dynamic> items;
  Map<String, dynamic> deliveryAddress;
  String orderType;
  RazorPayScreen(
      {required this.finalPrice,
      required this.items,
      required this.cartId,
      required this.vednorId,
      required this.vendorName,
      required this.deliveryAddress,
      required this.orderType});

  @override
  _RazorPayScreenState createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  Razorpay? _razorpay;
  String? userNumber;
  @override
  void initState() {
    super.initState();

    userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;

    _razorpay = new Razorpay();

    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    openCheckout();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_GjPw97IIEcO9oU",
      "amount": widget.finalPrice * 100,
      "name": "Sample App",
      "description": "Payment for the some random product",
      "prefill": {"contact": "$userNumber", "email": "akshat@gmail.com"},
      "external": {
        "wallets": ["paytm"]
      },
      "theme": {"color": "#f7c12b"}
    };

    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    String paymentId = response.paymentId!;
    OrderFunction()
        .placeOrder(
            widget.vednorId,
            widget.vendorName,
            userNumber,
            itemMap,
            widget.finalPrice,
            paymentId,
            widget.cartId,
            widget.deliveryAddress,
            widget.orderType)
        .then((value) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              child: OrderPlacedScreen(
                  vendorName: widget.vendorName, orderId: value)));
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (context) => OrderPlacedScreen()));
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    if (response.code != null) {
      var error = json.decode(response.message.toString());
      print('Error Message $error');
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.topToBottom,
              child: PaymentErrorWidget()));

      // Alert(
      //   context: context,
      //   type: AlertType.info,
      //   title: 'Payment failed',
      //   desc: error['error']['description'],
      //   // closeFunction: () async {
      //   //   Navigator.pushAndRemoveUntil(
      //   //       context,
      //   //       MaterialPageRoute(
      //   //         builder: (context) => MainScreen(
      //   //           currentIndex: 1,
      //   //         ),
      //   //       ),
      //   //       (route) => false);
      //   // },
      //   buttons: [
      //     DialogButton(
      //       child: Text(
      //         "Try Again",
      //         style: TextStyle(color: Colors.white, fontSize: 20),
      //       ),
      //       onPressed: () async {
      //         Navigator.pushAndRemoveUntil(
      //             context,
      //             MaterialPageRoute(
      //                 builder: (context) => MainScreen(
      //                       currentIndex: 1,
      //                     )),
      //             (route) => false);
      //       },
      //       color: Color.fromRGBO(0, 179, 134, 1.0),
      //     ),
      //   ],
      // ).show();
    }

    Fluttertoast.showToast(
        msg: "Payment Faliure" +
            response.code.toString() +
            "-" +
            response.message!,
        timeInSecForIosWeb: 5);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 100.h,
        // width: double.infinity,
        color: Colors.white,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/emojione_sad-but-relieved-face.png',
                    height: 15.h,
                    width: 15.h,
                  ),
                  SizedBox(height: 4.5.h),
                  Text(
                    'Opps something went wrong!',
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.5.sp,
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  Text(
                    'Don’t worry if something debited from your account, rest assured it’ll be back in your account within 48 hours.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kGreyDark2,
                      fontSize: 10.5.sp,
                    ),
                  ),
                  // CustomLoadingSpinner()
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                                currentIndex: 1,
                              )),
                      (route) => false);
                },
                child: Container(
                  height: 45,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 8.5.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: kRedPure,
                    color: kYellowL,
                    border: Border.all(
                      // color: kRedPure,
                      color: kYellowL,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Go Back To Cart',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentErrorWidget extends StatelessWidget {
  const PaymentErrorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // height: 100.h,
        // width: double.infinity,
        color: Colors.white,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/emojione_sad-but-relieved-face.png',
                    height: 15.h,
                    width: 15.h,
                  ),
                  SizedBox(height: 4.5.h),
                  Text(
                    'Opps Payment Failed',
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.5.sp,
                    ),
                  ),
                  SizedBox(height: 2.5.h),
                  Text(
                    'Don’t worry if something debited from your account, rest assured it’ll be back in your account within 48 hours.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kGreyDark2,
                      fontSize: 10.5.sp,
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: GestureDetector(
                onTap: () async {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MainScreen(
                                currentIndex: 1,
                              )),
                      (route) => false);
                },
                child: Container(
                  height: 45,
                  margin: EdgeInsets.only(left: 10, right: 10, bottom: 8.5.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    // color: kRedPure,
                    color: kYellowL,
                    border: Border.all(
                      // color: kRedPure,
                      color: kYellowL,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      'Try again',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
