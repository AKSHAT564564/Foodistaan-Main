import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodistan/functions/razorpay_integration.dart';
import 'package:foodistan/profile/payment_methods.dart';
import 'package:foodistan/profile/your_orders.dart';

class CartScreenMainLogin extends StatefulWidget {
  const CartScreenMainLogin({Key? key}) : super(key: key);

  @override
  _CartScreenMainLoginState createState() => _CartScreenMainLoginState();
}

int totalPriceMain = 0;
Map<String, dynamic> itemMap = {};

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
  }

  // final spinkit = SpinKitFadingCircle(
  //   itemBuilder: (BuildContext context, int index) {
  //     return DecoratedBox(
  //       decoration: BoxDecoration(
  //         color: index.isEven ? Colors.red : Colors.yellow,
  //       ),
  //     );
  //   },
  // );

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
                  Text('You Have Existing Orders',style: TextStyle(
                    color: Colors.black,
                  ),),
                  SizedBox(
                    height: 33,
                  ),
                  OutlinedButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Color(0xFFF7C12B),),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.white,),
                      shape: MaterialStateProperty.all<
                          RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(7),),
                          ),),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Orders()));
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
      // appBar: AppBar(
      //   backgroundColor: Colors.yellow[700],
      //   automaticallyImplyLeading: false,
      //   title: Text('Cart'),
      // ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              cartId != '' ? cartItems(cartId) : Center(
                child: Padding(
                  padding: const EdgeInsets.all(11),
                  child: Text('Loading...',style: TextStyle(
                    color: Colors.black,
                  ),),
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
    });
  }

  getPrice(itemData) {
    int totalPrice = int.parse(CartFunctions().totalPrice(itemData));
    setState(() {
      totalPriceMain = totalPrice;
    });
    return totalPrice.toString();
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
                      style: TextStyle(fontSize: 17.5,
                          fontWeight: FontWeight.w400,),),
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
                              await CartFunctions().increaseQuantity(widget.cartId,
                                  itemData['id'], itemData['quantity'], false);
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
                        Text(itemData['quantity'],style: TextStyle(
                          color: Colors.black,
                        ),),
                        SizedBox(
                          width: 11,
                        ),
                        GestureDetector(
                            onTap: () async {
                              await CartFunctions().increaseQuantity(widget.cartId,
                                  itemData['id'], itemData['quantity'], true);
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
                    Text('₹ ' +
                        CartFunctions()
                            .pricePerItem(itemData['price'], itemData['quantity'],),style: TextStyle(
                      color: Colors.black,
                    ),),
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
                        style: TextStyle(fontWeight: FontWeight.w700,
                                fontSize: 20),),
                      subtitle: Text(restaurantData['Address'],style: TextStyle(
                        color: Colors.black,
                      ),),
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
                    Padding(
                      padding: const EdgeInsets.all(11),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Cart Total - ₹ ',style: TextStyle(
                            color: Colors.black,
                          ),),
                          Text(getPrice(widget.data),style: TextStyle(
                            color: Colors.black,
                          ),),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
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
                                        Text('Apply Coupon',style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context).size.width*0.045,
                                        ),),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Colors.black,
                                        ),
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 15,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RazorPayScreen(
                                    totalPrice: totalPriceMain,
                                    items: itemMap,
                                    cartId: widget.cartId,
                                    vednorId: restaurantData['id'],
                                    vendorName: restaurantData['Name'],
                                  ),),);
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
                              'Proceed To Pay ₹ $totalPriceMain',
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
                ),
              ),
            ),
          );
    } else {
      return CircularProgressIndicator();
    }
  }
}

// class CartScreenMainLogin extends StatefulWidget {
//   static String id = 'cart_screen';

//   @override
//   _CartScreenMainLoginState createState() => _CartScreenMainLoginState();
// }

// class _CartScreenMainLoginState extends State<CartScreenMainLogin> {
//   ScrollController _controller = ScrollController();
//   String user_number = '';

// // FETCHES MULTIPLE RESTAURANTS LIST FROM CART OF A USER

//   Widget cartItems(userNumber) {
//     var cartStream = FirebaseFirestore.instance
//         .collection('users')
//         .doc(userNumber)
//         .collection('cart')
//         .snapshots();
//     return StreamBuilder(
//         stream: cartStream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//             case ConnectionState.waiting:
//               return Center(
//                 child: Text('waiting-1'),
//               );
//             default:
//               if (snapshot.hasData) {
//                 if (snapshot.data!.docs.length == 0)
//                   return Center(
//                     child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, 'H');
//                         },
//                         child: Text('Add Items to Cart')),
//                   );
//                 else {
//                   return ListView.builder(
//                       controller: _controller,
//                       shrinkWrap: true,
//                       scrollDirection: Axis.vertical,
//                       physics: ScrollPhysics(),
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         String id = snapshot.data!.docs[index].id;
//                         return RestaurantInCartWidget(
//                           vendor_id: id,
//                           userNumber: userNumber,
//                         );
//                       });
//                 }
//               } else {
//                 return Center(
//                   child: Text('No Data'),
//                 );
//               }
//           }
//         });
//   }

//   @override
//   void initState() {
//     super.initState();
//     setState(() {
//       user_number = AuthMethod().checkUserLogin();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         centerTitle: false,
//         backgroundColor: Color.fromRGBO(247, 193, 43, 1),
//         title: Text(
//           "Cart",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Container(
//           child: SingleChildScrollView(
//         child: Column(
//           children: [
//             user_number == ''
//                 ? Center(
//                     child: Text('Hello'),
//                   )
//                 : cartItems(user_number),
//             TotalPrice(user_number: user_number)
//           ],
//         ),
//       ) // CALLS THE FUNCTION ON BASIS OF USER LOGIN
//           ),
//     );
//   }
// }

// class RestaurantInCartWidget extends StatefulWidget {
//   String vendor_id;
//   String userNumber;
//   RestaurantInCartWidget({required this.vendor_id, required this.userNumber});

//   @override
//   _RestaurantInCartWidgetState createState() => _RestaurantInCartWidgetState();
// }

// class _RestaurantInCartWidgetState extends State<RestaurantInCartWidget> {
//   @override
//   DocumentSnapshot? items;
//   bool hasData = false;
//   void initState() {
//     super.initState();

//     CartFunctions().fetchRestaurantsInCart(widget.vendor_id).then((value) {
//       setState(() {
//         items = value;
//         hasData = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return hasData
//         ? Container(
//             padding: EdgeInsets.all(10),
//             decoration: BoxDecoration(
//                 border: Border(bottom: BorderSide(color: Colors.grey))),
//             // height: MediaQuery.of(context).size.height * 0.25,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   ListTile(
//                     leading: Image.network(items!['FoodImage']),
//                     title: Text(
//                       items!['Name'],
//                       style:
//                           TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
//                     ),
//                     subtitle: Text(items!['Address']),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(13),
//                     child: CartItemsList(
//                       userNumber: widget.userNumber,
//                       vendor_id: widget.vendor_id,
//                     ),
//                   ),
//                 ],
//               ),
//             ))
//         : CircularProgressIndicator();
//   }
// }

// //Fetches cart items in the particular restaurant

// class CartItemsList extends StatefulWidget {
//   String userNumber;
//   String vendor_id;
//   CartItemsList({required this.userNumber, required this.vendor_id});

//   @override
//   _CartItemsListState createState() => _CartItemsListState();
// }

// class _CartItemsListState extends State<CartItemsList> {
//   Widget cartItems(vendor_id, user_number) {
//     var stream = FirebaseFirestore.instance
//         .collection('users')
//         .doc(user_number)
//         .collection('cart')
//         .doc(vendor_id)
//         .collection('cart-items')
//         .snapshots();

//     return StreamBuilder(
//         stream: stream,
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//             case ConnectionState.waiting:
//               return Center(
//                 child: Text('waiting-1'),
//               );
//             default:
//               if (snapshot.hasData) {
//                 if (snapshot.data!.docs.length == 0) {
//                   return Center(
//                     child: Text('waitng-1'),
//                   );
//                 } else {
//                   return ListView.builder(
//                       shrinkWrap: true,
//                       physics: ScrollPhysics(),
//                       itemCount: snapshot.data!.docs.length,
//                       itemBuilder: (BuildContext context, int index) {
//                         String id = snapshot.data!.docs[index].id;
//                         var qauntity = snapshot.data!.docs[index]['quantity'];

//                         return Center(
//                           child: ItemsInCartWidget(
//                             itemId: id,
//                             vendor_id: vendor_id,
//                             quantity: qauntity,
//                             user_number: user_number,
//                             index: index,
//                           ),
//                         );
//                       });
//                 }
//               } else {
//                 return Center(
//                   child: Text('No-Data'),
//                 );
//               }
//           }
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return cartItems(widget.vendor_id, widget.userNumber);
//   }
// }

// class ItemsInCartWidget extends StatefulWidget {
//   String vendor_id;
//   String itemId;
//   var quantity;
//   String user_number;
//   int index;
//   ItemsInCartWidget(
//       {required this.itemId,
//       required this.vendor_id,
//       required this.quantity,
//       required this.user_number,
//       required this.index});

//   @override
//   _ItemsInCartWidgetState createState() => _ItemsInCartWidgetState();
// }

// class _ItemsInCartWidgetState extends State<ItemsInCartWidget> {
//   Map? menu_item_data;
//   bool hasData = false;

//   @override
//   void initState() {
//     super.initState();

//     CartFunctions()
//         .fetchMenuItem(widget.vendor_id, widget.itemId)
//         .then((value) {
//       setState(() {
//         menu_item_data = value;
//         hasData = true;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return hasData
//         ? Container(
//             height: MediaQuery.of(context).size.height * 0.10,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Container(
//                     // width: MediaQuery.of(context).size.width * 0.6,
//                     child: Row(
//                       children: [
//                         menu_item_data!['veg'] == true
//                             ? Image.asset('assets/images/green_sign.png')
//                             : Image.asset('assets/images/red_sign.png'),
//                         SizedBox(
//                           width: 15,
//                         ),
//                         Text(
//                           menu_item_data!['title'],
//                           style: TextStyle(
//                               fontSize: 18, fontWeight: FontWeight.w400),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     child: Column(
//                       children: [
//                         Row(
//                           children: [
//                             IconButton(
//                               onPressed: () async {
//                                 await CartFunctions().changeQuantity(
//                                     widget.vendor_id,
//                                     widget.itemId,
//                                     false,
//                                     widget.quantity,
//                                     widget.user_number);
//                                 await CartFunctions().getSomething(
//                                     widget.user_number,
//                                     widget.itemId,
//                                     widget.quantity,
//                                     menu_item_data!['price'],
//                                     widget.vendor_id);
//                               },
//                               icon: Icon(
//                                 FontAwesomeIcons.minusCircle,
//                                 color: Colors.amber,
//                                 size: 18,
//                               ),
//                             ),
//                             Text(widget.quantity.toString()),
//                             IconButton(
//                               onPressed: () async {
//                                 await CartFunctions().changeQuantity(
//                                     widget.vendor_id,
//                                     widget.itemId,
//                                     true,
//                                     widget.quantity,
//                                     widget.user_number);

//                                 await CartFunctions().getSomething(
//                                     widget.user_number,
//                                     widget.itemId,
//                                     widget.quantity,
//                                     menu_item_data!['price'],
//                                     widget.vendor_id);
//                               },
//                               icon: Icon(
//                                 FontAwesomeIcons.plusCircle,
//                                 color: Colors.amber,
//                                 size: 18,
//                               ),
//                             ),
//                             Text('Rs. ' +
//                                 CartFunctions()
//                                     .getPrice(menu_item_data!['price'],
//                                         widget.quantity)
//                                     .toString())
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//           )
//         : CircularProgressIndicator();
//   }
// }
