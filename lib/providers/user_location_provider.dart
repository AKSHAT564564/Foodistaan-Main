import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodistan/functions/address_from_placeId_model.dart';
import 'package:geocoding/geocoding.dart';

class UserLocationProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
  GeoPoint? _userLocation;
  bool _hasUserLocation = false;
  bool _userLocationIsNull = true;
  AddressModel? _userAddress;

  GeoPoint? get userLocation => _userLocation;
  bool get hasUserLocation => _hasUserLocation;
  AddressModel? get userAddress => _userAddress;
  bool get userLocationIsNull => _userLocationIsNull;

  getUserLocation() async {
    await _firestore.collection('users').doc(userNumber).get().then((v) {
      v.data()!.forEach((key, value) {
        //if 'user-location' exists in the database
        //stores it in the database
        if (key == 'user-location') _userLocation = value;
      });
    });

    if (_userLocation != null) {
      _userAddress =
          await getAddress(_userLocation!.latitude, _userLocation!.longitude);
      _hasUserLocation = true;
      _userLocationIsNull = false;
    } else {
      _userLocationIsNull = true;
    }

    notifyListeners();
  }

  getAddress(latitude, longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark places = placemarks[0];

    AddressModel addressModel = createeAddressModel(places);
    return addressModel;
  }

  createeAddressModel(Placemark? places) {
    AddressModel addressModel = AddressModel(
        street: places!.street,
        country: places.country,
        locality: places.locality,
        name: places.name,
        subLocality: places.subLocality);
    return addressModel;
  }

// calculate distance between Restaurant and User
  getDistanceBtw(
    vendorLatitude,
    vendorLongitude,
    userLatitude,
    userLongitude,
  ) {
    // var userLatitude = userLocation!.latitude;
    // var userLongitude = userLocation!.longitude;
    // var userLatitude = 29.46786;
    // var userLongitude = -98.53506;

    String distance(
        double lat1, double lon1, double lat2, double lon2, String unit) {
      //  This function converts decimal degrees to radians
      double deg2rad(double deg) {
        return (deg * pi / 180.0);
      }

      // This function converts radians to decimal degrees
      double rad2deg(double rad) {
        return (rad * 180.0 / pi);
      }

      double theta = lon1 - lon2;

      double dist = sin(deg2rad(lat1)) * sin(deg2rad(lat2)) +
          cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * cos(deg2rad(theta));
      dist = acos(dist);
      dist = rad2deg(dist);
      dist = dist * 60 * 1.1515;
      if (unit == 'K') {
        dist = dist * 1.609344;
      } else if (unit == 'N') {
        dist = dist * 0.8684;
      }
      return dist.toStringAsFixed(2);
    }

    print("Distance : " +
        distance(
            vendorLatitude, vendorLongitude, userLatitude, userLongitude, 'M') +
        " Miles\n");
    print("Distance : " +
        distance(
            vendorLatitude, vendorLongitude, userLatitude, userLongitude, 'K') +
        " Kilometers\n");
    print("Distance : " +
        distance(
            vendorLatitude, vendorLongitude, userLatitude, userLongitude, 'N') +
        " Nautical Miles\n");
  }
}
