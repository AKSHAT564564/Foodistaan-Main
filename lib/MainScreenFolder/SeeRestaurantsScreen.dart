import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:foodistan/providers/user_location_provider.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class SeeRestaurantsScreen extends StatefulWidget {
  const SeeRestaurantsScreen({Key? key}) : super(key: key);

  @override
  State<SeeRestaurantsScreen> createState() => _SeeRestaurantsScreenState();
}

class _SeeRestaurantsScreenState extends State<SeeRestaurantsScreen> {
  var userLocation;

  @override
  void initState() {
    super.initState();

    //fetching user location from firebase...if exits then rebuilds the Home screen
    // with restaurants sorted according to the user location

    UserLocationProvider().getUserLocation().then((value) {
      setState(() {
        userLocation = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            PreferredSize(
              preferredSize: Size.fromHeight(100.h * 0.085),
              child: SliverAppBar(
                backgroundColor: Colors.white,
                title: const Text(
                  'See Restaurants',
                ),
                elevation: 0,
                titleSpacing: 0,
                leadingWidth: 40,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SliverStickyHeader(
              header: Container(
                padding: EdgeInsets.only(top: 0.8.h, bottom: 0.8.h),
                color: Colors.white,
                child: SeeRestaurantsSearch(),
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index > 0) return null;
                    return Container(
                      padding: EdgeInsets.all(2.5.w),
                      child: SeeCardItem(),
                    );
                  },
                ),
              ),
              // sliver: SliverList(
              //     delegate: SliverChildListDelegate([
              //   Container(
              //       padding: EdgeInsets.all(2.5.w),
              //       child: SeeCardItem(

              //           ))
              // ])),
            ),
          ],
        ),
      ),
    );
  }
}

class SeeCardItem extends StatefulWidget {
  const SeeCardItem({
    Key? key,
  }) : super(key: key);

  @override
  State<SeeCardItem> createState() => _SeeCardItemState();
}

class _SeeCardItemState extends State<SeeCardItem> {
  String vendorName = 'Pizza Junction';
  String vendorID = 'StreetFood1';

  Map<dynamic, dynamic> itemDetail = {
    'id': 'StreetFood1',
    'search': 'pizza junction fast food',
    'name': 'Pizza Junction',
    'address': 'Rohini, Delhi',
    'cuisines': 'Fast Food',
    'stars': '4.7',
    'cost': '300',
    'delivery': true,
    'takeaway': true,
    'foodistaanCertified': true,
    'foodImage':
        'https://i.pinimg.com/originals/e7/71/0a/e7710a3fe5cc3721c1ff630f3f90bd17.jpg'
  };

  // String name = 'Pizza Junction';
  // String address = 'Rohini, Delhi';
  // String cuisines = 'Fast Food';
  // var stars = 4.7;
  // var cost = 300;
  // bool delivery = true;
  // bool takeaway = true;
  // var foodistaanCertified = true;
  // var foodImage =
  //     'https://i.pinimg.com/originals/e7/71/0a/e7710a3fe5cc3721c1ff630f3f90bd17.jpg';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(itemDetail);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RestaurantDelivery(
              // items: itemDetail,
              items: {
                "search": "pizza junction fast food",
                "Address": "Rohini, Delhi",
                "Cuisines": "Fast Food",
                "FoodImage":
                    "https://i.pinimg.com/originals/e7/71/0a/e7710a3fe5cc3721c1ff630f3f90bd17.jpg",
                "Stars": 4,
                "Takeaway": true,
                "Delivery": true,
                "FoodistaanCertified": true,
                "id": "StreetFood1",
                "Cost": 300,
                "Name": "Pizza Junction",
                "Location": GeoPoint(28.7361778, 77.123112),
                "Distance": 0.03456669999999207
              },
              vendor_id: vendorID,
              vendorName: vendorName,
            ),
          ),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              spreadRadius: 7,
              blurRadius: 3,
            ),
          ],
          borderRadius: BorderRadius.circular(11),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Stack(clipBehavior: Clip.none, children: [
                  // Container(
                  //   width: 100.w,
                  //   height: 20.h,
                  //   decoration: BoxDecoration(
                  //     color: Colors.grey.shade300,
                  //     borderRadius: BorderRadius.only(
                  //         topLeft: Radius.circular(11),
                  //         topRight: Radius.circular(11)),
                  //     image: DecorationImage(
                  //       image: NetworkImage(
                  //         itemDetail['foodImage'].toString(),
                  //       ),
                  //       fit: BoxFit.fill,
                  //       alignment: FractionalOffset.center,
                  //     ),
                  //   ),
                  // ),
                  Container(
                    width: 100.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11)),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(11),
                          topRight: Radius.circular(11)),
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl: itemDetail['foodImage'],
                        placeholder: (context, url) =>
                            Image.asset('assets/images/thumbnail (2).png'),
                        errorWidget: (context, url, error) =>
                            Image.asset('assets/images/thumbnail (2).png'),
                      ),
                    ),
                  ),

                  Positioned(
                    top: 1.4.h,
                    left: (-1.3).w,
                    child: Container(
                      width: 18.w,
                      height: 4.5.h,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage('assets/images/Mask Group.png'),
                      )),
                    ),
                  ),
                  Positioned(
                    top: 1.9.h,
                    right: 1.w,
                    child: Container(
                      child: itemDetail['foodistaanCertified'] == true
                          ? Container(
                              height: 2.7.h,
                              width: 21.w,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(
                                    'assets/images/Streato plus tag (2).png'),
                              )),
                            )
                          : SizedBox(),
                    ),
                  ),
                ]),
              ),
              Container(
                padding: EdgeInsets.all(1.5.w),
                width: 90.w,
                margin: EdgeInsets.only(top: 1.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 70.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  itemDetail['name'].length > 20
                                      ? itemDetail['name']
                                              .substring(0, 20)
                                              .trimRight() +
                                          '...'
                                      : itemDetail['name'].trimRight(),
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                    color: kBlackL,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 2.w,
                                ),
                              ],
                            ),
                          ),
                          Container(
                              decoration: BoxDecoration(
                                color: kGreenDark,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              height: 2.5.h,
                              width: 12.w,
                              padding: EdgeInsets.all(0.1.sp),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${itemDetail['stars']}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                        Icon(
                                          Icons.star,
                                          // size: MediaQuery.of(context).size.width * 0.028,
                                          size: 8.5.sp,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )),
                        ]),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(0.5.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey[200],
                          ),
                          child: Text(
                            itemDetail['cuisines'].toString().length > 25
                                ? itemDetail['cuisines']
                                        .toString()
                                        .substring(0, 25) +
                                    '...'
                                : itemDetail['cuisines'],
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 8.5.sp,
                            ),
                          ),
                        ),
                        Container(
                          // padding: EdgeInsets.all(5),
                          child: Text(
                            "₹ ${itemDetail['cost']} for two",
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 8.5.sp,
                            ),
                          ),
                        ),
                      ],
                    )),
                    Divider(
                      height: 10,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 40.w,
                            height: 2.5.h,
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  itemDetail['delivery'] == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: kGrey,
                                              radius: 8.sp,
                                              child: Center(
                                                child: Icon(
                                                  Icons.two_wheeler,
                                                  color: Colors.white,
                                                  size: 8.5.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.w,
                                            ),
                                            Text(
                                              'Delivery',
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 8.5.sp,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 1.5.w,
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                  itemDetail['takeaway'] == true
                                      ? Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: kGrey,
                                              radius: 8.sp,
                                              child: Center(
                                                child: Icon(
                                                  Icons.shopping_bag_outlined,
                                                  color: Colors.white,
                                                  size: 8.5.sp,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 0.5.w,
                                            ),
                                            Text(
                                              'Takeaway',
                                              style: TextStyle(
                                                color: Colors.grey[500],
                                                fontSize: 8.5.sp,
                                              ),
                                            ),
                                          ],
                                        )
                                      : SizedBox(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.place_outlined,
                                  color: Colors.black,
                                  size: 10.sp,
                                ),
                                SizedBox(
                                  width: 0.5.w,
                                ),
                                Container(
                                  child: Text(
                                    itemDetail[' address'].toString().length >
                                            25
                                        ? itemDetail['address']
                                                .toString()
                                                .substring(0, 25) +
                                            '...'
                                        : itemDetail['address'],
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 8.5.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SeeRestaurantsSearch extends StatefulWidget {
  @override
  State<SeeRestaurantsSearch> createState() => _SeeRestaurantsSearchState();
}

class _SeeRestaurantsSearchState extends State<SeeRestaurantsSearch> {
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

    return Consumer<RestaurantListProvider>(builder: (_, value, __) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Container(
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
                child: TextFormField(
                  controller: _searchController,
                  onChanged: (v) async {
                    searchQuery(_searchController.text, value.items);
                    setState(() {});
                  },
                  textAlign: TextAlign.start,
                  obscureText: false,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 8,
                      ),
                      hintText: 'Search your food resturants',
                      hintStyle: TextStyle(
                        color: Colors.grey,
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
                            color: Colors.transparent,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide(
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
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          // child: Image.asset(
          //   'assets/images/icecream.png',
          //   fit: BoxFit.fill,
          // ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              fit: BoxFit.fill,
              imageUrl: data['FoodImage'],
              placeholder: (context, url) =>
                  Image.asset('assets/images/thumbnail (2).png'),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/thumbnail (2).png'),
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
        // controller: _scrollController,
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
                    // controller: _scrollController,
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
