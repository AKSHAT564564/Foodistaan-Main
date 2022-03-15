import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/customLoadingSpinner.dart';
import 'package:foodistan/sizeConfig.dart';

class AcceptedOrder extends StatefulWidget {
  var orderData;
  var restaurantData;
  AcceptedOrder({required this.orderData});

  @override
  State<AcceptedOrder> createState() => _AcceptedOrderState();
}

class _AcceptedOrderState extends State<AcceptedOrder> {
  Map<String, dynamic> _restaurantData = {};
  @override
  void initState() {
    super.initState();
    fetchRestaurantData(widget.orderData['vendor-id']).then((v) {
      setState(() {
        _restaurantData = v;
      });
    });
  }

  Widget itemsList(Map orderItems) {
    List itemList = [];
    for (var item in orderItems.keys) {
      itemList.add(orderItems[item]);
    }

    if (itemList.length != 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: itemList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            var itemDetails = itemList[index];
            return Text(itemDetails['quantity'].toString() +
                ' X ' +
                itemDetails['name'].toString().toUpperCase());
          });
    } else
      return Text('Some Error');
  }

  fetchRestaurantData(String vendorId) async {
    Map<String, dynamic> restaurantData = {};
    await FirebaseFirestore.instance
        .collection('DummyData')
        .doc(vendorId)
        .get()
        .then((value) {
      restaurantData = value.data()!;
    });
    return restaurantData;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Order Status',
          ),
          elevation: 0,
          titleSpacing: 0,
          leadingWidth: 40,
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          leading: GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, 'H');
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'Images/trackorder.png',
                width: double.infinity,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Color(0xffFAC05E),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.event_note,
                                color: Color(0xffFAC05E),
                                size: 25,
                              ),
                            ),
                          ),
                          const Text(
                            'Order',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                          const Text(
                            'Confirmed',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Color(0xffFAC05E),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.hot_tub,
                                color: Color(0xffFAC05E),
                                size: 25,
                              ),
                            ),
                          ),
                          const Text(
                            'Food',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                          const Text(
                            'Preparing',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Color(0xffFAC05E),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.local_mall,
                                color: Color(0xffFAC05E),
                                size: 25,
                              ),
                            ),
                          ),
                          const Text(
                            'Order',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                          const Text(
                            'Placed',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(13),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(
                                color: Color(0xffFAC05E),
                                width: 1,
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.delivery_dining,
                                color: Color(0xffFAC05E),
                                size: 25,
                              ),
                            ),
                          ),
                          const Text(
                            'Out For',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                          const Text(
                            'Delivery',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 11.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 115,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'Know your Delivery Valet',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'You can Call and Message your Delivery Valet, check his temperature and other details.',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.delivery_dining,
                          color: Color(0xffFAC05E),
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                height: 115,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 11,
                          ),
                          Image.asset(
                            'Images/valetpic.png',
                            height: 55,
                            width: 55,
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Rahul Sharma',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Delivery Executive',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Icon(
                          Icons.phone_in_talk,
                          color: Color(0xffFAC05E),
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 33,
                width: double.infinity,
                color: kGreen,
                child: Center(
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 15,
                          ),
                          Icon(
                            Icons.thermostat,
                            color: Colors.white,
                            size: 22,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            '98.5\'F',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Text(
                            'Last Checked: 22 Minutes ago',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.white,
                padding: const EdgeInsets.all(11),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Your Order details',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _restaurantData.isEmpty
                              ? CustomLoadingSpinner()
                              : ListTile(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  leading: FadeInImage(
                                      height: SizeConfig.screenHeight * 0.1,
                                      width: SizeConfig.screenWidth * 0.15,
                                      fit: BoxFit.scaleDown,
                                      placeholder:
                                          AssetImage('assets/images/dosa.png'),
                                      image: NetworkImage(
                                          _restaurantData['FoodImage'])),
                                  title: Text(
                                    _restaurantData['Name'],
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16),
                                  ),
                                  subtitle: Text(
                                    _restaurantData['Address'],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12),
                                  ),
                                ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: 7,
                                      height: 7,
                                      child: Image.asset(
                                        'assets/images/green_sign.png',
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  SizedBox(
                                      width: SizeConfig.screenWidth * 0.9,
                                      child:
                                          itemsList(widget.orderData['items'])),
                                ],
                              ),
                              Text(
                                '₹ 150',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      width: 7,
                                      height: 7,
                                      child: Image.asset(
                                        'assets/images/red_sign.png',
                                        fit: BoxFit.cover,
                                      )),
                                  SizedBox(
                                    width: 11,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Chicken tandoori Momos (4 ps)',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        '2 mayos, 3 red chillie sauce',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Color.fromRGBO(153, 153, 153, 1),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                '₹ 170',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
              Container(
                height: 133,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(11),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Do you have any Query?',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Text(
                              'Click below to chat with us.',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(
                              height: 11,
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Container(
                                height: 33,
                                width: 177,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xffFAC05E),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Chat with Us',
                                    style: TextStyle(
                                      color: Color(0xffFAC05E),
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: Padding(
                        padding: EdgeInsets.all(11),
                        child: Icon(
                          Icons.chat,
                          color: Color(0xffFAC05E),
                          size: 35,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 11,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
