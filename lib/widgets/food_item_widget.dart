import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:foodistan/functions/cart_functions.dart';

class MyFoodItemWidget extends StatefulWidget {
  static String id = 'my_food_widget';
  var menuItem;
  String vendor_id, cartId, vendorName;
  MyFoodItemWidget(
      {required this.menuItem,
      required this.vendor_id,
      required this.cartId,
      required this.vendorName});

  @override
  _MyFoodItemWidgetState createState() => _MyFoodItemWidgetState();
}

class _MyFoodItemWidgetState extends State<MyFoodItemWidget> {
  String? user_number;

  @override
  void initState() {
    super.initState();
    user_number = AuthMethod().checkUserLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.network('${widget.menuItem['image']}'),
          ),
          Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('${widget.menuItem['title']}',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MediaQuery.of(context).size.width*0.04,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width * 0.30,
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Text("${widget.menuItem['description']}",
                        maxLines: 3,
                        style:
                            TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.30,
                    child: Text("₹ ${widget.menuItem['price']}",
                        maxLines: 3,
                        style:
                            TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.033,
                    child: Center(
                      child: CartFunctions().quantityWidgetInRestaurant(
                          widget.cartId,
                          widget.menuItem['id'],
                          widget.vendor_id,
                          widget.menuItem,
                          widget.vendorName),
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
