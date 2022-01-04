import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/global/global_variables.dart';
import 'package:foodistan/widgets/change_quantity_widget.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/material.dart';

class CartFunctions {
  final _firestore = FirebaseFirestore.instance;

  createCartFeild(uId, userNumber) async {
    String id = _firestore.collection('cart').doc().id;
    await _firestore
        .collection('cart')
        .doc(id)
        .set({'user-id': uId, 'vendor-id': '', 'vendor-name': ''});

    await _firestore
        .collection('users')
        .doc(userNumber)
        .update({'cart-id': id});
  }

  getCartId(userNumber) async {
    String? cartId;
    await _firestore
        .collection('users')
        .doc(userNumber)
        .get()
        .then((value) => {cartId = value.data()!['cart-id']});
    return cartId;
  }

  checkRestaurant(cartId, vendorId) async {
    print(vendorId);
    String check = '';
    bool toCheck = false;

    await _firestore
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .get()
        .then((value) => {
              if (value.docs.length == 0) {} else {toCheck = true}
            });
    if (toCheck) {
      await _firestore.collection('cart').doc(cartId).get().then((value) => {
            if (value.data()!['vendor-id'] != vendorId)
              {check = value.data()!['vendor-name']}
          });
    }
    return check;
  }

  addItemToCart(vendorId, cartId, menuItem, vendorName) async {
    await _firestore
        .collection('cart')
        .doc(cartId)
        .update({'vendor-id': vendorId, 'vendor-name': vendorName});

    await _firestore
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .doc(menuItem['id'])
        .set({
      'quantity': '1',
      'name': menuItem['title'],
      'veg': menuItem['veg'],
      'price': menuItem['price'],
      'id': menuItem['id']
    });
    return 'Item Added To cart';
  }

  discardCart(vendorId, cartId, menuItem, vendorName) async {
    await _firestore
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .get()
        .then((snapshots) {
      for (var item in snapshots.docs) {
        item.reference.delete();
      }
    }).then((value) => {itemMap.clear()});

    await addItemToCart(vendorId, cartId, menuItem, vendorName);
  }

  Widget quantityWidgetInRestaurant(
      cartId, itemId, vendorId, menuItem, vendorName) {
    final stream = _firestore
        .collection('cart')
        .doc(cartId)
        .collection('items')
        .where('id', isEqualTo: itemId)
        .snapshots();

    return StreamBuilder(
        stream: stream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Text('Waiting');
            default:
              if (snapshot.hasData) {
                if (snapshot.data!.docs.length == 0)
                  return ElevatedButton(
                    child: Text('ADD'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                      onPrimary: Colors.white,
                      shadowColor: Colors.red,
                    ),
                    onPressed: () async {
                      String val = '';
                      await CartFunctions()
                          .checkRestaurant(cartId, vendorId)
                          .then((value) {
                        val = value;
                      });
                      if (val != '') {
                        Alert(
                          context: context,
                          type: AlertType.info,
                          title: "Replace Cart Item",
                          desc:
                              "Your Cart containes dishes from $val. Discard It?",
                          buttons: [
                            DialogButton(
                              child: Text(
                                "Yes",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () async {
                                await discardCart(
                                        vendorId, cartId, menuItem, vendorName)
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              },
                              color: Color.fromRGBO(0, 179, 134, 1.0),
                            ),
                            DialogButton(
                              child: Text(
                                "NO",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () => Navigator.pop(context),
                              gradient: LinearGradient(colors: [
                                Color.fromRGBO(116, 116, 191, 1.0),
                                Color.fromRGBO(52, 138, 199, 1.0)
                              ]),
                            )
                          ],
                        ).show();
                      } else {
                        await CartFunctions()
                            .addItemToCart(
                                vendorId, cartId, menuItem, vendorName)
                            .then((value) {
                          final snackBar = SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(value),
                            action: SnackBarAction(
                              label: '',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );

                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        });
                      }
                    },
                  );
                else {
                  return ListView.builder(
                      itemCount: 1,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data!.docs[index].data();
                        return ChangeQuantityWidget(data: data, cartId: cartId);
                      });
                }
              } else {
                return Text('ADD');
              }
          }
        });
  }

  increaseQuantity(cartId, itemId, quantity, increase) async {
    int _quantity = int.parse(quantity);

    if (increase) {
      _quantity = _quantity + 1;
      await _firestore
          .collection('cart')
          .doc(cartId)
          .collection('items')
          .doc(itemId)
          .update({'quantity': _quantity.toString()});
    } else {
      if (_quantity == 1) {
        await _firestore
            .collection('cart')
            .doc(cartId)
            .collection('items')
            .doc(itemId)
            .delete()
            .then((value) => {itemMap.remove(itemId)});
      } else {
        _quantity = _quantity - 1;
        await _firestore
            .collection('cart')
            .doc(cartId)
            .collection('items')
            .doc(itemId)
            .update({'quantity': _quantity.toString()});
      }
    }
  }

  pricePerItem(price, quantity) {
    return (int.parse(price) * int.parse(quantity)).toString();
  }

  totalPrice(List<DocumentSnapshot> data) {
    int totalPrice = 0;
    int totalQuantity = 0;
    for (var item in data) {
      var price = item.get('price');
      var quantity = item.get('quantity');
      totalQuantity += int.parse(quantity);
      totalPrice += int.parse(pricePerItem(price, quantity));
    }
    totalItemsInCart.value = totalQuantity;
    return totalPrice != 0 ? totalPrice.toString() : '';
  }

  // calculateTotalPrice(cartId) {
  //   var stream = _firestore
  //       .collection('cart')
  //       .doc(cartId)
  //       .collection('items')
  //       .snapshots();
  //   return StreamBuilder(
  //       stream: stream,
  //       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.hasData) {
  //           if (snapshot.data!.docs.length != 0) {
  //             return totalPrice(snapshot.data!.docs);
  //           }
  //         }
  //         return Center(child: Text('CartEmpty'));
  //       });
  // }
}

// class CartFunctions {
//   List price = [{}];
//   addItemToCart(user_number, menu_iten_id, vendor_id, price) async {
//     final _firestore = FirebaseFirestore.instance;
//     final snapShot = await _firestore
//         .collection("users")
//         .doc(user_number)
//         .collection("cart")
//         .doc(vendor_id)
//         .collection('cart-items')
//         .doc(menu_iten_id)
//         .get();

//     if (snapShot.exists) {
//       return 'Cart Item Already Exists';
//     } else {
//       await _firestore
//           .collection('users')
//           .doc(user_number)
//           .collection("cart")
//           .doc(vendor_id)
//           .set({}).whenComplete(() => {
//                 _firestore
//                     .collection('users')
//                     .doc(user_number)
//                     .collection('cart')
//                     .doc(vendor_id)
//                     .collection('cart-items')
//                     .doc(menu_iten_id)
//                     .set({
//                   'menu_item_id': menu_iten_id,
//                   'vendor_id': vendor_id,
//                   'quantity': '1',
//                   'price': price
//                 })
//               });

//       await getSomething(user_number, menu_iten_id, 1, price, vendor_id);

//       return 'Item Added to Cart';
//     }
//   }

//   checkRestaurantInCart(vendorId, userNumber) async {
//     bool check = false;
//     final _firestore = FirebaseFirestore.instance;
//     await _firestore
//         .collection('users')
//         .doc(userNumber)
//         .collection('cart')
//         .get()
//         .then((value) => {

        
//               if (value.size == 1)
//                 {
//                   if (value.docs.first.id == vendorId) {check = true}
//                 }
//             });

//     return check;
//   }

//   Future<DocumentSnapshot> fetchRestaurantsInCart(id) async {
//     late DocumentSnapshot documentSnapshot;

//     await FirebaseFirestore.instance
//         .collection('DummyData')
//         .doc(id)
//         .get()
//         .then((value) {
//       documentSnapshot = value;
//     });

//     return documentSnapshot;
//   }

//   fetchMenuItem(vendor_id, item_id) async {
//     List menu_item = [];

//     var menuItem = await FirebaseFirestore.instance
//         .collection('DummyData')
//         .doc(vendor_id)
//         .collection('menu-items')
//         .where('id', isEqualTo: item_id);

//     try {
//       await menuItem.get().then((querySnapshot) => {
//             querySnapshot.docs.forEach((element) {
//               menu_item.add(element.data());
//             })
//           });
//     } catch (e) {
//       print(e.toString());
//     }

//     return menu_item.isEmpty ? [] : menu_item[0];
//   }

//   changeQuantity(vendor_id, item_id, inc_dec, quantity, user_number) async {
//     final _firestore = FirebaseFirestore.instance;
//     int _quantity = int.parse(quantity.toString());
//     if (inc_dec) {
//       if (_quantity < 5)
//         await _firestore
//             .collection('users')
//             .doc(user_number)
//             .collection('cart')
//             .doc(vendor_id)
//             .collection('cart-items')
//             .doc(item_id)
//             .update({'quantity': _quantity + 1});
//     } else {
//       if (_quantity > 1) {
//         await _firestore
//             .collection('users')
//             .doc(user_number)
//             .collection('cart')
//             .doc(vendor_id)
//             .collection('cart-items')
//             .doc(item_id)
//             .update({'quantity': _quantity - 1});
//       }
//     }
//   }

//   getPrice(base_price, quantity) {
//     int _quantity = int.parse(quantity.toString());
//     int price = int.parse(base_price.toString());

//     int totalPrice = _quantity * price;

//     var cartTotal = [{}];

//     // List<dynamic> list = List.from(documentSnapshpt.data['cart-value']);
//     // // FirebaseFirestore.instance.collection('users').doc('+917860116084').update({
//     // //   'cart-total': FieldValue.arrayUnion(['item'])
//     // // });

//     return totalPrice;
//   }

//   Future<bool> isCartEmpty(userNumber) async {
//     final _firestore = FirebaseFirestore.instance;
//     final snapShot = await _firestore
//         .collection("users")
//         .doc(userNumber)
//         .collection("cart")
//         .doc()
//         .get();

//     if (snapShot.exists)
//       return true;
//     else
//       return false;
//   }

//   getSomething(userNumber, itemId, quantity, price, vendorID) async {
//     String uId = itemId + vendorID;
//     var cartTotal = {};
//     var documentSnapshpt = await FirebaseFirestore.instance
//         .collection('users')
//         .doc(userNumber)
//         .get()
//         .then((value) {
//       cartTotal = value['cart-total-map'];
//     }).then((value) {
//       if (cartTotal.containsKey(uId)) {
//         cartTotal[uId] = getPrice(price, quantity);
//       } else
//         cartTotal[uId] = getPrice(price, quantity);
//     });

//     await FirebaseFirestore.instance
//         .collection('users')
//         .doc(userNumber)
//         .update({'cart-total-map': cartTotal});
//   }
// }
