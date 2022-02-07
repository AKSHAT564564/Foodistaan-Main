import 'package:flutter/material.dart';
import 'package:foodistan/restuarant_screens/restaurant_main.dart';
import 'package:foodistan/widgets/bottom_navbar.dart';

class RestaurantOverview extends StatefulWidget {
  static String id = 'restaurant_overview';

  @override
  _RestaurantOverviewState createState() => _RestaurantOverviewState();
}

class _RestaurantOverviewState extends State<RestaurantOverview> {
  bool isMenuSelected = true;
  bool isReviewSelected = false;

  @override
  Widget build(BuildContext context) {
    var itemWidth = MediaQuery.of(context).size.width * 0.45;
    var itemHeight = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.05),
        child: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: <Widget>[
              Container(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.share,
                      color: Colors.black,
                      size: 26.0,
                    ),
                  )),
            ]),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Image.asset(
                  'assets/images/dosa.png',
                  width: double.infinity,
                  // fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(Icons.pin_drop),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Location",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Sector 12, House No. 14, Rohni, Delhi"),
                      Text("Location of other outlets",
                          style: TextStyle(color: Colors.red)),
                    ],
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(Icons.lock_clock),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Timings",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("12pm - 10pm (Today)"),
                    ],
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(Icons.monetization_on_rounded),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cost",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("Cost for two - ₹500 (approx.)"),
                    ],
                  )
                ]),
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                height: MediaQuery.of(context).size.height * 0.1,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Icon(Icons.star_border),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Reviews",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text("(125 Reviews)"),
                    ],
                  )
                ]),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.05),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Menu",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      Row(children: [
                        Image.asset('assets/images/menu.png'),
                        Image.asset('assets/images/menu.png'),
                        Image.asset('assets/images/menu.png'),
                        Image.asset('assets/images/menu.png'),
                      ]),
                      Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.width * 0.05),
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.yellow),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: null,
                                  child: Center(
                                    child: Text(
                                      "See Full Menu",
                                      style: TextStyle(
                                          fontSize: 12, color: Colors.yellow),
                                    ),
                                  )),
                            ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
