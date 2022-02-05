import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/coupon_screen.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/functions/razorpay_integration.dart';
import 'package:foodistan/profile/profile_address.dart';
import 'package:foodistan/profile/your_orders.dart';
import 'package:foodistan/providers/cart_id_provider.dart';
import 'package:foodistan/providers/restaurant_data_provider.dart';
import 'package:foodistan/providers/total_price_provider.dart';
import 'package:foodistan/providers/user_address_provider.dart';
import 'package:foodistan/widgets/location_bottam_sheet_widget.dart';
import 'package:provider/provider.dart';

int maxCouponDiscount = 0;
String couponCode = '';
int minCouponValue = 0;
Map<String, dynamic> itemMap = {};

class CartScreenMainLogin extends StatefulWidget {
  String routeName = 'cart';

  @override
  State<CartScreenMainLogin> createState() => _CartScreenMainLoginState();
}

class _CartScreenMainLoginState extends State<CartScreenMainLogin>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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
                        height: 45,
                        margin: EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          // color: Colors.white,
                          color: Color.fromRGBO(247, 193, 43, 1),
                          border: Border.all(
                            color: Colors.yellow.shade700,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'Place Another Order',
                            style: TextStyle(
                              // color: Colors.yellow.shade700,
                              fontWeight: FontWeight.w600,
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
            //if already items exists in the cart it will display cart items
            //if there are no items in the cart
            //it will see if there exits any order
            //then render the widget accordingly
            if (snapshot.data!.docs.length != 0) {
              return CartItemsWidget(data: snapshot.data!.docs, cartId: cartId);
            }
          }
          String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
          return checkIfAnyOrders(userNumber);
        });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CartIdProvider>(context, listen: false).getCartId();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: ListView(
            children: [
              Column(
                children: [
                  Consumer<CartIdProvider>(builder: (context, value, child) {
                    return value.hasData == false
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(11),
                              child: Text(
                                'Loading...',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          )
                        : cartItems(value.cartId);
                  })
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.085,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CartItemsWidget extends StatefulWidget {
  //receving menu items data before hand
  //becoz of the stream
  List<DocumentSnapshot> data;
  String cartId;
  CartItemsWidget({required this.data, required this.cartId});

  @override
  _CartItemsWidgetState createState() => _CartItemsWidgetState();
}

class _CartItemsWidgetState extends State<CartItemsWidget> {
  Widget menuItemWidget(itemData) {
    itemMap[itemData['id']] = itemData['quantity'];

    return Container(
      height: MediaQuery.of(context).size.height * 0.13,
      width: double.infinity,
      padding: EdgeInsets.only(
        top: 5,
        bottom: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Center(
        child: Stack(
          children: [
            Container(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
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
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'vegies, less spice, 3 mayo',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(153, 153, 153, 1),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        Text(
                          'Customize',
                          style: TextStyle(
                            fontSize: 14.5,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Container(
                            // height: 25,
                            // width: 25,
                            margin: EdgeInsets.only(left: 2),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(247, 193, 43, 1),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 10,
                              color: Colors.white,
                            )),
                      ],
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
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color.fromRGBO(247, 193, 43, 1),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
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
                                color: Color.fromRGBO(247, 193, 43, 1),
                                size: 17.5,
                              )),
                          SizedBox(
                            width: 11,
                          ),
                          Text(
                            itemData['quantity'],
                            style: TextStyle(
                              color: Color.fromRGBO(247, 193, 43, 1),
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
                                color: Color.fromRGBO(247, 193, 43, 1),
                                size: 17.5,
                              )),
                        ],
                      ),
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

  couponWidget(bool hasCoupon, couponCode, minCouponValue, totalPrice, cartId) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        // color: Colors.white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Center(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: double.infinity,
          color: Color.fromRGBO(255, 252, 222, 1),
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
                    // Icon(
                    //   Icons.local_offer_outlined,
                    //   color: Color.fromRGBO(247, 193, 43, 1),
                    // ),
                    Container(
                      height: 25,
                      child: Image.asset(
                        'assets/images/bx_bxs-offer.png',
                        // fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    hasCoupon == true && minCouponValue <= totalPrice
                        ? Text(
                            couponCode.toString(),
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          )
                        : hasCoupon == true && minCouponValue > totalPrice
                            ? Text(
                                'Add More To cart',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              )
                            : Text(
                                'Apply Coupon',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                    hasCoupon == true
                        ? Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                                onPressed: () async {
                                  Provider.of<CartDataProvider>(context,
                                          listen: false)
                                      .removeCoupon(cartId);
                                },
                                child: Text(
                                  'Remove Coupon',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    color: Color.fromRGBO(247, 193, 43, 1),
                                  ),
                                )),
                          )
                        : GestureDetector(
                            onTap: () async {
                              await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CouponScreen(
                                              totalPrice: totalPrice)))
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            child: Icon(Icons.arrow_right_sharp))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  int calculateCouponDiscount(totalPrice, couponPercentage, maxDiscount) {
    double discount = ((couponPercentage / 100) * totalPrice);

    return discount < maxDiscount
        ? (totalPrice.toDouble() - discount).ceil()
        : totalPrice - maxDiscount;
  }

  @override
  void initState() {
    super.initState();

    // //calling cart data provider which provides all the relevent data for the cart
    // Provider.of<CartDataProvider>(context, listen: true)
    //     .getRestaurantData(widget.cartId);

    //Provides data for delivery location to the cart
    Provider.of<UserAddressProvider>(context, listen: false)
        .checkDefaultDeliveryAddress();
  }

  @override
  Widget build(BuildContext context) {
    //Provides total price for the items present in the cart
    Timer(const Duration(milliseconds: 300), () async {
      Provider.of<TotalPriceProvider>(context, listen: false)
          .getTotalPrice(widget.data);
    });

    context.read<CartDataProvider>().getRestaurantData(widget.cartId);
    return SafeArea(
      child: Container(
        child: Center(
            child: Consumer<CartDataProvider>(builder: (context, value, child) {
          return value.hasData == false
              ? CircularProgressIndicator(
                  color: Colors.yellow,
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Image.network(value.restaurantData['FoodImage']),
                      title: Text(
                        value.restaurantData['Name'],
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                      subtitle: Text(
                        value.restaurantData['Address'],
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
                    Consumer<TotalPriceProvider>(
                        builder: (_, totalPriceValue, __) {
                      return Column(
                        children: [
                          couponWidget(
                              value.hasCoupon,
                              value.couponCode,
                              value.minCouponValue,
                              totalPriceValue.totalPriceProvider,
                              widget.cartId),
                          Consumer<UserAddressProvider>(builder:
                              (context, userAddressValue, userAddressWidget) {
                            return userAddressValue.hasDeafultAddress
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    color: Color.fromRGBO(255, 252, 222, 1),
                                    padding: EdgeInsets.only(
                                        left: 11, right: 11, top: 15),
                                    child: Container(
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text.rich(TextSpan(
                                            text: 'Deliver to ',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400),
                                            children: <InlineSpan>[
                                              TextSpan(
                                                text: userAddressValue
                                                    .addressData['category']
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextSpan(text: '\n'),
                                              TextSpan(
                                                text: userAddressValue
                                                        .addressData[
                                                            'house-feild']
                                                        .toString() + 
                                                    userAddressValue
                                                        .addressData[
                                                            'street-feild']
                                                        .toString(),
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color.fromRGBO(
                                                        130, 125, 125, 1)),
                                              ),
                                            ],
                                          )),
                                          TextButton(
                                            onPressed: () async {
                                              Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              Address()))
                                                  .then((value) {
                                                setState(() {});
                                              });
                                            },
                                            child: Text(
                                              'Change',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    247, 193, 43, 1),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                // ListTile(
                                //     leading: Text(
                                //         userAddressValue.addressData['category']),
                                //     title: Text(
                                //         userAddressValue.addressData['house-feild']),
                                //     subtitle: Text(
                                //         userAddressValue.addressData['street-feild']),
                                //   trailing: TextButton(
                                //       onPressed: () async {
                                //         Navigator.push(
                                //             context,
                                //             MaterialPageRoute(
                                //                 builder: (context) =>
                                //                     Address())).then((value) {
                                //           setState(() {});
                                //         });
                                //       },
                                //       child: Text(
                                //         'Change',
                                //         style: TextStyle(
                                //           color: Color.fromRGBO(247, 193, 43, 1),
                                //         ),
                                //       )),
                                // )
                                : TextButton(
                                    onPressed: () async {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (context) {
                                            return LocationBottomSheetWidget(
                                              isAddingAddress: true,
                                            );
                                          }).then((value) {
                                        setState(() {});
                                      });
                                    },
                                    child: Text('Add Address'));
                          }),
                          Divider(
                            height: 8,
                            thickness: 8,
                            color: Colors.grey.shade200,
                          ),

                          Container(
                            // height: 150,
                            color: Colors.white,
                            padding: EdgeInsets.only(
                                left: 11, right: 11, top: 20, bottom: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 25,
                                  child: Image.asset(
                                    'assets/images/act_of.png',
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            'Act of Gratitude',
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(
                                            Icons.info_outline_rounded,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                          )
                                        ],
                                      ),
                                      Text.rich(
                                        TextSpan(
                                          text:
                                              'Thank your delivery partner for helping you stay safe indoors. Support them through these  tough times with a tip.',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600,
                                            color: Color.fromRGBO(
                                                153, 153, 153, 1),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 7, 14, 7),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1)),
                                              ),
                                              child: Text(
                                                '₹20',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 7, 14, 7),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1)),
                                              ),
                                              child: Text(
                                                '₹30',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      14, 7, 14, 7),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1,
                                                        color: Color.fromRGBO(
                                                            153, 153, 153, 1)),
                                                  ),
                                                  child: Text(
                                                    '₹50',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                'Most tipped',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1),
                                                    fontSize: 10,
                                                    fontWeight:
                                                        FontWeight.w300),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  14, 7, 14, 7),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: Color.fromRGBO(
                                                        153, 153, 153, 1)),
                                              ),
                                              child: Text(
                                                'Other',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w400),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 8,
                            thickness: 8,
                            color: Colors.grey.shade200,
                          ),
                          Container(
                            color: Colors.white,
                            // height: 80,
                            padding: const EdgeInsets.all(11),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bill Details',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Item Total',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '₹ ${totalPriceValue.totalPriceProvider.toString()}',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Tax & Charges',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '₹ 0',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Delivery Charges',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '₹ 0',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Delivery Tip',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      '₹ 0',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Total Pay',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Container(
                                      child: value.hasCoupon &&
                                              value.minCouponValue <=
                                                  totalPriceValue
                                                      .totalPriceProvider
                                          ? Text(
                                              '₹ ${calculateCouponDiscount(totalPriceValue.totalPriceProvider, value.couponPercentage, value.maxCouponDiscount).toString()}',
                                              style: TextStyle(
                                                // color: Colors.yellow.shade700,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            )
                                          : Text(
                                              '₹ ${totalPriceValue.totalPriceProvider}',
                                              style: TextStyle(
                                                // color: Colors.yellow.shade700,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 25,
                                )
                              ],
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.all(11),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     crossAxisAlignment: CrossAxisAlignment.center,
                          //     children: [
                          //       Text(
                          //         'Cart Total - ₹ ',
                          //         style: TextStyle(
                          //           color: Colors.black,
                          //         ),
                          //       ),
                          //       Text(totalPriceValue.totalPriceProvider
                          //           .toString())
                          //     ],
                          //   ),
                          // ),
                        ],
                      );
                    }),
                    Consumer<TotalPriceProvider>(
                        builder: (context, totalPriceValue, payWidget) {
                      return Container(
                          height: 45,
                          width: double.infinity,
                          margin: EdgeInsets.only(left: 11, right: 11),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(247, 193, 43, 1),
                            border: Border.all(
                              color: Colors.yellow.shade700,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Consumer<UserAddressProvider>(builder:
                              (context, userAddressValue, userAddressWidget) {
                            return GestureDetector(
                              onTap: () async {
                                userAddressValue.hasDeafultAddress == true
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RazorPayScreen(
                                                deliveryAddress:
                                                    userAddressValue
                                                        .addressData,
                                                finalPrice: calculateCouponDiscount(
                                                        totalPriceValue
                                                            .totalPriceProvider,
                                                        value.couponPercentage,
                                                        value.maxCouponDiscount)
                                                    .toDouble(),
                                                items: itemMap,
                                                cartId: widget.cartId,
                                                vednorId:
                                                    value.restaurantData['id'],
                                                vendorName: value
                                                    .restaurantData['Name'])))
                                    : showModalBottomSheet(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return LocationBottomSheetWidget(
                                            isAddingAddress: true,
                                          );
                                        }).then((value) {
                                        setState(() {});
                                      });
                              },
                              child: Center(
                                child: value.hasCoupon &&
                                        value.minCouponValue <=
                                            totalPriceValue.totalPriceProvider
                                    ? Text.rich(
                                        TextSpan(
                                          text: 'Proceed To Pay ₹ ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text:
                                                  '${calculateCouponDiscount(totalPriceValue.totalPriceProvider, value.couponPercentage, value.maxCouponDiscount).toString()}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    : Text.rich(
                                        TextSpan(
                                          text: 'Proceed To Pay ₹ ',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w400,
                                          ),
                                          children: <InlineSpan>[
                                            TextSpan(
                                              text:
                                                  '${totalPriceValue.totalPriceProvider}',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                              ),
                            );
                          }));
                    }),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      // height: 100,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  child: Image.asset(
                                    'assets/images/fluent_clipboard-task-list.png',
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Review Order',
                                  style: TextStyle(
                                    // color: Colors.yellow.shade700,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            // width: MediaQuery.of(context).size.width * 1,
                            // padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  child: Image.asset(
                                    'assets/images/gridicons_time.png',
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'If you choose to cancel your oredr , 60 seconds will be granted. \npost 60 second, cancellation fee will be charged',
                                  style: TextStyle(
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            // padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                  height: 25,
                                  child: Image.asset(
                                    'assets/images/la_praying-hands.png',
                                    // fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Help us avoiding food wastage.',
                                  style: TextStyle(
                                    color: Color.fromRGBO(153, 153, 153, 1),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            // padding: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.07,
                                ),
                                TextButton(
                                  onPressed: () {
                                    return;
                                  },
                                  child: Text(
                                    'Read Policy',
                                    style: TextStyle(
                                      color: Color.fromRGBO(247, 193, 43, 1),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                );
        })),
      ),
    );
  }
}
