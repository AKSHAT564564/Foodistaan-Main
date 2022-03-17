import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/cart_screens/total_price_screen.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/customLoadingSpinner.dart';
import 'package:foodistan/global/global_variables.dart';
import 'package:foodistan/providers/cart_id_provider.dart';
import 'package:foodistan/providers/restaurant_data_provider.dart';
import 'package:provider/provider.dart';

class CouponScreen extends StatefulWidget {
  var totalPrice;
  CouponScreen({required this.totalPrice});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  List coupons = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    asyncGetCoupons().then((value) {
      setState(() {
        coupons = value;
      });
    });
  }

  asyncGetCoupons() async {
    List coupons = [];
    final CollectionReference couponsList =
        FirebaseFirestore.instance.collection('coupons');

    try {
      await couponsList.get().then((querySnapshot) => {
            querySnapshot.docs.forEach((element) {
              coupons.add(element.data());
            })
          });
    } catch (e) {
      print(e.toString());
    }
    return coupons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Coupon Selection',
        ),
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade100,
      body: coupons.isEmpty
          ? Center(
              child: CustomLoadingSpinner(),
            )
          : ListView.builder(
              itemCount: coupons.length,
              itemBuilder: (BuildContext context, int index) {
                Map<String, dynamic> couponData = coupons[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 11,
                    vertical: 5.5,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              contentPadding: EdgeInsets.all(0),
                              title: Text(
                                couponData['code'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                              ),
                              trailing: Consumer<CartIdProvider>(
                                builder: (context, value, buttonWidget) {
                                  return TextButton(
                                    onPressed: () async {
                                      if (widget.totalPrice <
                                          couponData['min-price']) {
                                        return;
                                      } else {
                                        if (value.hasData) {
                                          await CartDataProvider().addCoupon(
                                              value.cartId, couponData['id']);

                                          await CartDataProvider()
                                              .getRestaurantData(value.cartId);

                                          Navigator.pop(
                                            context,
                                          );
                                        }
                                      }
                                    },
                                    child: Text(
                                      'Apply',
                                      style: TextStyle(
                                        color: Colors.yellow.shade700,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              subtitle: widget.totalPrice <
                                      couponData['min-price']
                                  ? Text(
                                      'Add items worth ₹ ' +
                                          (couponData['min-price'] -
                                                  widget.totalPrice)
                                              .toString() +
                                          ' to avail this offer!',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    )
                                  : Text(
                                      'You will save ' +
                                          (widget.totalPrice *
                                                  (couponData['percentage'] /
                                                      100))
                                              .toString() +
                                          ' with this coupon!',
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Get ${couponData['percentage']}% off upto ${couponData['max-discount']}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              'Valid on orders with items worth Rs. ${couponData['min-price']}',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
