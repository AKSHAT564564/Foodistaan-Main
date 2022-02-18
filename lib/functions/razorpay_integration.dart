import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  RazorPayScreen(
      {required this.finalPrice,
      required this.items,
      required this.cartId,
      required this.vednorId,
      required this.vendorName,
      required this.deliveryAddress});

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
        .placeOrder(widget.vednorId, widget.vendorName, userNumber, itemMap,
            widget.finalPrice, paymentId, widget.cartId, widget.deliveryAddress)
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
      Alert(
        context: context,
        type: AlertType.info,
        title: 'Payment failed',
        desc: error['error']['description'],
        buttons: [
          DialogButton(
            child: Text(
              "Try Again",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () async {
              // Navigator.pushReplacement(context,
              //     MaterialPageRoute(builder: (c) => CartScreenMainLogin()));
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MainScreen(
                            currentIndex: 1,
                          )),
                  (route) => false);
            },
            color: Color.fromRGBO(0, 179, 134, 1.0),
          ),
          // DialogButton(
          //   child: Text(
          //     "NO",
          //     style: TextStyle(color: Colors.white, fontSize: 20),
          //   ),
          //   onPressed: () async {
          //     Navigator.pop(context);
          //   },
          //   gradient: LinearGradient(colors: [
          //     Color.fromRGBO(116, 116, 191, 1.0),
          //     Color.fromRGBO(52, 138, 199, 1.0)
          //   ]),
          // )
        ],
      ).show();
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
    return Container();
  }
}
