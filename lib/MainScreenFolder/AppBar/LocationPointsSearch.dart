import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/AppBar/points.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/address_from_placeId_model.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:foodistan/providers/user_location_provider.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:provider/provider.dart';

class Location extends StatefulWidget {
  @override
  State<Location> createState() => _LocationState();
}

class _LocationState extends State<Location> {
  AddressModel? userAddress;
  bool hasAddress = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<UserLocationProvider>().getUserLocation();

    var h1 = MediaQuery.of(context).size.height;
    return FittedBox(
      alignment: Alignment.bottomLeft,
      fit: BoxFit.contain,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.location_on,
            color: Color(0xFFFAB84C),
            size: h1 * 0.055,
          ),
          SizedBox(
            width: 11,
          ),
          Consumer<UserLocationProvider>(
              builder: (context, userLocationValue, userLocationWidget) {
            return userLocationValue.hasUserLocation == true &&
                    userLocationValue.userLocationIsNull == false
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userLocationValue.userAddress!.name!,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: h1 * 0.033,
                        ),
                      ),
                      Text(
                        userLocationValue.userAddress!.subLocality!,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: h1 * 0.03,
                        ),
                      )
                    ],
                  )
                : Text(
                    'Select Location',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  );
          }),
        ],
      ),
    );
  }
}

class Points extends StatefulWidget {
  @override
  _PointsState createState() => _PointsState();
}

class _PointsState extends State<Points> {
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    // var w1 = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => FsPoints()));
      },
      child: FittedBox(
        alignment: Alignment.bottomRight,
        fit: BoxFit.contain,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/token 1.png',
                ),
                Text(
                  '0',
                  style: TextStyle(
                    color: Color(0xFFFAB84C),
                    fontSize: h1 * 0.033,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

final _scrollController = ScrollController();

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
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
    // var w1 = MediaQuery.of(context).size.width;
    return Consumer<RestaurantListProvider>(builder: (_, value, __) {
      return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              // padding: EdgeInsets.symmetric(
              //   horizontal: 12,
              // ),
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      // color: Colors.transparent,
                      // spreadRadius: 10,
                      blurRadius: 5,
                      offset: Offset(0, 5),
                    ),
                  ],
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  color: Colors.white60,
                ),
                height: h1 * 0.055,
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (v) async {
                    searchQuery(_searchController.text, value.items);
                    setState(() {});
                    //for cross icon in searchbar
                  },
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 8,
                      ),
                      // hintText: 'Search Cuisines',
                      hintText: 'Search your favourite food',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                      // suffixIcon: IconButton(
                      //     alignment: Alignment.center,
                      //     onPressed: () {
                      //       _searchController.text = '';
                      //       searchResults.value = [];
                      //       setState(() {}); //for cross icon in searchbar
                      //     },
                      // icon: Icon(
                      //   Icons.clear_rounded,
                      //   color: _searchController.text.isNotEmpty
                      //       ? Colors.grey
                      //       : Colors.transparent,
                      // )),
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
                          child: _searchController.text.isNotEmpty
                              ? InkWell(
                                  child: Icon(
                                    Icons.clear_rounded,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    _searchController.text = '';
                                    searchResults.value = [];
                                    setState(
                                        () {}); //for cross icon in searchbar
                                  },
                                )
                              : Icon(
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
            ),
            //Value notifier is used to avoid set state method
            //it automaticaly detects changes in any of the values
            //and acts accordingly
            //here we are listening to searchResults which is a list
            ValueListenableBuilder<List>(
                valueListenable: searchResults,
                builder: (_, value, __) {
                  return value.isNotEmpty && _searchController.text.isNotEmpty
                      ? SearchItemList(
                          searchResults: value,
                        )
                      : Container();
                })
            // _searchController.text.isNotEmpty ? SearchItemList() : Container(),
          ],
        ),
      );
    });
  }
}

class SearchItemList extends StatefulWidget {
  List searchResults;
  SearchItemList({required this.searchResults, Key? key}) : super(key: key);

  @override
  _SearchItemListState createState() => _SearchItemListState();
}

class _SearchItemListState extends State<SearchItemList> {
  String isSelected = 'DELIVERY';

  Widget searchItemWidget(data, index) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      width: double.maxFinite,
      child: ListTile(
        contentPadding: EdgeInsets.all(2),
        // minVerticalPadding: 2,
        // tileColor: Colors.white,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              data['FoodImage'],
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              data['Name'],
              style: TextStyle(
                fontSize: 14,
                // color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              data['Cuisines'],
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey.shade700,
                // fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15),
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            // Container(
            //   margin: EdgeInsets.only(
            //     top: MediaQuery.of(context).size.width * 0.08,
            //   ),
            //   height: MediaQuery.of(context).size.height * 0.06,
            //   // color: Colors.grey.shade300,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.all(Radius.circular(8)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.shade200,
            //         // color: Colors.red,
            //         // blurRadius: 6.0,
            //       ),
            //     ],
            //     color: Colors.transparent,
            //   ),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       // GestureDetector(
            //       //   onTap: () {
            //       //     setState(() {
            //       //       isSelected = 'DELIVERY';
            //       //       print(isSelected);
            //       //     });
            //       //   },
            //       //   child: Container(
            //       //     // height: MediaQuery.of(context).size.height * 0.005,
            //       //     width: MediaQuery.of(context).size.width * 0.45,
            //       //     alignment: Alignment.center,
            //       //     // margin: EdgeInsets.only(left: 3, right: 3),
            //       //     // padding: EdgeInsets.all(8.0),
            //       //     decoration: BoxDecoration(
            //       //       borderRadius: BorderRadius.all(Radius.circular(8)),
            //       //       boxShadow: [
            //       //         BoxShadow(
            //       //           color: isSelected == 'DELIVERY'
            //       //               ? Colors.grey
            //       //               : Colors.grey.shade200,
            //       //           // blurRadius: 6.0,
            //       //         ),
            //       //       ],
            //       //       color: isSelected == 'DELIVERY'
            //       //           ? Colors.black
            //       //           : Colors.transparent,
            //       //     ),
            //       //     child: Text(
            //       //       'DELIVERY',
            //       //       textAlign: TextAlign.center,
            //       //       style: TextStyle(
            //       //         fontSize: 12,
            //       //         color: isSelected == 'DELIVERY'
            //       //             ? Colors.white
            //       //             : Colors.grey.shade700,
            //       //         fontWeight: FontWeight.bold,
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //       // GestureDetector(
            //       //   onTap: () {
            //       //     setState(() {
            //       //       isSelected = 'DINING';
            //       //       print(isSelected);
            //       //     });
            //       //   },
            //       //   child: Container(
            //       //     // height: MediaQuery.of(context).size.height * 0.005,
            //       //     width: MediaQuery.of(context).size.width * 0.45,
            //       //     alignment: Alignment.center,
            //       //     // margin: EdgeInsets.only(left: 3, right: 3),
            //       //     // padding: EdgeInsets.all(8.0),
            //       //     decoration: BoxDecoration(
            //       //       borderRadius: BorderRadius.all(Radius.circular(8)),
            //       //       boxShadow: [
            //       //         BoxShadow(
            //       //           color: isSelected == 'DINING'
            //       //               ? Colors.grey
            //       //               : Colors.grey.shade200,
            //       //           // blurRadius: 6.0,
            //       //         ),
            //       //       ],
            //       //       color: isSelected == 'DINING'
            //       //           ? Colors.black
            //       //           : Colors.transparent,
            //       //     ),
            //       //     child: Text(
            //       //       'DINING',
            //       //       textAlign: TextAlign.center,
            //       //       style: TextStyle(
            //       //         fontSize: 12,
            //       //         color: isSelected == 'DINING'
            //       //             ? Colors.white
            //       //             : Colors.grey.shade700,
            //       //         fontWeight: FontWeight.bold,
            //       //       ),
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
            Container(
                height: 400,
                margin: EdgeInsets.only(top: 10),
                color: Colors.white,
                child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: widget.searchResults.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RestaurantDelivery(
                                      items: widget.searchResults[index],
                                      vendor_id: widget.searchResults[index]
                                          ['id'],
                                      vendorName: widget.searchResults[index]
                                          ['Name'])));
                        },
                        child: searchItemWidget(
                            widget.searchResults[index], index),
                      );
                    })),
          ],
        ),
      ),
    );
  }
}
