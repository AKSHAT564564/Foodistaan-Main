import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/MainScreenFolder/address_screen.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/address_functions.dart';

class Address extends StatefulWidget {
  const Address({Key? key}) : super(key: key);

  @override
  State<Address> createState() => _AddressState();
}

class _AddressState extends State<Address> {
  List<Map<String, dynamic>> addressList = [];
  bool hasData = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserAddress().fetchAllAddresses().then((value) {
      setState(() {
        addressList = value;
        hasData = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'My Addresses',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true,
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.add,
                  size: 17.5,
                  color: Color.fromRGBO(255, 206, 69, 1),
                ),
                SizedBox(
                  width: 5,
                ),
                GestureDetector(
                  onTap: () => AddressScreen(),
                  child: Text(
                    'Add Address',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 11),
              child: Divider(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            hasData == false
                ? CircularProgressIndicator()
                : hasData == true && addressList.isEmpty
                    ? Center(
                        child: Text('No Saved Address'),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: addressList.length,
                        itemBuilder: (context, index) {
                          Map<String, dynamic> data = addressList[index];
                          return GestureDetector(
                            onTap: () async {
                              deliveryAddress.value = data;
                              Navigator.pop(context);
                            },
                            child: Stack(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(
                                      width: 25,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.location_on_outlined,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 11,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data['category']
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          data['house-feild'].toString() +
                                              ' ' +
                                              data['street-feild'].toString(),
                                          style: TextStyle(
                                            color: Colors.grey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        })
          ],
        ),
      ),
    );
  }
}
