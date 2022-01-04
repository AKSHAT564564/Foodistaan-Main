import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/Location/LocationMap.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/address_from_placeId_model.dart';
import 'package:foodistan/functions/address_functions.dart';
import 'package:foodistan/functions/location_functions.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:foodistan/global/global_variables.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final houseFeildController = TextEditingController();
  final streetFeildController = TextEditingController();
  final CameraPosition _kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 15,
  );
  Completer<GoogleMapController> _controller = Completer();

  var addressModel = null;
  var userLocation = null;
  bool hasAddress = false;

  String categorySelected = 'home';

  getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    Location location = new Location();
    bool serviceEnabled;
    PermissionStatus permissionStatus;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return null;
    }
    permissionStatus = await location.hasPermission();

    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) return null;
    }
    final locationData = await location.getLocation();

    await setLocation(locationData);

    return LatLng(locationData.latitude!, locationData.longitude!);
  }

  @override
  void initState() {
    super.initState();

    _asyncFunctions();
  }

  _asyncFunctions() async {
    var userLocationTemp = await LocationFunctions().getUserLocation();
    if (userLocationTemp != null) {
      await setLocation(userLocationTemp).then(() {
        pointToLocation(userLocationTemp);
        setState(() {
          userLocation = userLocationTemp;
        });
      });
    } else {
      await getCurrentLocation().then((currentLocation) {
        setLocation(currentLocation);
      });
    }
  }

  pointToLocation(location) async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(location.latitude!, location.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  setLocation(location) async {
    await pointToLocation(location);

    await LocationFunctions()
        .getAddress(location.latitude, location.longitude)
        .then((value) {
      setState(() {
        addressModel = value;
        hasAddress = true;
        userLocation = location;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Add Address',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: double.infinity,
                  color: Colors.grey,
                  child: Center(
                    child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        myLocationButtonEnabled: false,
                        myLocationEnabled: true,
                        mapType: MapType.normal,
                        initialCameraPosition: _kGooglePlex),
                  ),
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 11,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await getCurrentLocation();
                    },
                    child: Text(
                      'Current Location',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.underline,
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 11,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 11,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          hasAddress
                              ? Text(
                                  '${addressModel.street}, ${addressModel.locality}, ${addressModel.name}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                )
                              : Text('No Location Yet'),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          'Change',
                          style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(5),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 5,
                      ),
                      child: TextFormField(
                        controller: houseFeildController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'House No. & Building',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 11,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.055,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadiusDirectional.circular(5),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 5,
                      ),
                      child: TextFormField(
                        controller: streetFeildController,
                        keyboardType: TextInputType.text,
                        textAlign: TextAlign.left,
                        decoration: InputDecoration(
                          hintText: 'Street & Area',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        categorySelected = 'home';
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: categorySelected == 'home'
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.home,
                              color: categorySelected == 'home'
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Home',
                              style: TextStyle(
                                color: categorySelected == 'home'
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        categorySelected = 'office';
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: categorySelected == 'office'
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.local_post_office,
                              color: categorySelected == 'office'
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Office',
                              style: TextStyle(
                                color: categorySelected == 'office'
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        categorySelected = 'other';
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width * 0.25,
                      decoration: BoxDecoration(
                        color: categorySelected == 'other'
                            ? Theme.of(context).primaryColor
                            : Colors.white,
                        border: Border.all(
                          color: Theme.of(context).primaryColor,
                          width: 1,
                        ),
                        borderRadius: BorderRadiusDirectional.circular(5),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.more_horiz,
                              color: categorySelected == 'other'
                                  ? Colors.white
                                  : Theme.of(context).primaryColor,
                              size: MediaQuery.of(context).size.width * 0.07,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Other',
                              style: TextStyle(
                                color: categorySelected == 'other'
                                    ? Colors.white
                                    : Theme.of(context).primaryColor,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: GestureDetector(
                  onTap: () async {
                    await UserAddress()
                        .addUserAddress(
                      houseFeildController.text,
                      streetFeildController.text,
                      categorySelected,
                      userLocation,
                    )
                        .then({Navigator.pop(context)});
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.066,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                      ),
                      borderRadius: BorderRadiusDirectional.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        'Add Address',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
