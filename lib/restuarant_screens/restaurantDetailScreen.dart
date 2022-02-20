import 'dart:math';

import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery_review.dart';
import 'package:foodistan/restuarant_screens/restuarant_delivery_menu.dart';
import 'package:foodistan/restuarant_screens/restaurantOverviewCard.dart';
import 'package:foodistan/widgets/options.dart';
import 'package:sizer/sizer.dart';

class RestaurantDetailScreen extends StatefulWidget {
  final restaurant_details;
  final vendorId;
  final vendorName;
  RestaurantDetailScreen(
      {this.restaurant_details, this.vendorId, this.vendorName});

  @override
  _RestaurantDetailScreenState createState() => _RestaurantDetailScreenState();
}

class _RestaurantDetailScreenState extends State<RestaurantDetailScreen> {
  bool isDeliverySelected = false;
  bool isPickupSelected = false;
  bool isOverviewSelected = false;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    isDeliverySelected = true;
  }

  Widget build(BuildContext context) {
    final List<Widget> _childern = [
      DeliverySelectedWidget(
        // isDeliverySelected: false,
        restaurant_detail: widget.restaurant_details,
        vendorId: widget.vendorId,
        vendorName: widget.vendorName,
      ),
      PickupSelectedWidget(
        isPickupSelected: false,
        restaurant_detail: widget.restaurant_details,
        vendorId: widget.vendorId,
        vendorName: widget.vendorName,
      ),
      OverviewSelectedWidget(
        isOverviewSelected: false,
        restaurant_detail: widget.restaurant_details,
        vendorId: widget.vendorId,
        vendorName: widget.vendorName,
      ),
    ];

    return Column(children: [
      Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${widget.restaurant_details['Cuisines']}",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          // color: Colors.black87,
                          color: kBlackLight,
                        ),
                      ),
                      SizedBox(
                        height: 2.5,
                      ),
                      Text(
                        "${widget.restaurant_details['Address']}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.normal,
                            color: Colors.grey),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          return null;
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Container(
                                  decoration: BoxDecoration(
                                    color: kGreenDark,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.only(
                                    left: 6,
                                    right: 6,
                                    top: 2,
                                    bottom: 2,
                                  ),
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${widget.restaurant_details['Stars']}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                            ),
                                            Icon(
                                              Icons.star,
                                              size: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.028,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        // Center(
                                        //   child: Text(
                                        //     "10+ Ratings",
                                        //     style: TextStyle(
                                        //       color: Colors.white,
                                        //       fontSize: MediaQuery.of(context)
                                        //               .size
                                        //               .width *
                                        //           0.022,
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  )),

                              SizedBox(
                                width: 3,
                              ),
                              Container(
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                  // fit: BoxFit.fill,
                                  image: AssetImage(
                                      'assets/images/image-gallery.png'),
                                )),
                                // child: Icon(Icons.photo_library),
                              ),
                              // Container(
                              //   child: Text(
                              //     "know more",
                              //     style: TextStyle(
                              //         fontSize: 10,
                              //         fontWeight: FontWeight.normal,
                              //         color: Colors.grey),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 16,
                  width: 69,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    // fit: BoxFit.fill,
                    image: AssetImage('assets/images/Streato plus tag (2).png'),
                  )),
                ),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.17,
                // ),
                // Container(
                //     decoration: BoxDecoration(
                //       // color: Colors.green,
                //       color: kGreen,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(15),
                //         bottomLeft: Radius.circular(15),
                //       ),
                //     ),
                //     margin: EdgeInsets.only(
                //         // top: MediaQuery.of(context).size.height * 0.022,
                //         // right: MediaQuery.of(context).size.width * 0.014,
                //         ),
                //     height: MediaQuery.of(context).size.height * 0.05,
                //     width: MediaQuery.of(context).size.width * 0.2,
                //     child: Center(
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         crossAxisAlignment: CrossAxisAlignment.center,
                //         children: [
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text(
                //                 "${widget.restaurant_details['Stars']}",
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize:
                //                       MediaQuery.of(context).size.width * 0.044,
                //                 ),
                //               ),
                //               Icon(
                //                 Icons.star,
                //                 size: MediaQuery.of(context).size.width * 0.05,
                //                 color: Colors.white,
                //               ),
                //             ],
                //           ),
                //           Center(
                //             child: Text(
                //               "10+ Ratings",
                //               style: TextStyle(
                //                 color: Colors.white,
                //                 fontSize:
                //                     MediaQuery.of(context).size.width * 0.022,
                //               ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ))
              ],
            ),
            Container(
              margin: EdgeInsets.only(
                top: 8,
                bottom: 8,
                // right: MediaQuery.of(context).size.width * 0.018,
                // left: MediaQuery.of(context).size.width * 0.018,
              ),
              // padding: EdgeInsets.all(8),

              child: Column(children: [
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       // padding: EdgeInsets.all(10),
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //             maxRadius: 10,
                //             backgroundColor: Colors.red,
                //             child: Icon(
                //               Icons.attach_money,
                //               size: 10,
                //               color: Colors.white,
                //             ),
                //           ),
                //           Text(
                //             " Cost for Two ${widget.restaurant_details['Cost']}",
                //             style: TextStyle(color: Colors.grey, fontSize: 8),
                //           )
                //         ],
                //       ),
                //     ),
                //     Spacer(),
                //     Container(
                //       // padding: EdgeInsets.all(10),
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //             maxRadius: 10,
                //             backgroundColor: Color.fromRGBO(140, 200, 255, 1),
                //             child: Icon(
                //               Icons.delivery_dining_rounded,
                //               size: 10,
                //               color: Colors.white,
                //             ),
                //           ),
                //           Text(
                //             " Delivery Available",
                //             style: TextStyle(color: Colors.grey, fontSize: 8),
                //           )
                //         ],
                //       ),
                //     ),
                //     Spacer(),
                //     Container(
                //       // padding: EdgeInsets.all(10),
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //             maxRadius: 10,
                //             backgroundColor: kGreen,
                //             child: Icon(
                //               Icons.table_chart,
                //               size: 10,
                //               color: Colors.white,
                //             ),
                //           ),
                //           Text(
                //             " Seating Available",
                //             style: TextStyle(color: Colors.grey, fontSize: 8),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Container(
                //       // padding: EdgeInsets.all(10),
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //             maxRadius: 10,
                //             backgroundColor: kGreen,
                //             child: Icon(
                //               Icons.attach_money,
                //               size: 10,
                //               color: Colors.white,
                //             ),
                //           ),
                //           Text(
                //             " Sanitisation check",
                //             style: TextStyle(color: Colors.grey, fontSize: 8),
                //           )
                //         ],
                //       ),
                //     ),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     Container(
                //       // padding: EdgeInsets.all(10),
                //       child: Row(
                //         children: [
                //           CircleAvatar(
                //             maxRadius: 10,
                //             backgroundColor: Colors.blue,
                //             child: Icon(
                //               Icons.attach_money,
                //               size: 10,
                //               color: Colors.white,
                //             ),
                //           ),
                //           Text(
                //             " Hygiene check",
                //             style: TextStyle(color: Colors.grey, fontSize: 8),
                //           )
                //         ],
                //       ),
                //     ),
                //   ],
                // )
              ]),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.058,
              // width: MediaQuery.of(context).size.width * 0.92,
              // margin: EdgeInsets.only(left: 5, right: 5),

              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey.shade300,
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(25),
              ),
              // decoration: BoxDecoration(
              //     border: Border.all(color: Colors.grey, width: 1),
              //     borderRadius: BorderRadius.circular(50)),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDeliverySelected = true;
                          isPickupSelected = false;
                          isOverviewSelected = false;
                        });
                        // print(widget.restaurant_details);
                        // print(widget.vendorId);
                        // print(widget.vendorName);
                        onTabTapped(0);
                      },
                      child: Container(
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: isDeliverySelected == true
                                ? Colors.amber[100]
                                : Colors.white,
                            border: isDeliverySelected == true
                                ? Border.all(color: Colors.amber, width: 1)
                                : Border.all(color: Colors.white, width: 1),
                            borderRadius: isDeliverySelected == true
                                ? BorderRadius.circular(25)
                                : BorderRadius.only(
                                    topLeft: Radius.circular(25),
                                    bottomLeft: Radius.circular(25))),
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.two_wheeler,
                                size: MediaQuery.of(context).size.width * 0.035,
                                color: isDeliverySelected == true
                                    ? Colors.black
                                    : Colors.grey),
                            Text(" Delivery",
                                style: isDeliverySelected == true
                                    ? TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035)
                                    : TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.033))
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDeliverySelected = false;
                          isPickupSelected = true;
                          isOverviewSelected = false;
                        });
                        onTabTapped(1);
                      },
                      child: Container(
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: isPickupSelected == true
                                ? Colors.amber[100]
                                : Colors.white,
                            border: isPickupSelected == true
                                ? Border.all(color: Colors.amber, width: 1)
                                : Border.all(color: Colors.white, width: 1),
                            borderRadius: isPickupSelected == true
                                ? BorderRadius.circular(25)
                                : BorderRadius.circular(0)),
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.food_bank,
                                size: MediaQuery.of(context).size.width * 0.035,
                                color: isPickupSelected == true
                                    ? Colors.black
                                    : Colors.grey),
                            widget.restaurant_details["Takeaway"]
                                ? Text(" Pickup",
                                    style: isPickupSelected == true
                                        ? TextStyle(
                                            color: Colors.black,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.035)
                                        : TextStyle(
                                            color: Colors.grey,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.033))
                                : SizedBox()
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDeliverySelected = false;
                          isPickupSelected = false;
                          isOverviewSelected = true;
                        });
                        onTabTapped(2);
                      },
                      child: Container(
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: isOverviewSelected == true
                                ? Colors.amber[100]
                                : Colors.white,
                            border: isOverviewSelected == true
                                ? Border.all(color: Colors.amber, width: 1)
                                : Border.all(color: Colors.white, width: 1),
                            borderRadius: isOverviewSelected == true
                                ? BorderRadius.circular(25)
                                : BorderRadius.only(
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25))),
                        width: MediaQuery.of(context).size.width * 0.27,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.note_add_outlined,
                                size: MediaQuery.of(context).size.width * 0.035,
                                color: isOverviewSelected == true
                                    ? Colors.black
                                    : Colors.grey),
                            Text(" Overview",
                                style: isOverviewSelected == true
                                    ? TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035)
                                    : TextStyle(
                                        color: Colors.grey,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.033))
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   color: Colors.white,
            //   height: MediaQuery.of(context).size.height * 0.073,
            //   margin: EdgeInsets.only(top: 10),
            //   child: ListView(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.all(10),
            //     scrollDirection: Axis.horizontal,
            //     children: [
            //       MyOptionListView(
            //           iconColor: Colors.green,
            //           myIcon: Icons.masks,
            //           myText: "Wearing mask at all time"),
            //       MyOptionListView(
            //           iconColor: Colors.pink,
            //           myIcon: Icons.wash,
            //           myText: "Washing hands at all times"),
            //       MyOptionListView(
            //           iconColor: Colors.red,
            //           myIcon: Icons.thermostat,
            //           myText: "Temperature measured"),
            //       MyOptionListView(
            //           iconColor: Colors.blue,
            //           myIcon: Icons.masks,
            //           myText: "Wearing mask at all time"),
            //       MyOptionListView(
            //           iconColor: Colors.orange,
            //           myIcon: Icons.masks,
            //           myText: "Wearing mask at all time"),
            //     ],
            //   ),
            // ),
            OfferTagsWidget(),
          ],
        ),
      ),
      Container(
        child: _childern[_currentIndex],
      )
    ]);
  }

// Fuction to set _Tab Review
  void onTabTapped(int index) {
    if (!mounted) return;
    setState(() {
      print(index);
      _currentIndex = index;
    });
  }
}

class OfferTagsWidget extends StatefulWidget {
  const OfferTagsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OfferTagsWidget> createState() => _OfferTagsWidgetState();
}

class _OfferTagsWidgetState extends State<OfferTagsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 15,
        // left: 10,
        // right: 10,
      ),
      height: MediaQuery.of(context).size.height * 0.069,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.069,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.069,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        color: kRed,
                      ),
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "OFFER",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 8.5.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.069,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        color: kGreyOf,
                      ),
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "20% OFF UPTO ₹300",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 8.5.sp,
                                color: kBlackO,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "USE MASTERCARD100 | ABOVE ₹100",
                                style: TextStyle(
                                    fontSize: 4.5.sp,
                                    color: kBlackO,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Terms and Condition Applies",
                                style: TextStyle(
                                    fontSize: 4.5.sp,
                                    color: kBlackO,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
          Container(
            // padding: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.4,
            height: MediaQuery.of(context).size.height * 0.069,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.069,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            bottomLeft: Radius.circular(5)),
                        color: kBlue,
                      ),
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          "OFFER",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 8.5.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.069,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5)),
                        color: kGreyOf,
                      ),
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "20% OFF UPTO ₹300",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 8.5.sp,
                                color: kBlackO,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "USE MASTERCARD100 | ABOVE ₹100",
                                style: TextStyle(
                                    fontSize: 4.5.sp,
                                    color: kBlackO,
                                    fontWeight: FontWeight.normal),
                              ),
                              Text(
                                "Terms and Condition Applies",
                                style: TextStyle(
                                    fontSize: 4.5.sp,
                                    color: kBlackO,
                                    fontWeight: FontWeight.normal),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ]),
          ),
        ],
      ),
    );
  }
}

// class OfferTagsWidget extends StatefulWidget {
//   const OfferTagsWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<OfferTagsWidget> createState() => _OfferTagsWidgetState();
// }

// class _OfferTagsWidgetState extends State<OfferTagsWidget>
//     with TickerProviderStateMixin {
//   late AnimationController _controller1;
//   late Animation _animation1;
//   AnimationStatus _status1 = AnimationStatus.dismissed;
//   late AnimationController _controller2;
//   late Animation _animation2;
//   AnimationStatus _status2 = AnimationStatus.dismissed;

//   @override
//   void initState() {
//     super.initState();
//     _controller1 =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));

//     _controller2 =
//         AnimationController(vsync: this, duration: Duration(seconds: 1));
//     _animation1 = Tween(end: 1.0, begin: 0.0).animate(_controller1)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         _status1 = status;
//       });
//     _animation2 = Tween(end: 1.0, begin: 0.0).animate(_controller2)
//       ..addListener(() {
//         setState(() {});
//       })
//       ..addStatusListener((status) {
//         _status2 = status;
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(
//         top: 15,
//         // left: 10,
//         // right: 10,
//       ),
//       height: MediaQuery.of(context).size.height * 0.069,
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Transform(
//             alignment: FractionalOffset.center,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.0015)
//               ..rotateX(pi * _animation1.value),
//             child: GestureDetector(
//               onTap: () {
//                 if (_status1 == AnimationStatus.dismissed) {
//                   _controller1.forward();
//                 } else {
//                   _controller1.reverse();
//                 }
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 height: MediaQuery.of(context).size.height * 0.069,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: _animation1.value <= 0.5
//                     ? Container(
//                         // padding: EdgeInsets.all(5),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(5),
//                                         bottomLeft: Radius.circular(5)),
//                                     color: kRed,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 7, right: 5, top: 5, bottom: 5),
//                                   child: RotatedBox(
//                                     quarterTurns: 3,
//                                     child: Text(
//                                       "OFFER",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize:
//                                             MediaQuery.of(context).size.width *
//                                                 0.027,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 6,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(5),
//                                         bottomRight: Radius.circular(5)),
//                                     color: kGreyOf,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 5, right: 5, top: 5, bottom: 5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "20% OFF \nUPTO ₹300",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.03,
//                                             color: kBlackO,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ]),
//                       )
//                     : Transform(
//                         alignment: FractionalOffset.center,
//                         transform: Matrix4.identity()
//                           ..setEntry(3, 2, 0.0015)
//                           ..rotateX(pi * _animation1.value),
//                         child: Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(5),
//                                         bottomLeft: Radius.circular(5)),
//                                     color: kRed,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 7, right: 5, top: 5, bottom: 5),
//                                   child: RotatedBox(
//                                     quarterTurns: 3,
//                                     child: Text(
//                                       "OFFER",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize:
//                                             MediaQuery.of(context).size.width *
//                                                 0.027,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 6,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(5),
//                                         bottomRight: Radius.circular(5)),
//                                     color: kGreyOf,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 5, right: 5, top: 5, bottom: 5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "USE MASTERCARD100 | ABOVE ₹100",
//                                         style: TextStyle(
//                                             fontSize: 6,
//                                             color: kBlackO,
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                       Text(
//                                         "Terms and Condition Applies",
//                                         style: TextStyle(
//                                             fontSize: 6,
//                                             color: kBlackO,
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//           ),
//           Transform(
//             alignment: FractionalOffset.center,
//             transform: Matrix4.identity()
//               ..setEntry(3, 2, 0.0015)
//               ..rotateX(pi * _animation2.value),
//             child: GestureDetector(
//               onTap: () {
//                 if (_status2 == AnimationStatus.dismissed) {
//                   _controller2.forward();
//                 } else {
//                   _controller2.reverse();
//                 }
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: _animation2.value <= 0.5
//                     ? Container(
//                         // padding: EdgeInsets.all(5),
//                         child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(5),
//                                         bottomLeft: Radius.circular(5)),
//                                     color: kBlue,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 7, right: 5, top: 5, bottom: 5),
//                                   child: RotatedBox(
//                                     quarterTurns: 3,
//                                     child: Text(
//                                       "OFFER",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize:
//                                             MediaQuery.of(context).size.width *
//                                                 0.027,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 6,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(5),
//                                         bottomRight: Radius.circular(5)),
//                                     color: kGreyOf,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 5, right: 5, top: 5, bottom: 5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "20% OFF \nUPTO ₹300",
//                                         textAlign: TextAlign.center,
//                                         style: TextStyle(
//                                             fontSize: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.03,
//                                             color: kBlackO,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ]),
//                       )
//                     : Transform(
//                         alignment: FractionalOffset.center,
//                         transform: Matrix4.identity()
//                           ..setEntry(3, 2, 0.0015)
//                           ..rotateX(pi * _animation2.value),
//                         child: Container(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topLeft: Radius.circular(5),
//                                         bottomLeft: Radius.circular(5)),
//                                     color: kBlue,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 7, right: 5, top: 5, bottom: 5),
//                                   child: RotatedBox(
//                                     quarterTurns: 3,
//                                     child: Text(
//                                       "OFFER",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontWeight: FontWeight.bold,
//                                         fontSize:
//                                             MediaQuery.of(context).size.width *
//                                                 0.027,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 6,
//                                 child: Container(
//                                   height: MediaQuery.of(context).size.height *
//                                       0.069,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.only(
//                                         topRight: Radius.circular(5),
//                                         bottomRight: Radius.circular(5)),
//                                     color: kGreyOf,
//                                   ),
//                                   padding: EdgeInsets.only(
//                                       left: 5, right: 5, top: 5, bottom: 5),
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.center,
//                                     children: [
//                                       Text(
//                                         "USE MASTERCARD100 | ABOVE ₹100",
//                                         style: TextStyle(
//                                             fontSize: 6,
//                                             color: kBlackO,
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                       Text(
//                                         "Terms and Condition Applies",
//                                         style: TextStyle(
//                                             fontSize: 6,
//                                             color: kBlackO,
//                                             fontWeight: FontWeight.normal),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class DeliverySelectedWidget extends StatefulWidget {
  final restaurant_detail;
  final vendorId;
  final vendorName;
  DeliverySelectedWidget(
      {Key? key,
      required this.restaurant_detail,
      required this.vendorId,
      required this.vendorName})
      : super(key: key);

  @override
  State<DeliverySelectedWidget> createState() => _DeliverySelectedWidgetState();
}

class _DeliverySelectedWidgetState extends State<DeliverySelectedWidget> {
  var isMenuSelected = true;
  var isReviewSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          // Container(
          //   // padding: EdgeInsets.symmetric(horizontal: 6.6),
          //   margin: EdgeInsets.only(top: 20),
          //   height: MediaQuery.of(context).size.height * 0.058,
          //   child: TextFormField(
          //       textAlignVertical: TextAlignVertical.bottom,
          //       decoration: InputDecoration(
          //           prefixIcon: Padding(
          //             padding: EdgeInsets.all(7.5),
          //             child: Icon(Icons.search),
          //           ),
          //           hintText: "Search within the menu",
          //           focusedBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(8),
          //               borderSide: BorderSide(
          //                 color: Colors.amber,
          //                 width: 2.0,
          //               )),
          //           enabledBorder: OutlineInputBorder(
          //               borderRadius: BorderRadius.circular(8),
          //               borderSide: BorderSide(
          //                 color: Colors.amber,
          //                 width: 2.0,
          //               )))),
          // ),
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.57,
              // width: MediaQuery.of(context).size.width * 0.9,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //   left: MediaQuery.of(context).size.width * 0.014,
                      // ),

                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.032,
                            // ),
                            GestureDetector(
                              onTap: () {
                                print("Menu selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Menu",
                                style: isMenuSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Reviews selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Reviews",
                                style: isReviewSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.32,
                            ),
                            // GestureDetector(
                            //   child: Row(
                            //     children: [
                            //       Text("Search"),
                            //       Icon(Icons.search),
                            //     ],
                            //   ),
                            // )
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: MediaQuery.of(context).size.height * 0.65,
                      // width: MediaQuery.of(context).size.width * 0.9,
                      child: isReviewSelected
                          ? Center(child: RestuarantDeliveryReview())
                          : Center(
                              child: RestuarantDeliveryMenu(
                                  vendor_id: widget.vendorId,
                                  vendorName: widget.vendorName),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PickupSelectedWidget extends StatefulWidget {
  final bool isPickupSelected;

  final restaurant_detail;
  final vendorName;
  final vendorId;

  PickupSelectedWidget({
    Key? key,
    required this.isPickupSelected,
    required this.restaurant_detail,
    required this.vendorId,
    required this.vendorName,
  }) : super(key: key);
  @override
  State<PickupSelectedWidget> createState() => _PickupSelectedWidgetState();
}

class _PickupSelectedWidgetState extends State<PickupSelectedWidget> {
  var isMenuSelected = true;
  var isReviewSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      // padding: EdgeInsets.only(left: 5, right: 5),
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Center(
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.57,
              // width: MediaQuery.of(context).size.width * 1,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      // margin: EdgeInsets.only(
                      //   left: MediaQuery.of(context).size.width * 0.014,
                      // ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.018,
                            // ),
                            GestureDetector(
                              onTap: () {
                                print("Menu selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Menu",
                                style: isMenuSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.04,
                            ),
                            GestureDetector(
                              onTap: () {
                                print("Reviews selected");
                                setState(() {
                                  isReviewSelected = !isReviewSelected;
                                  isMenuSelected = !isMenuSelected;
                                });
                              },
                              child: Text(
                                "Reviews",
                                style: isReviewSelected == true
                                    ? TextStyle(
                                        fontSize: 16,
                                        color: Colors.amber,
                                        fontWeight: FontWeight.w700,
                                      )
                                    : TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey,
                                      ),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 15),
                      height: MediaQuery.of(context).size.height * 0.65,
                      child: isReviewSelected
                          ? Center(child: RestuarantDeliveryReview())
                          : Center(
                              child: RestuarantDeliveryMenu(
                                  vendor_id: widget.vendorId,
                                  vendorName: widget.vendorName),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OverviewSelectedWidget extends StatefulWidget {
  final bool isOverviewSelected;
  final restaurant_detail;
  final vendorId;
  final vendorName;
  OverviewSelectedWidget({
    Key? key,
    required this.isOverviewSelected,
    required this.restaurant_detail,
    required this.vendorId,
    required this.vendorName,
  }) : super(key: key);

  @override
  State<OverviewSelectedWidget> createState() => _OverviewSelectedWidgetState();
}

class _OverviewSelectedWidgetState extends State<OverviewSelectedWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 1.5,
      child: RestaurantOverviewCard(),
      // RestaurantOverview(),
    );
  }
}
