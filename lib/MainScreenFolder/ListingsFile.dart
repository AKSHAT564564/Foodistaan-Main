import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

//Lists all restaurants in the database and sorts them according to the user
//location

//Restaurant List Provider provides all the data

// List items = [];
// List sortItems = [];
// List vendor_id_list = [];

// fetchData(String category) async {
//   final CollectionReference StreetFoodList =
//       FirebaseFirestore.instance.collection(category);
//   try {
//     items = [];
//     sortItems = [];
//     await StreetFoodList.get().then((querySnapshot) => {
//           querySnapshot.docs.forEach((element) {
//             items.add(element.data());
//             vendor_id_list.add(element.id);
//           })
//         });
//     if (global.currentLocation == null) {
//       for (int i = 0; i < items.length; i++) {
//         sortItems.add(items[i]);
//         sortItems[i]['Distance'] = (items[i]['Location'].latitude - 0).abs() +
//             (items[i]['Location'].longitude - 0).abs();
//       }
//       sortItems.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
//     } else {
//       for (int i = 0; i < items.length; i++) {
//         sortItems.add(items[i]);
//         sortItems[i]['Distance'] = (items[i]['Location'].latitude -
//                     global.currentLocation!.latitude)
//                 .abs() +
//             (items[i]['Location'].longitude - global.currentLocation!.longitude)
//                 .abs();
//       }
//       sortItems.sort((a, b) => a["Distance"].compareTo(b["Distance"]));
//     }
//   } catch (e) {
//     print(e.toString());
//   }
//   return sortItems;
// }

class Listings extends StatefulWidget {
  var userLocation;

  Listings({this.userLocation});

  @override
  _ListingsState createState() => _ListingsState();
}

class _ListingsState extends State<Listings> {
  @override
  void initState() {
    super.initState();

    //calling RestaurntListProvider fetchData functions
    //to fetch all the restaurants in the database
    //and sorting them according to the user location
    Provider.of<RestaurantListProvider>(context, listen: false)
        .fetchData('DummyData', widget.userLocation);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantListProvider>(builder:
        (restaurantDatacontext, restaurantListValue, restaurantListWidget) {
      return restaurantListValue.hasData
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: restaurantListValue.items.length,
              itemBuilder: (restaurantDatacontext, index) {
                return Padding(
                  // padding: EdgeInsets.all(11),
                  padding: EdgeInsets.all(1.7.h),
                  child: ListedTile(
                    details: restaurantListValue.items[index],
                    Id: restaurantListValue.items[index]['id'],
                  ),
                );
              },
            )
          : CircularProgressIndicator(
              color: Colors.yellow.shade700,
            );
    });
  }
}

class ListedTile extends StatefulWidget {
  var details;
  var Id;
  ListedTile({this.details, this.Id});
  @override
  _ListedTileState createState() =>
      _ListedTileState(StreetFoodDetails: details, Vendor_ID: Id);
}

class _ListedTileState extends State<ListedTile> {
  var StreetFoodDetails;
  var Vendor_ID;
  _ListedTileState({this.StreetFoodDetails, this.Vendor_ID});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RestaurantDelivery(
                      items: StreetFoodDetails,
                      vendor_id: Vendor_ID,
                      vendorName: StreetFoodDetails['Name'],
                    )));
      },
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.5,
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
              LeftSide(
                foodImage: StreetFoodDetails['FoodImage'],
              ),
              // SizedBox(
              //   height: 0.1.h,
              // ),
              RightSide(
                name: StreetFoodDetails['Name'],
                address: StreetFoodDetails['Address'],
                cuisines: StreetFoodDetails['Cuisines'],
                stars: StreetFoodDetails['Stars'],
                cost: StreetFoodDetails['Cost'],
                delivery: StreetFoodDetails['Delivery'],
                takeaway: StreetFoodDetails['Takeaway'],
                foodistaanCertified: StreetFoodDetails['FoodistaanCertified'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LeftSide extends StatelessWidget {
  String foodImage;
  var foodistaanCertified;
  // String address;
  LeftSide({this.foodImage = 'NA', this.foodistaanCertified = true});
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          // width: w1 * 1,
          // height: h1 * 0.2,
          width: 100.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11), topRight: Radius.circular(11)),
            image: DecorationImage(
              image: NetworkImage(
                foodImage,
              ),
              fit: BoxFit.fill,
              alignment: FractionalOffset.center,
            ),
          ),
        ),
        Positioned(
          // top: MediaQuery.of(context).size.height * 0.017,
          // left: MediaQuery.of(context).size.width * (-0.045),
          top: 1.4.h,
          left: (-1.3).w,
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.034,
            // width: MediaQuery.of(context).size.width * 0.22,
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
          top: 1.8.h,
          right: 1.w,
          child: Container(
            child: foodistaanCertified == true
                ? Container(
                    height: 3.h,
                    width: 21.w,
                    // height: 16,
                    // width: 69,
                    // height: 2.5.h,
                    // width: 16.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      fit: BoxFit.fill,
                      image:
                          AssetImage('assets/images/Streato plus tag (2).png'),
                    )),
                  )
                : SizedBox(),
          ),
        ),
      ]),
    );
  }
}

class RightSide extends StatelessWidget {
  String name;
  String address;
  String cuisines;
  var stars;
  var cost;
  bool delivery;
  bool takeaway;
  var foodistaanCertified;

  RightSide(
      {this.name = 'NA',
      this.address = 'NA',
      this.cuisines = 'NA',
      this.stars = 4,
      this.cost = 100,
      this.delivery = false,
      this.takeaway = false,
      this.foodistaanCertified = false});
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(1.5.w),
      // width: w1 * 0.9,
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
                  // width: w1 * 0.70,
                  width: 70.w,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        name.length > 20
                            ? name.substring(0, 20).trimRight() + '...'
                            : name.trimRight(),
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
                      // Container(
                      //   child: foodistaanCertified == true
                      //       ? Container(
                      //           // height: 16,
                      //           // width: 69,
                      //           height: 2.5.h,
                      //           width: 16.w,
                      //           decoration: BoxDecoration(
                      //               image: DecorationImage(
                      //             fit: BoxFit.fill,
                      //             image: AssetImage(
                      //                 'assets/images/Streato plus tag (2).png'),
                      //           )),
                      //         )
                      //       : SizedBox(),
                      // ),
                    ],
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      color: kGreenDark,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    // padding: EdgeInsets.only(
                    //   left: 6,
                    //   right: 6,
                    //   top: 2,
                    //   bottom: 2,
                    // ),
                    height: 2.5.h,
                    width: 12.w,
                    padding: EdgeInsets.all(0.1.sp),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "4.7",
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
                  cuisines.length > 25
                      ? cuisines.substring(0, 25) + '...'
                      : cuisines,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 8.5.sp,
                  ),
                ),
              ),
              Container(
                // padding: EdgeInsets.all(5),
                child: Text(
                  '₹ $cost for two',
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
                  // width: w1 * 0.4,
                  width: 40.w,
                  height: 2.5.h,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        delivery == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                        takeaway == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                          address.length > 25
                              ? address.substring(0, 25) + '...'
                              : address,
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

          SizedBox(
            height: 0.5.h,
          ),
          // foodistaanCertified == true
          //     ? Row(
          //         mainAxisAlignment: MainAxisAlignment.start,
          //         crossAxisAlignment: CrossAxisAlignment.center,
          //         children: [
          //           Image.asset(
          //             'Images/fs_certified.png',
          //             width: 20,
          //           ),
          //           SizedBox(
          //             width: 5,
          //           ),
          //           Text(
          //             'Foodistaan Certified',
          //             style: TextStyle(
          //               color: Theme.of(context).primaryColor,
          //               fontSize: 10,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ],
          //       )
          //     : SizedBox(),
          // Container(
          //   height: 10 * h1 / 62,
          //   width: w1 / 3,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(11),
          //     ),
          //     color: Colors.white,
          //   ),
          //   child: Padding(
          //     padding: EdgeInsets.fromLTRB(w1 / 50, h1 / 200, w1 / 50, h1 / 200),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         FittedBox(
          //             fit: BoxFit.contain,
          //             child: Text(
          //               name,
          //               style: TextStyle(
          //                 color: Colors.black,
          //                 fontWeight: FontWeight.bold,
          //               ),
          //             )),
          //         FittedBox(
          //             fit: BoxFit.contain,
          //             child: Text(
          //               cuisines,
          //               style: TextStyle(
          //                   color: Colors.grey,
          //                   fontWeight: FontWeight.w500,
          //                   fontSize: h1 / 65),
          //             )),
          //         FittedBox(
          //           fit: BoxFit.contain,
          //           child: Row(
          //               mainAxisAlignment: MainAxisAlignment.start,
          //               children: List.generate(stars, (index) {
          //                 return Image.asset(
          //                   'Images/RatingStar.png',
          //                   height: h1 / 35,
          //                   width: w1 / 35,
          //                 );
          //               })),
          //         ),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.start,
          //           children: [
          //             Image.asset(
          //               "Images/RupeeImage.png",
          //               height: h1 / 50,
          //             ),
          //             SizedBox(
          //               width: w1 / 100,
          //             ),
          //             FittedBox(
          //               fit: BoxFit.fitWidth,
          //               child: Text(
          //                 "Cost for two: $cost",
          //                 style: TextStyle(
          //                     color: Colors.black,
          //                     // fontWeight: FontWeight.w600,
          //                     fontSize: h1 / 70),
          //               ),
          //             ),
          //           ],
          //         ),
          //         SizedBox(
          //           height: 2,
          //         ),
          //         delivery == true
          //             ? Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   Image.asset(
          //                     "Images/DeliveryImage.png",
          //                     height: h1 / 50,
          //                   ),
          //                   SizedBox(
          //                     width: w1 / 100,
          //                   ),
          //                   Text(
          //                     "Delivery",
          //                     style: TextStyle(
          //                         color: Colors.black,
          //                         // fontWeight: FontWeight.w600,
          //                         fontSize: h1 / 70),
          //                   )
          //                 ],
          //               )
          //             : SizedBox(
          //                 height: 2,
          //               ),
          //         takeaway == true
          //             ? Row(
          //                 mainAxisAlignment: MainAxisAlignment.start,
          //                 children: [
          //                   Image.asset(
          //                     "Images/TakeawayImage.png",
          //                     height: h1 / 50,
          //                   ),
          //                   SizedBox(
          //                     width: w1 / 100,
          //                   ),
          //                   Text(
          //                     "Takeaway",
          //                     style: TextStyle(
          //                         color: Colors.black,
          //                         // fontWeight: FontWeight.w600,
          //                         fontSize: h1 / 70),
          //                   )
          //                 ],
          //               )
          //             : SizedBox(),
          //       ],
          //     ),
          //   ),
          // ),
          // Container(
          //   height: h1 / 26,
          //   width: w1 / 3,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.only(
          //       bottomRight: Radius.circular(11),
          //     ),
          //     color:
          //         foodistaanCertified == true ? Color(0xffF7C12B) : Colors.white,
          //   ),
          //   child: FittedBox(
          //       fit: BoxFit.contain,
          //       child: Padding(
          //         padding:
          //             EdgeInsets.fromLTRB(w1 / 50, h1 / 200, w1 / 50, h1 / 200),
          //         child: Text(
          //           "Foodistaan Certified",
          //           style: TextStyle(
          //               color: Colors.white, fontWeight: FontWeight.w800),
          //         ),
          //       )),
          // )
        ],
      ),
    );
  }
}
