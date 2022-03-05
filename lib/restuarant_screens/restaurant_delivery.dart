import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/providers/user_data_provider.dart';

import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/restuarant_screens/restaurant_overview.dart';
import 'package:foodistan/restuarant_screens/restuarant_delivery_menu.dart';
import 'package:foodistan/restuarant_screens/restaurantDetailScreen.dart';

import 'package:foodistan/widgets/total_bill_bottam_widget.dart';
import 'package:provider/provider.dart';

class RestaurantDelivery extends StatefulWidget {
  static String id = 'restaurant_delivery';
  var items;
  String vendor_id, vendorName;
  RestaurantDelivery(
      {required this.items, required this.vendor_id, required this.vendorName});

  @override
  _RestaurantDeliveryState createState() => _RestaurantDeliveryState();
}

class _RestaurantDeliveryState extends State<RestaurantDelivery> {
  bool isMenuSelected = true;
  bool isReviewSelected = false;
  bool isCartEmpty = true;
  bool isDeliverySelected = false;
  bool isOverviewSelected = false;
  bool isBookMarked = false;

  @override
  void initState() {
    isDeliverySelected = true;
    UserDataProvider().checkBookmark(widget.vendor_id).then((v) {
      if (v == true) {
        print('v is $v');
        setState(() {
          isBookMarked = true;
        });
      }
    });
    super.initState();
    print(widget.items);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(250, 250, 250, 1),
          appBar: PreferredSize(
            preferredSize:
                Size.fromHeight(MediaQuery.of(context).size.height * 0.06),
            child: SizedBox(
              height: 40,
              child: AppBar(
                  elevation: 0,
                  titleSpacing: 0,
                  leadingWidth: 40,
                  backgroundColor: Colors.white,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                        color: kBlackLight),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  title: Text(
                    // "${widget.vendorName.length >= 20 ? widget.vendorName.substring(0, 20).trimRight() + "..." : widget.vendorName}",
                    '${widget.vendorName}',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      // color: Colors.black87,
                      color: kBlackLight,
                    ),
                  ),
                  centerTitle: true,
                  actions: <Widget>[
                    Container(
                        padding: EdgeInsets.all(7.5),
                        child: GestureDetector(
                          onTap: () async {
                            //function for bookmarking the current restaurant
                            //simply adds the vendor id to the bookmarks array in the user data base
                            //and then fetches restaurant id from the bookmarks array
                            //using the vendor id in the bookmarks page
                            if (isBookMarked) return;

                            await UserDataProvider()
                                .addBookmark(widget.vendor_id)
                                .then((v) {
                              setState(() {
                                isBookMarked = true;
                              });
                            });
                          },
                          child: isBookMarked == true
                              ? Icon(
                                  Icons.bookmark_added,
                                  color: kBlackLight,
                                )
                              : Icon(
                                  Icons.bookmark_outline,
                                  color: kBlackLight,
                                ),
                        )),
                    // SizedBox(
                    //   width: 7,
                    // )
                  ]),
            ),
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: RestaurantDetailScreen(
                      restaurant_details: widget.items,
                      vendorId: widget.vendor_id,
                      vendorName: widget.vendorName),
                ),
                // child: Column(
                //   children: [
                // Stack(
                //   children: [
                //     Container(
                //         padding: EdgeInsets.only(left: 0, right: 0, top: 5),
                //         color: Colors.white,
                //         width: MediaQuery.of(context).size.width * 1,
                //         height: MediaQuery.of(context).size.height * 0.35,
                //         child: ClipRRect(
                //           // borderRadius:BorderRadius.circular(15),
                //           borderRadius: BorderRadius.only(
                //               topLeft: Radius.circular(15),
                //               topRight: Radius.circular(15)),
                //           child: Image.network(
                //             '${widget.items['FoodImage']}',
                //             fit: BoxFit.cover,
                //           ),
                //         )),
                //     Container(
                //       padding: EdgeInsets.all(8),
                //       child: Center(
                //         // For testing
                //         child: RestaurantDetailScreen(
                //             restaurant_details: widget.items,
                //             vendorId: widget.vendor_id,
                //             vendorName: widget.vendorName),
                //       ),
                //     )
                //   ],
                // ),

                //   ],
                // ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: TotalBillBottomWidget()),
            ],
          )),
    );
  }
}
