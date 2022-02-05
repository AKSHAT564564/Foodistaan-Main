import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/AppBar/AppBarFile.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'Crousel.dart';
import 'CategoryTile.dart';
import 'CuisineTile.dart';
import 'ListingsFile.dart';
import 'package:foodistan/Data/data.dart';
import 'AppBar/LocationPointsSearch.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:foodistan/widgets/location_bottam_sheet_widget.dart';
import '../scanner.dart';

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

    LocationFunctions().getUserLocation().then((value) {
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
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(h1 * 0.085), // here the desired height
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
                                      height:
                                          MediaQuery.of(context).size.height *
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Search(), //search widget moved down here
              SizedBox(
                height: 10,
              ),
              OfferSlider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 11,
                        right: 5.5,
                        top: 15,
                        bottom: 15,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          selectStreetStyle = true;
                          selectTiffinServices = false;
                          setState(() {});
                        },
                        child: FoodCategories(
                          ImagePath: 'Images/food-trolley.svg',
                          Caption: 'Street Style',
                          isSelected: selectStreetStyle,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 5.5,
                        right: 11,
                        top: 15,
                        bottom: 15,
                      ),
                      child: GestureDetector(
                        onTap: () async {
                          selectStreetStyle = false;
                          selectTiffinServices = true;
                          setState(() {});
                        },
                        child: FoodCategories(
                          ImagePath: 'Images/tiffin.svg',
                          Caption: 'Tiffin Services',
                          isSelected: selectTiffinServices,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
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

              //builds the list of all the in the database
              //takes user location as a reuired parameter
              //to sort the rest. Data according to user location
              Listings(
                userLocation: userLocation,
              ),
              SizedBox(
                height: 33,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
  //set true to preseve the state
}
