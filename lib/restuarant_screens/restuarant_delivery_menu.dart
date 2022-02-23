import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:foodistan/widgets/food_item_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodistan/functions/cart_functions.dart';
import 'package:foodistan/auth/autentication.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Future<List> fetchMenu(vendor_id) async {
  List menuItems = [];
  final CollectionReference MenuItemsList = await FirebaseFirestore.instance
      .collection('DummyData')
      .doc(vendor_id)
      .collection('menu-items');
  try {
    await MenuItemsList.get().then((querySnapshot) => {
          querySnapshot.docs.forEach((element) {
            menuItems.add(element.data());
          })
        });
  } catch (e) {
    print(e.toString());
  }

  return menuItems;
}

class RestuarantDeliveryMenu extends StatefulWidget {
  String vendor_id, vendorName;
  RestuarantDeliveryMenu({required this.vendor_id, required this.vendorName});

  @override
  _RestuarantDeliveryMenuState createState() => _RestuarantDeliveryMenuState();
}

class _RestuarantDeliveryMenuState extends State<RestuarantDeliveryMenu> {
  List menuItems = [];
  String? userNumber;
  String cartId = '';

  @override
  void initState() {
    super.initState();
    userNumber = AuthMethod().checkUserLogin();
    _asyncMethod(userNumber).then((value) {
      setState(() {
        cartId = value[0];
        menuItems = value[1];
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
          color: index.isEven ? Colors.red : kGreen,
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
          SearchMenu(),
          SizedBox(
            height: 3.h,
          ),
          Container(
              child: (menuItems.isEmpty && cartId == '')
                  // ? spinkit
                  ? Center(
                      child: CircularProgressIndicator(
                        color: kYellow,
                      ),
                    )
                  : GridView.count(
                      padding: EdgeInsets.zero,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisSpacing: 5,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      children: List.generate(menuItems.length, (index) {
                        return MyFoodItemWidget(
                            menuItem: menuItems[index],
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

final _scrollController = ScrollController();

class SearchMenu extends StatefulWidget {
  @override
  State<SearchMenu> createState() => _SearchMenuState();
}

class _SearchMenuState extends State<SearchMenu> {
  final _searchController = TextEditingController();

  ValueNotifier<List> searchResults = ValueNotifier([]);

  searchQuery(String query, List items) {
    List searchResultsTemp = [];
    for (var item in items) {
      RegExp regExp = new RegExp(query, caseSensitive: false);
      bool containe = regExp.hasMatch(item['search']);
      if (containe) {
        searchResultsTemp.add(item);
      }
    }
    searchResults.value = searchResultsTemp;
  }

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    var itemWidth = MediaQuery.of(context).size.width * 0.4;
    var itemHeight = MediaQuery.of(context).size.height * 0.45;
    return Consumer<RestaurantListProvider>(builder: (_, value, __) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.white60,
              ),
              height: h1 * 0.055,
              width: w1 * 1,
              child: TextFormField(
                controller: _searchController,
                onChanged: (v) async {
                  searchQuery(_searchController.text, value.items);
                  setState(() {}); //for cross icon in searchbar
                },
                textAlign: TextAlign.start,
                obscureText: false,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 8,
                    ),
                    hintText: 'Search your craving',
                    hintStyle: TextStyle(
                      color: kGreyDark,
                      fontSize: 15,
                    ),
                    suffixIcon: Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 1.5,
                          bottom: 1.5,
                          left: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Color(0xFFFAB84C),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.search,
                          // size: 22,
                          // color: kGrey,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          // color: Color(0xFFFAB84C),
                          color: Colors.transparent,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide(
                        // color: Color(0xFFFAB84C),
                        color: Colors.transparent,
                        width: 1,
                      ),
                    )),
              ),
            ),
            ValueListenableBuilder<List>(
                valueListenable: searchResults,
                builder: (_, value, __) {
                  return value.isNotEmpty && _searchController.text.isNotEmpty
                      ? SearchMenuItemList(
                          searchResults: value,
                        )
                      : Container();
                })
          ],
        ),
      );
    });
  }
}

class SearchMenuItemList extends StatefulWidget {
  const SearchMenuItemList({Key? key, required searchResults})
      : super(key: key);

  @override
  _SearchMenuItemListState createState() => _SearchMenuItemListState();
}

class _SearchMenuItemListState extends State<SearchMenuItemList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
    );
  }
}
