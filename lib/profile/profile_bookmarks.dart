import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodistan/restuarant_screens/restaurant_delivery.dart';

//same widgets used as lisitng_file.dart

class Bookmarks extends StatefulWidget {
  const Bookmarks({Key? key}) : super(key: key);

  @override
  State<Bookmarks> createState() => _BookmarksState();
}

class _BookmarksState extends State<Bookmarks> {
  bool hasBookMarks = false;
  List bookMarks = [];
  List bookMarkRestaurantData = [];
  fetchAllBookmarks() async {
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    //first checking and fetching the bookmark array in the user database
    //if exits set hasBookMarks to true
    //bookmarks array stores the rest. id from the user database
    //bookMarkRestaurantData stores the restaurant data from the array
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .get()
        .then((value) {
      if (value.data()!.containsKey('bookmarks')) {
        bookMarks = value.data()!['bookmarks'];
        hasBookMarks =
            true; //stores bookmarks list(String of restaurnat ID) in the array for fetching data later
      } else {
        hasBookMarks = false;
      }
    });
    if (hasBookMarks == true) {
      for (var item in bookMarks) {
        await FirebaseFirestore.instance
            .collection('DummyData')
            .doc(item)
            .get()
            .then((value) {
          bookMarkRestaurantData.add(value.data());
        });
      }
      bookMarkRestaurantData.reversed;
    }
  }

  final _searchController = TextEditingController();

  ValueNotifier<List> searchResults = ValueNotifier([]);

  searchQuery(String query, List items) {
    List searchResultsTemp = [];
    for (var item in items) {
      RegExp regExp = new RegExp(query, caseSensitive: false);
      bool containe = regExp.hasMatch(item['Name']);
      if (containe) {
        searchResultsTemp.add(item);
      }
    }

    searchResults.value = searchResultsTemp;
  }

  @override
  void initState() {
    super.initState();
    fetchAllBookmarks().then((v) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Bookmarks',
        ),
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 40,
        titleTextStyle: TextStyle(
            color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
            size: 25,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(11),
              //   child: Container(
              //       decoration: const BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.all(
              //           Radius.circular(11),
              //         ),
              //         boxShadow: [
              //           BoxShadow(
              //             color: Colors.grey,
              //             spreadRadius: 0.4,
              //           ),
              //         ],
              //       ),
              //       width: double.infinity,
              //       height: 40,
              //       child: TextFormField(
              //         controller: _searchController,
              //         onChanged: (v) async {
              //           searchQuery(
              //               _searchController.text, bookMarkRestaurantData);
              //           setState(() {}); //for cross icon in searchbar
              //         },
              //         textAlign: TextAlign.start,
              //         obscureText: false,
              //         decoration: InputDecoration(
              //             contentPadding: EdgeInsets.all(0),
              //             hintText: 'Search Within Bookmarks',
              //             hintStyle: TextStyle(
              //               color: Colors.grey,
              //             ),
              //             suffixIcon: IconButton(
              //                 alignment: Alignment.center,
              //                 onPressed: () {
              //                   _searchController.text = '';
              //                   searchResults.value = [];
              //                   setState(() {}); //for cross icon in searchbar
              //                 },
              //                 icon: Icon(
              //                   Icons.clear_rounded,
              //                   color: _searchController.text.isNotEmpty
              //                       ? Colors.grey
              //                       : Colors.transparent,
              //                 )),
              //             prefixIcon: Icon(
              //               Icons.search,
              //               color: Color(0xFFFAB84C),
              //             ),
              //             focusedBorder: const OutlineInputBorder(
              //                 borderSide: BorderSide(
              //                     color: Color(0xFFFAB84C), width: 1),
              //                 borderRadius:
              //                     BorderRadius.all(Radius.circular(8))),
              //             enabledBorder: const OutlineInputBorder(
              //               borderRadius: BorderRadius.all(
              //                 Radius.circular(8),
              //               ),
              //               borderSide: BorderSide(
              //                 color: Color(0xFFFAB84C),
              //                 width: 1,
              //               ),
              //             )),
              //       )),
              // ),
              ValueListenableBuilder<List>(
                  valueListenable: searchResults,
                  builder: (_, value, __) {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 15),
                      child: hasBookMarks == false
                          ? Text('No Restaurants BookMarked')
                          : ListView.builder(
                              itemCount: bookMarkRestaurantData.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                RestaurantDelivery(
                                                  items: bookMarkRestaurantData[
                                                      index],
                                                  vendor_id:
                                                      bookMarkRestaurantData[
                                                          index]['id'],
                                                  vendorName:
                                                      bookMarkRestaurantData[
                                                          index]['Name'],
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          LeftSide(
                                            foodImage:
                                                bookMarkRestaurantData[index]
                                                    ['FoodImage'],
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          RightSide(
                                            name: bookMarkRestaurantData[index]
                                                ['Name'],
                                            address:
                                                bookMarkRestaurantData[index]
                                                    ['Address'],
                                            cuisines:
                                                bookMarkRestaurantData[index]
                                                    ['Cuisines'],
                                            stars: bookMarkRestaurantData[index]
                                                ['Stars'],
                                            cost: bookMarkRestaurantData[index]
                                                ['Cost'],
                                            delivery:
                                                bookMarkRestaurantData[index]
                                                    ['Delivery'],
                                            takeaway:
                                                bookMarkRestaurantData[index]
                                                    ['Takeaway'],
                                            foodistaanCertified:
                                                bookMarkRestaurantData[index]
                                                    ['FoodistaanCertified'],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                    );
                  })

              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(11),
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey,
              //           spreadRadius: 0.4,
              //         ),
              //       ],
              //     ),
              //     width: double.infinity,
              //     child: Stack(
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Image.asset(
              //               'Images/bookmark.png',
              //               height: 150,
              //             ),
              //             Container(
              //               height: 30,
              //               width: 166,
              //               color: Colors.yellow,
              //               child: Center(
              //                 child: Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.where_to_vote,
              //                       color: Colors.white,
              //                     ),
              //                     SizedBox(
              //                       width: 2.5,
              //                     ),
              //                     Text('Foodistaan Certified'),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const SizedBox(
              //                   height: 22,
              //                 ),
              //                 const Text(
              //                   'Pizza Junction',
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 const Text(
              //                   'Fast Food Snacks',
              //                   style: TextStyle(
              //                     color: Colors.grey,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.attach_money,
              //                       color: Colors.pink,
              //                     ),
              //                     SizedBox(
              //                       width: 3,
              //                     ),
              //                     Text('Cost for two ₹300'),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.two_wheeler,
              //                       color: Colors.blue,
              //                     ),
              //                     SizedBox(
              //                       width: 3,
              //                     ),
              //                     Text('Delivery'),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.shopping_bag,
              //                       color: Colors.green,
              //                     ),
              //                     SizedBox(
              //                       width: 3,
              //                     ),
              //                     Text('Takeaway'),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const SizedBox(
              //               width: 15,
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(10),
              //   child: Container(
              //     decoration: const BoxDecoration(
              //       color: Colors.white,
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(11),
              //       ),
              //       boxShadow: [
              //         BoxShadow(
              //           color: Colors.grey,
              //           spreadRadius: 0.4,
              //         ),
              //       ],
              //     ),
              //     width: double.infinity,
              //     child: Stack(
              //       children: [
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.start,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Image.asset(
              //               'Images/bookmark.png',
              //               height: 150,
              //             ),
              //             Container(
              //               height: 30,
              //               width: 166,
              //               color: Colors.yellow,
              //               child: Center(
              //                 child: Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.where_to_vote,
              //                       color: Colors.white,
              //                     ),
              //                     SizedBox(
              //                       width: 2.5,
              //                     ),
              //                     Text('Foodistaan Certified'),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.end,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               children: [
              //                 const SizedBox(
              //                   height: 22,
              //                 ),
              //                 const Text(
              //                   'Pizza Junction',
              //                   style: TextStyle(
              //                     color: Colors.black,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //                 const Text(
              //                   'Fast Food Snacks',
              //                   style: TextStyle(
              //                     color: Colors.grey,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                     Icon(
              //                       Icons.star,
              //                       color: Colors.yellow,
              //                     ),
              //                   ],
              //                 ),
              //                 const SizedBox(
              //                   height: 5,
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.attach_money,
              //                       color: Colors.pink,
              //                     ),
              //                     SizedBox(
              //                       width: 3,
              //                     ),
              //                     Text('Cost for two ₹300'),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.two_wheeler,
              //                       color: Colors.blue,
              //                     ),
              //                     SizedBox(
              //                       width: 3,
              //                     ),
              //                     Text('Delivery'),
              //                   ],
              //                 ),
              //                 Row(
              //                   children: const [
              //                     Icon(
              //                       Icons.shopping_bag,
              //                       color: Colors.green,
              //                     ),
              //                     SizedBox(
              //                       width: 3,
              //                     ),
              //                     Text('Takeaway'),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //             const SizedBox(
              //               width: 15,
              //             ),
              //           ],
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
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
          height: h1 * 0.3,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(11), topRight: Radius.circular(11)),
            image: DecorationImage(
              image: NetworkImage(
                foodImage,
              ),
              fit: BoxFit.fitWidth,
              alignment: FractionalOffset.center,
            ),
          ),
        ),
        Positioned(
          top: MediaQuery.of(context).size.height * 0.17,
          right: MediaQuery.of(context).size.width * 0.69,

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
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'Images/tag.svg',
                  height: MediaQuery.of(context).size.width * 0.33,
                ),
              ),
              Positioned(
                  left: MediaQuery.of(context).size.width * 0.07,
                  top: MediaQuery.of(context).size.width * 0.12,
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
        Positioned(
          right: MediaQuery.of(context).size.width * 0.68,
          bottom: MediaQuery.of(context).size.height * 0.18,
          child: foodistaanCertified == true
              ? SvgPicture.asset(
                  'Images/streatoplus.svg',
                  height: MediaQuery.of(context).size.width * 0.33,
                )
              // ? Padding(
              //     padding: const EdgeInsets.only(left: 10.0, top: 10),
              //     child: Container(
              //         padding: EdgeInsets.all(6),
              //         decoration: BoxDecoration(
              //             // color: Colors.black,
              //             gradient: LinearGradient(
              //               colors: [
              //                 Color.fromRGBO(191, 149, 63, 1),
              //                 Color.fromRGBO(252, 246, 186, 1),
              //                 Color.fromRGBO(179, 135, 40, 1),
              //                 Color.fromRGBO(251, 245, 183, 1),
              //               ],
              //             ),
              //             borderRadius: BorderRadius.all(Radius.circular(4))),
              //         child: Text.rich(
              //           TextSpan(
              //             children: [
              //               TextSpan(
              //                   text: 'STREAT',
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.white,
              //                       fontSize: 14)),
              //               TextSpan(
              //                   text: 'O',
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.red,
              //                       fontSize: 14)),
              //               TextSpan(
              //                   text: '+',
              //                   style: TextStyle(
              //                       fontWeight: FontWeight.bold,
              //                       color: Colors.green,
              //                       fontSize: 14)),
              //             ],
              //           ),
              //         )),
              //     // Text(
              //     //   "CERTIFIED",
              //     //   style: TextStyle(
              //     //       fontSize: 14,
              //     //       color: Colors.black,
              //     //       fontWeight: FontWeight.bold),
              //     // )),
              //   )
              : SizedBox(),
        )
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
              child: Text(
                name,
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Colors.green,
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
                  'Cost for Two ₹ $cost',
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
                  child: Row(
                    children: [
                      delivery == true
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.pink,
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
                                  backgroundColor: Colors.pink,
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
            height: 10,
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
