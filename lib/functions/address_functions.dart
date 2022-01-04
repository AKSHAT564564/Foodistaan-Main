import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodistan/MainScreenFolder/AppBar/LocationPointsSearch.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserAddress {
  final _firestore = FirebaseFirestore.instance;

  fetchAllAddresses() async {
    List<Map<String, dynamic>> addressList = [];
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(userNumber)
        .collection('address')
        .get()
        .then((value) {
      for (var item in value.docs) {
        addressList.add(item.data());
      }
    });
    return addressList;
  }

  getDeliveryAddress() async {
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    String addressId = '';

    await _firestore.collection('users').doc(userNumber).get().then((v) {
      v.data()!.forEach((key, value) {
        if (key == 'address-id') addressId = value;
      });
    });
    var addressData = null;
    if (addressId.isNotEmpty) {
      print('true');
      await _firestore
          .collection('users')
          .doc(userNumber)
          .collection('address')
          .doc(addressId)
          .get()
          .then((value) {
        addressData = value.data();
      });
    }
    return addressData;
  }

  addUserAddress(houseFeild, streetFeild, category, location) async {
    String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;

    String id = await _firestore
        .collection('users')
        .doc(userNumber)
        .collection('address')
        .doc()
        .id;
    print('IDD $id');
    await _firestore
        .collection('users')
        .doc(userNumber)
        .collection('address')
        .doc(id)
        .set({
      'house-feild': houseFeild,
      'street-feild': streetFeild,
      'category': category,
      'user-location': GeoPoint(location.latitude, location.longitude),
    }).then((value) {
      deliveryAddress.value = {
        'house-feild': houseFeild,
        'street-feild': streetFeild,
        'category': category,
        'user-location': GeoPoint(location.latitude, location.longitude)
      };
    }).then((value) {
      _firestore.collection('users').doc(userNumber).update({'address-id': id});
    });
  }
}
