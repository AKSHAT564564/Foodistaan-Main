import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:foodistan/MainScreenFolder/AppBar/AppBarFile.dart';
import 'package:foodistan/MainScreenFolder/SeeRestaurantsScreen.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:foodistan/providers/user_location_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'Crousel.dart';
import 'CategoryTile.dart';
import 'CuisineTile.dart';
import 'ListingsFile.dart';
import 'package:foodistan/Data/data.dart';
import 'AppBar/LocationPointsSearch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:foodistan/widgets/location_bottam_sheet_widget.dart';
import '../scanner.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

//First Welcome screen 1/4

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin
//AutomaticKeepAliveClientMixin preserves the state of the screen
// and prevents it from reloading every time
{
  bool selectStreetStyle = true;
  bool selectTiffinServices = false;
  var userLocation; //var for user Location

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
    super.build(context);
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: CustomHomeScreen(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
  //set true to preseve the state
}

class CustomHomeScreen extends StatefulWidget {
  const CustomHomeScreen({Key? key}) : super(key: key);

  @override
  _CustomHomeScreenState createState() => _CustomHomeScreenState();
}

class _CustomHomeScreenState extends State<CustomHomeScreen>
    with AutomaticKeepAliveClientMixin
//AutomaticKeepAliveClientMixin preserves the state of the screen
// and prevents it from reloading every time
{
  bool selectStreetStyle = true;
  bool selectTiffinServices = false;
  var userLocation;

  double expandedHeight = 0.5.h;

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;

    return CustomScrollView(
      slivers: <Widget>[
        PreferredSize(
          preferredSize: Size.fromHeight(h1 * 0.085),
          child: SliverAppBar(
            // titleSpacing: 0,
            elevation: 0,
            backgroundColor: Colors.white,
            leadingWidth: 0,
            toolbarHeight: 0, expandedHeight: 10,
            bottom: PreferredSize(
              preferredSize:
                  Size.fromHeight(h1 * 0.085), // here the desired height
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 15,
                      ),
                      child: Container(
                        height: h1 / 25,
                        width: w1,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                flex: 3,
                                child: GestureDetector(
                                  onTap: () async {
                                    //modal bottom sheet for select location option on top left of the mains screen
                                    //basicaly shows a pop-up for selecting user location
                                    showBarModalBottomSheet(
                                        duration: Duration(milliseconds: 300),
                                        bounce: true,
                                        backgroundColor: Colors.black,
                                        context: context,
                                        builder: (context) => Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.7,
                                            child: LocationBottomSheetWidget(
                                              //user is not adding a new address from the cart
                                              //hence will ask user to only select the location
                                              //if set true will ask the user to add address after confirm location screen
                                              isAddingAddress: false,
                                            )));
                                  },
                                  child: Location(), // Top Left Widget
                                )),
                            Expanded(flex: 1, child: Points()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        SliverStickyHeader(
          header: Container(
            padding: EdgeInsets.only(top: 0.8.h, bottom: 0.8.h),
            color: Colors.white,
            child: Search(),
          ),
          sliver: SliverList(
            delegate: SliverChildListDelegate(
              [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 11,
                        left: 11,
                      ),
                      child: Text(
                        'Order by Cuisines',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: h1 / 33,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                CuisineTileList(),
                MinutesDelivery(),
                //search widget moved down here

                //builds the list of all the in the database
                //takes user location as a reuired parameter
                //to sort the rest. Data according to user location

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 8),
                      child: Text(
                        'Restaurants near you',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.5.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Center(
                      child: Listings(
                        userLocation: userLocation,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 33,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class MinutesDelivery extends StatefulWidget {
  const MinutesDelivery({
    Key? key,
  }) : super(key: key);

  @override
  State<MinutesDelivery> createState() => _MinutesDeliveryState();
}

class _MinutesDeliveryState extends State<MinutesDelivery> {
  late bool outOfUserLocation;
  var distance = 19;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    outOfUserLocation = distance >= 20 ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return outOfUserLocation
        ? GestureDetector(
            onTap: (() {
              return;
            }),
            child: Padding(
              padding: EdgeInsets.only(top: 1, left: 11, right: 11, bottom: 11),
              child: Container(
                height: 22.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: kDarkGreen,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(
                    //   width: 1.5.w,
                    // ),
                    Expanded(
                      flex: 7,
                      child: Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(top: 1.5.h, left: 4.5.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Unable to deliver at your location',
                              style: TextStyle(
                                  color: kCreamy,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.5.sp),
                            ),
                            SizedBox(
                              height: 0.6.h,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Change Location',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 8.5.sp),
                                ),
                                Container(
                                    margin: EdgeInsets.only(left: 1.w),
                                    padding: EdgeInsets.all(1.sp),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            width: 1.sp, color: kCreamy)),
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 5.sp,
                                      color: kCreamy,
                                    ))
                              ],
                            ),
                            Spacer(),
                            // Text(
                            //   'Though you can try pickup anytime',
                            //   style:
                            //       TextStyle(color: Colors.white, fontSize: 14.sp),
                            // ),
                            Text.rich(TextSpan(
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                    fontSize: 14.sp),
                                children: [
                                  TextSpan(text: 'Though you can try'),
                                  TextSpan(
                                    text: ' pickup ',
                                    style: TextStyle(
                                        color: kCreamy, fontSize: 14.sp),
                                  ),
                                  TextSpan(text: 'anytime'),
                                ])),
                            SizedBox(
                              height: 1.5.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(
                            bottom: 1.h, top: 2.5.h, right: 4.w),
                        height: 20.h,
                        // height: MediaQuery.of(context).size.height *
                        //     0.061,
                        child: Image.asset(
                          'assets/images/emoji.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Padding(
            padding: EdgeInsets.only(top: 1, left: 11, right: 11, bottom: 11),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SeeRestaurantsScreen()));
              },
              child: Container(
                height: 10.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Color.fromRGBO(67, 73, 101, 1),
                  // gradient: LinearGradient(colors: [
                  //   // Color.fromRGBO(117, 14, 14, 0.2),
                  //   Color.fromRGBO(67, 73, 101, 0.8),
                  //   Color.fromRGBO(67, 73, 101, 1),
                  // ]),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Expanded(flex: 1, child: Container()),

                    SizedBox(
                      width: 1.5.w,
                    ),
                    Expanded(
                      flex: 10,
                      child: Container(
                        // color: Colors.red,
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '12 Minutes Delivery...',
                              style: TextStyle(color: kCreamy, fontSize: 16.sp),
                            ),
                            Text(
                              'See restaurants',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 12.sp),
                            ),
                            SizedBox(
                              height: 1.5.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 5.h,
                                  // height: MediaQuery.of(context).size.height *
                                  //     0.061,
                                  child:
                                      Image.asset('assets/images/logotp.png'),
                                ),
                                Container(
                                  height: 2.h,
                                  // height: MediaQuery.of(context).size.height *
                                  //     0.019,
                                  child: Image.asset('assets/images/+.png'),
                                ),
                              ],
                            ),
                            Text(
                              'Streatoplus',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 7.sp),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 1.5.w,
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
