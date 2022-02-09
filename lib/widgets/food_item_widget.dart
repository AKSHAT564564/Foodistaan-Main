import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:foodistan/constants.dart';
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
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                '${widget.menuItem['image']}',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Text('${widget.menuItem['title']}',
                                maxLines: 3,
                                // address.length > 25
                                //   ? address.substring(0, 25) + '...'
                                //   : address,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: Text("${widget.menuItem['description']}",
                        maxLines: 3,
                        style: TextStyle(
                            fontSize: 10, fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(254, 247, 229, 1),
                        borderRadius: BorderRadius.all(Radius.circular(3))),
                    padding: EdgeInsets.all(5),
                    child: Row(children: [
                      Icon(
                        Icons.copyright,
                        size: 10,
                        color: kGreen,
                      ),
                      Text(
                        " Earn upto 200 FS points",
                        style: TextStyle(fontSize: 8),
                      )
                    ]),
                  ),
                  SizedBox(
                    height: 5,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Text("₹ ${widget.menuItem['price']}",
                            maxLines: 3,
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700)),
                      ),
                      Container(
                        child: CartFunctions().quantityWidgetInRestaurant(
                            widget.cartId,
                            widget.menuItem['id'],
                            widget.vendor_id,
                            widget.menuItem,
                            widget.vendorName),
                      ),
                    ],
                  )
                  // SizedBox(
                  //   height: 3,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
