import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/functions/order_functions.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class OrderHistoryWidget extends StatefulWidget {
  var orderData;
  OrderHistoryWidget({required this.orderData});

  @override
  State<OrderHistoryWidget> createState() => _OrderHistoryWidgetState();
}

class _OrderHistoryWidgetState extends State<OrderHistoryWidget> {
  Widget itemsList(Map orderItems) {
    List itemList = [];
    for (var item in orderItems.keys) {
      itemList.add(orderItems[item]);
    }

    if (itemList.length != 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: itemList.length,
          itemBuilder: (BuildContext context, int index) {
            var itemDetails = itemList[index];
            return Text(itemDetails['quantity'].toString() +
                ' X ' +
                itemDetails['name'].toString().toUpperCase());
          });
    } else
      return Text('Some Error');
  }

  Map<String, dynamic> _restaurantData = {};

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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchRestaurantData(widget.orderData['vendor-id']).then((v) {
      setState(() {
        _restaurantData = v;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return _restaurantData.isEmpty
        ? SizedBox(
            height: 3,
            child: LinearProgressIndicator(
              color: Colors.yellowAccent,
              backgroundColor: Colors.yellow,
            ),
          )
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 0.5,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(11),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: FadeInImage(
                                    placeholder:
                                        AssetImage('assets/images/dosa.png'),
                                    image: NetworkImage(
                                        _restaurantData['FoodImage'])),
                                width: 75,
                                height: 50,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.orderData['vendor-name'],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    'Rohini, New Delhi',
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\u{20B9} ${widget.orderData['total-bill'].toString()}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.end,
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       widget.orderData['total-bill'].toString(),
                  //       style: TextStyle(
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     SizedBox(
                  //       width: 11,
                  //     ),
                  //   ],
                  // ),

                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Items',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        itemsList(widget.orderData['items']),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Ordered On',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  OrderFunction()
                                      .orderTime(widget.orderData['time']),
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Status: ' +
                                    widget.orderData['order-status']
                                        .toString()
                                        .toUpperCase(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.05,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(255, 252, 222, 1),
                      borderRadius: BorderRadius.circular(11),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(223, 195, 11, 1),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          RatingCardList(),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.all(
                                    MediaQuery.of(context).size.width * 0.005,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Color.fromRGBO(247, 193, 43, 1),
                                  ),
                                  child: Icon(
                                    Icons.refresh,
                                    size: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Repeat Order',
                                  style: TextStyle(fontSize: 12),
                                ),
                                SizedBox(
                                  width: 11,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

class RatingCardList extends StatefulWidget {
  const RatingCardList({Key? key}) : super(key: key);

  @override
  _RatingCardListState createState() => _RatingCardListState();
}

class _RatingCardListState extends State<RatingCardList> {
  Widget ratingPointWidget(int ratedValue) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Text(
              ratedValue.toString(),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Icon(
              Icons.star,
              size: 8,
              color: Colors.grey,
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          rateValue = '1';
        });
      },
    );
  }

  String rateValue = '';
  @override
  Widget build(BuildContext context) {
    return rateValue.isEmpty
        ? Container(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.005,
              right: MediaQuery.of(context).size.width * 0.005,
            ),
            child: Row(
              children: [
                SizedBox(
                  width: 11,
                ),
                Text(
                  'Rate',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(240, 54, 54, 1),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                ratingPointWidget(1),
                SizedBox(
                  width: 4,
                ),
                ratingPointWidget(2),
                SizedBox(
                  width: 4,
                ),
                ratingPointWidget(3),
                SizedBox(
                  width: 4,
                ),
                ratingPointWidget(4),
                SizedBox(
                  width: 4,
                ),
                ratingPointWidget(5),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          )
        : Container(
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 11,
                ),
                Text(
                  'You Rated',
                  style: TextStyle(fontSize: 12),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.width * 0.011,
                    bottom: MediaQuery.of(context).size.width * 0.011,
                    left: MediaQuery.of(context).size.width * 0.005,
                    right: MediaQuery.of(context).size.width * 0.005,
                  ),
                  // height: 20,
                  width: MediaQuery.of(context).size.width * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Color.fromRGBO(247, 193, 43, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        rateValue,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
  }
}
