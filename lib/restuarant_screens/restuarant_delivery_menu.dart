import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodistan/widgets/food_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/auth/autentication.dart';

Future<List> fetchMenu(vendor_id) async {
  List menu_items = [];
  final CollectionReference MenuItemsList = await FirebaseFirestore.instance
      .collection('DummyData')
      .doc(vendor_id)
      .collection('menu-items');
  try {
    await MenuItemsList.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            menu_items.add(element.data());
          })
        });
  } catch (e) {
    print(e.toString());
  }

  return menu_items;
}

class RestuarantDeliveryMenu extends StatefulWidget {
  String vendor_id, vendorName;
  RestuarantDeliveryMenu({required this.vendor_id, required this.vendorName});

  @override
  _RestuarantDeliveryMenuState createState() => _RestuarantDeliveryMenuState();
}

class _RestuarantDeliveryMenuState extends State<RestuarantDeliveryMenu> {
  List menu_items = [];
  String? userNumber;
  String cartId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNumber = AuthMethod().checkUserLogin();
    _asyncMethod(userNumber).then((value) {
      setState(() {
        cartId = value[0];
        menu_items = value[1];
      });
    });
  }

  _asyncMethod(userNumber) async {
    List<dynamic> list = [];
    await CartFunctions().getCartId(userNumber).then((value) {
      list.add(value);
    });
    await fetchMenu(widget.vendor_id).then((value) => {list.add(value)});

    return list;
  }

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.45;

    return Scaffold(
      body: Column(
        children: [
          Container(
              child: (menu_items.isEmpty && cartId == '')
                  ? spinkit
                  : GridView.count(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      children: List.generate(menu_items.length, (index) {
                        return MyFoodItemWidget(
                            menuItem: menu_items[index],
                            vendor_id: widget.vendor_id,
                            cartId: cartId,
                            vendorName: widget.vendorName);
                      }),
                    )),
        ],
      ),
    );
  }
}
