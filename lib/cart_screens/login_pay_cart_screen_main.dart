import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/address_screen.dart';
import 'package:foodistan/MainScreenFolder/coupon_screen.dart';
import 'package:foodistan/functions/address_functions.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodistan/functions/razorpay_integration.dart';
import 'package:foodistan/profile/payment_methods.dart';
import 'package:foodistan/profile/your_orders.dart';
import 'package:foodistan/widgets/location_bottam_sheet_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foodistan/global/global_variables.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

int maxCouponDiscount = 0;
String couponCode = '';
int minCouponValue = 0;
Map<String, dynamic> itemMap = {};

final ValueNotifier<Map<String, dynamic>> deliveryAddress =
    ValueNotifier<Map<String, dynamic>>({});

class CartScreenMainLogin extends StatefulWidget {
  @override
  _CartScreenMainLoginState createState() => _CartScreenMainLoginState();
}

class _CartScreenMainLoginState extends State<CartScreenMainLogin> {
  String? userNumber;
  String cartId = '';
  @override
  void initState() {
    super.initState();
    userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    CartFunctions().getCartId(userNumber).then((value) {
      setState(() {
        cartId = value;
      });
    });

    UserAddress().getDeliveryAddress().then((value) {
      setState(() {
        deliveryAddress.value = value;
      });
    });
  }

  Widget checkIfAnyOrders(userNumber) {
    var stream = FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('orders')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            var count = snapshot.data!.docs.length;
            if (count > 0)
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 33,
                  ),
                  Text(
                    'You Have Existing Orders',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                        Color(0xFFF7C12B),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.white,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Orders()));
                    },
                    child: Text('Track Order'),
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'H');
                      },
                      child: Container(
                        height: 35,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.yellow.shade700,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Center(
                          child: Text(
                            'Place Another Order',
                            style: TextStyle(
                              color: Colors.yellow.shade700,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            else
              return Padding(
                padding: const EdgeInsets.all(11),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'H');
                  },
                  child: Container(
                    height: 35,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.yellow.shade700,
                        width: 1.5,
                      ),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Text(
                        'Add Items to Cart',
                        style: TextStyle(
                          color: Colors.yellow.shade700,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'H');
                },
                child: Container(
                  height: 35,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.yellow.shade700,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                  child: Center(
                    child: Text(
                      'Add Items to Cart',
                      style: TextStyle(
                        color: Colors.yellow.shade700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget cartItems(cartId) {
    var stream = FirebaseFirestore.instance
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.docs.length != 0) {
              return CartItemsWidget(data: snapshot.data!.docs, cartId: cartId);
            }
          }
          return checkIfAnyOrders(userNumber);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              cartId != ''
                  ? cartItems(cartId)
                  : Center(
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemsWidget extends StatefulWidget {
  List<DocumentSnapshot> data;
  String cartId;
  CartItemsWidget({required this.data, required this.cartId});

  @override
  _CartItemsWidgetState createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  Map<String, dynamic> restaurantData = {};
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('cart')
        .doc(widget.cartId)
        .get()
        .then((value) {
      String vendorId = value.data()!['vendor-id'];
      FirebaseFirestore.instance
          .collection('DummyData')
          .doc(vendorId)
          .get()
          .then((value) {
        setState(() {
          restaurantData = value.data()!;
        });
      });

      String couponId = value.data()!['coupon-id'];

      if (couponId != '') {
        FirebaseFirestore.instance
            .collection('coupons')
            .doc(couponId)
            .get()
            .then((value) {
          couponPercentage.value = value.data()!['percentage'];
          couponCode = value.data()!['code'];
          minCouponValue = value.data()!['min-price'];
        });
      }
    });
    getPrice(widget.data);
  }

  getPrice(itemData) {
    int totalPriceTemp = int.parse(CartFunctions().totalPrice(itemData));
    totalPrice.value = totalPriceTemp;
    return totalPriceTemp;
  }

  Widget menuItemWidget(itemData) {
    itemMap[itemData['id']] = itemData['quantity'];

    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Center(
        child: Stack(
          children: [
            Container(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 11,
                    ),
                    itemData['veg'] == true
                        ? Image.asset('assets/images/green_sign.png')
                        : Image.asset('assets/images/red_sign.png'),
                    SizedBox(
                      width: 11,
                    ),
                    Text(
                      itemData['name'],
                      style: TextStyle(
                        fontSize: 17.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () async {
                              await CartFunctions().increaseQuantity(
                                  widget.cartId,
                                  itemData['id'],
                                  itemData['quantity'],
                                  false);
                            },
                            child: Icon(
                              itemData['quantity'] != '1'
                                  ? FontAwesomeIcons.minusCircle
                                  : FontAwesomeIcons.trashAlt,
                              color: Colors.amber,
                              size: 17.5,
                            )),
                        SizedBox(
                          width: 11,
                        ),
                        Text(
                          itemData['quantity'],
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          width: 11,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await CartFunctions().increaseQuantity(
                                  widget.cartId,
                                  itemData['id'],
                                  itemData['quantity'],
                                  true);
                            },
                            child: Icon(
                              FontAwesomeIcons.plusCircle,
                              color: Colors.amber,
                              size: 17.5,
                            )),
                      ],
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Text(
                      '₹ ' +
                          CartFunctions().pricePerItem(
                            itemData['price'],
                            itemData['quantity'],
                          ),
                      style: TextStyle(
                        color: Colors.black,
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
    );
  }

  calculateCouponDiscount(couponPercentage, maxDiscount) {
    double discount = ((couponPercentage / 100) * totalPrice.value);
    if (minCouponValue > totalPrice.value)
      totalPriceMain.value = double.parse(totalPrice.value.toString());
    else if (discount > maxDiscount)
      totalPriceMain.value =
          totalPrice.value - double.parse(maxDiscount.toString());
    else
      totalPriceMain.value = totalPrice.value - discount;
  }

  @override
  Widget build(BuildContext context) {
    if (restaurantData.isNotEmpty) {
      return SafeArea(
        child: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  leading: Image.network(restaurantData['FoodImage']),
                  title: Text(
                    restaurantData['Name'],
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  subtitle: Text(
                    restaurantData['Address'],
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return menuItemWidget(widget.data[index].data());
                      }),
                ),
                ValueListenableBuilder(
                    valueListenable: totalPrice,
                    builder: (context, value, child) {
                      return Padding(
                        padding: const EdgeInsets.all(11),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Cart Total - ₹ ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              getPrice(widget.data).toString(),
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CouponScreen(
                          cartId: widget.cartId, totalPrice: totalPrice.value),
                    ),
                  ).then((value) {
                    setState(() {});
                  }),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.077,
                        width: double.infinity,
                        color: Colors.white,
                        child: Center(
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Icon(
                                    Icons.local_offer_outlined,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  ValueListenableBuilder(
                                      valueListenable: totalPrice,
                                      builder: (context, value, child) {
                                        return ValueListenableBuilder<int>(
                                            valueListenable: couponPercentage,
                                            builder: (BuildContext context,
                                                int value, Widget? child) {
                                              if (couponPercentage.value == 0) {
                                                totalPriceMain.value =
                                                    double.parse(totalPrice
                                                        .value
                                                        .toString());
                                                return Text(
                                                  'Apply Coupon',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.045,
                                                  ),
                                                );
                                              } else if (minCouponValue >
                                                  totalPrice.value) {
                                                calculateCouponDiscount(
                                                    couponPercentage.value,
                                                    maxCouponDiscount);
                                                return Text(
                                                  'Add More',
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.045,
                                                  ),
                                                );
                                              } else {
                                                calculateCouponDiscount(
                                                    couponPercentage.value,
                                                    maxCouponDiscount);
                                                return Text(
                                                  couponCode,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.045,
                                                  ),
                                                );
                                              }
                                            });
                                      }),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ValueListenableBuilder(
                                      valueListenable: totalPrice,
                                      builder: (context, value, child) {
                                        return ValueListenableBuilder<int>(
                                            valueListenable: couponPercentage,
                                            builder: (BuildContext context,
                                                int value, Widget? child) {
                                              if (couponPercentage.value == 0) {
                                                totalPriceMain.value =
                                                    double.parse(totalPrice
                                                        .value
                                                        .toString());
                                                return Icon(
                                                  Icons.arrow_forward_ios,
                                                  color: Colors.black,
                                                );
                                              } else {
                                                calculateCouponDiscount(
                                                    couponPercentage.value,
                                                    maxCouponDiscount);
                                                return TextButton(
                                                    onPressed: () async {
                                                      FirebaseFirestore.instance
                                                          .collection('cart')
                                                          .doc(widget.cartId)
                                                          .update({
                                                        'coupon-id': ''
                                                      }).then((value) {
                                                        couponPercentage.value =
                                                            0;

                                                        setState(() {});
                                                      });
                                                    },
                                                    child: Text(
                                                        'Remove ${couponPercentage.value}% Off',
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xfff7c12b),
                                                          // fontSize: MediaQuery.of(context).size.width*0.03,
                                                        )));
                                              }
                                            });
                                      }),
                                  SizedBox(
                                    width: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ValueListenableBuilder(
                    valueListenable: orderType,
                    builder: (context, value, widget) {
                      if (orderType.value == 'delivery') {
                        return ValueListenableBuilder(
                            valueListenable: deliveryAddress,
                            builder:
                                (context, Map<String, dynamic> value, widget) {
                              if (value.isEmpty) {
                                return GestureDetector(
                                  onTap: () async {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AddressScreen()));
                                  },
                                  child: Center(
                                    child: Text('Add Adress'),
                                  ),
                                );
                              } else {
                                return ListTile(
                                  leading: Text(value['category']),
                                  title: Text(value['house-feild']),
                                  subtitle: Text(value['street-feild']),
                                  trailing: TextButton(
                                      onPressed: null, child: Text('Change')),
                                );
                              }
                            });
                      } else {
                        return GestureDetector(
                          onTap: null,
                          child: Text('ABCD'),
                        );
                      }
                    }),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 15,
                    ),
                    child: ValueListenableBuilder<double>(
                        valueListenable: totalPriceMain,
                        builder: (context, value, child) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RazorPayScreen(
                                    totalPrice: totalPriceMain.value,
                                    items: itemMap,
                                    cartId: widget.cartId,
                                    vednorId: restaurantData['id'],
                                    vendorName: restaurantData['Name'],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 35,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: Colors.yellow.shade700,
                                  width: 1.5,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Center(
                                child: Text(
                                  'Proceed To Pay ₹ ${totalPriceMain.value}',
                                  style: TextStyle(
                                    color: Colors.yellow.shade700,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          );
                        })),
              ],
            ),
          ),
        ),
      );
    } else {
      return CircularProgressIndicator();
    }
  }
}
