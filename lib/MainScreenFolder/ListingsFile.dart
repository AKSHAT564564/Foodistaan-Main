import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';
import 'package:provider/provider.dart';

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
                  padding: EdgeInsets.all(11),
                  child: ListedTile(
                    details: restaurantListValue.items[index],
                    Id: restaurantListValue.items[index]['id'],
                  ),
                );
              },
            )
          : CircularProgressIndicator(
              color: Colors.yellow,
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
              SizedBox(
                width: 10,
              ),
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
          width: w1 * 1,
          height: h1 * 0.2,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11), topRight: Radius.circular(11)),
            image: DecorationImage(
              image: NetworkImage(
                foodImage,
              ),
              fit: BoxFit.cover,
              alignment: FractionalOffset.center,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.015,
          left: MediaQuery.of(context).size.width * (-0.085),

          // child: Container(
          //     width: MediaQuery.of(context).size.width * 0.25,
          //     padding: EdgeInsets.all(6),
          //     decoration: BoxDecoration(
          //         color: Colors.blue[700],

          //         // gradient: LinearGradient(
          //         //   colors: [
          //         //     Color.fromRGBO(100, 200, 300, 1),
          //         //     Color.fromRGBO(200, 100, 100, 1),
          //         //     Color.fromRGBO(200, 300, 100, 1),
          //         //     Color.fromRGBO(300, 100, 200, 1),
          //         //   ],
          //         // ),
          //         borderRadius: BorderRadius.all(Radius.circular(4))),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.04,
            width: MediaQuery.of(context).size.width * 0.34,
            child: Stack(
              children: [
                Container(
                  // alignment: Alignment.topLeft,

                  child: SvgPicture.asset(
                    'Images/tag.svg',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                    left: MediaQuery.of(context).size.width * 0.08,
                    top: MediaQuery.of(context).size.height * 0.0018,
                    child: Row(children: [
                      Image.asset(
                        'Images/discount.png',
                        height: 14,
                        width: 14,
                        color: Colors.white,
                      ),
                      Text(
                        " 20% OFF",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                      ),
                    ]))
              ],
            ),
          ),
        ),
        // Positioned(
        //   right: MediaQuery.of(context).size.width * 0.68,
        //   bottom: MediaQuery.of(context).size.height * 0.18,
        //   child: foodistaanCertified == true
        //       ? SvgPicture.asset(
        //           'Images/streatoplus.svg',
        //           height: MediaQuery.of(context).size.width * 0.33,
        //         )
        //       // ? Padding(
        //       //     padding: const EdgeInsets.only(left: 10.0, top: 10),
        //       //     child: Container(
        //       //         padding: EdgeInsets.all(6),
        //       //         decoration: BoxDecoration(
        //       //             // color: Colors.black,
        //       //             gradient: LinearGradient(
        //       //               colors: [
        //       //                 Color.fromRGBO(191, 149, 63, 1),
        //       //                 Color.fromRGBO(252, 246, 186, 1),
        //       //                 Color.fromRGBO(179, 135, 40, 1),
        //       //                 Color.fromRGBO(251, 245, 183, 1),
        //       //               ],
        //       //             ),
        //       //             borderRadius: BorderRadius.all(Radius.circular(4))),
        //       //         child: Text.rich(
        //       //           TextSpan(
        //       //             children: [
        //       //               TextSpan(
        //       //                   text: 'STREAT',
        //       //                   style: TextStyle(
        //       //                       fontWeight: FontWeight.bold,
        //       //                       color: Colors.white,
        //       //                       fontSize: 14)),
        //       //               TextSpan(
        //       //                   text: 'O',
        //       //                   style: TextStyle(
        //       //                       fontWeight: FontWeight.bold,
        //       //                       color: Colors.red,
        //       //                       fontSize: 14)),
        //       //               TextSpan(
        //       //                   text: '+',
        //       //                   style: TextStyle(
        //       //                       fontWeight: FontWeight.bold,
        //       //                       color: Colors.green,
        //       //                       fontSize: 14)),
        //       //             ],
        //       //           ),
        //       //         )),
        //       //     // Text(
        //       //     //   "CERTIFIED",
        //       //     //   style: TextStyle(
        //       //     //       fontSize: 14,
        //       //     //       color: Colors.black,
        //       //     //       fontWeight: FontWeight.bold),
        //       //     // )),
        //       //   )
        //       : SizedBox(),
        // )
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
      padding: EdgeInsets.all(4),
      width: w1 * 0.9,
      margin: EdgeInsets.only(top: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              width: w1 * 0.7,
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    name.length > 20 ? name.substring(0, 19) + '...' : name,
                    textAlign: TextAlign.start,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.02,
                    child: foodistaanCertified == true
                        ? FittedBox(
                            fit: BoxFit.cover,
                            child: SvgPicture.asset(
                              'Images/streatoplus.svg',
                              // width: MediaQuery.of(context).size.width * 0.15,
                              // height: MediaQuery.of(context).size.height * 0.1,
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kGreen,
              ),
              child: Row(
                children: [
                  Text(
                    "4.7",
                    style: TextStyle(fontSize: 10, color: Colors.white),
                  ),
                  Icon(
                    Icons.star,
                    size: 12,
                    color: Colors.white,
                  ),
                ],
              ),
            )
          ]),
          SizedBox(
            height: 5,
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
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
                    fontSize: 10,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(5),
                child: Text(
                  '₹ $cost for two',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          )),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.start,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     CircleAvatar(
          //       backgroundColor: Colors.pink,
          //       radius: 8,
          //       child: Center(
          //         child: Text(
          //           '₹',
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontSize: 10,
          //           ),
          //         ),
          //       ),
          //     ),
          //     SizedBox(
          //       width: 5,
          //     ),
          //     Text(
          //       'Cost for Two ₹ $cost',
          //       style: TextStyle(
          //         color: Colors.black,
          //         fontSize: 10,
          //       ),
          //     ),
          //   ],
          // ),
          Divider(
            height: 10,
            thickness: 1,
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: w1 * 0.4,
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Row(
                      children: [
                        delivery == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kGrey,
                                    radius: 8,
                                    child: Center(
                                      child: Icon(
                                        Icons.two_wheeler,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'Delivery',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              )
                            : SizedBox(),
                        SizedBox(
                          width: 5,
                        ),
                        takeaway == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: kGrey,
                                    radius: 8,
                                    child: Center(
                                      child: Icon(
                                        Icons.shopping_bag_outlined,
                                        color: Colors.white,
                                        size: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    'Takeaway',
                                    style: TextStyle(
                                      color: Colors.grey[500],
                                      fontSize: 10,
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
                        size: 12,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Container(
                        child: Text(
                          address.length > 25
                              ? address.substring(0, 25) + '...'
                              : address,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 10,
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
            height: 5,
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
