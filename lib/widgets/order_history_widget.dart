import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:foodistan/customLoadingSpinner.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:sizer/sizer.dart';
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
            return Text(
              itemDetails['quantity'].toString() +
                  ' X ' +
                  itemDetails['name'].toString().toUpperCase(),
              style: TextStyle(
                color: kBlackL,
                fontSize: 12.sp,
              ),
            );
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
        // ? SizedBox(
        //     height: 3,
        //     child: LinearProgressIndicator(
        //       color: Colors.yellowAccent,
        //       backgroundColor: Colors.yellow,
        //     ),
        // )
        // ? Container(height: 80.h, child: CustomLoadingSpinner())
        ? Container()
        : Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: kGrey,
                    spreadRadius: 0.5,
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(8.sp),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.sp),
                                child: Container(
                                  // decoration: BoxDecoration(
                                  //   borderRadius: BorderRadius.circular(8.sp),
                                  // ),
                                  child: FadeInImage(
                                    placeholder:
                                        AssetImage('assets/images/dosa.png'),
                                    image: NetworkImage(
                                        _restaurantData['FoodImage']),
                                    fit: BoxFit.fill,
                                  ),
                                  width: 75,
                                  height: 50,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _restaurantData['Name'],
                                    style: TextStyle(
                                      color: kBlackL,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    _restaurantData['Address'],
                                    style: TextStyle(
                                      color: kGrey,
                                      fontSize: 10.sp,
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
                            fontWeight: FontWeight.w700,
                            color: kBlackL,
                            fontSize: 12.sp,
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
                            color: kGrey,
                            fontSize: 12.sp,
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Ordered On',
                                style: TextStyle(
                                  color: kGrey,
                                  fontSize: 12.sp,
                                ),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Text(
                                OrderFunction()
                                    .orderTime(widget.orderData['time']),
                                style: TextStyle(
                                  color: kBlackL,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status ',
                              style: TextStyle(
                                color: kGrey,
                                fontSize: 12.sp,
                              ),
                            ),
                            Text(
                              widget.orderData['order-status']
                                  .toString()
                                  .toUpperCase(),
                              style: TextStyle(
                                color: kBlackL,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
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
                                  size: 10.sp,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'Repeat Order',
                                style:
                                    TextStyle(fontSize: 10.sp, color: kBlackL),
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
          border: Border.all(
            color: kGrey,
          ),
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            Text(
              ratedValue.toString(),
              style: TextStyle(
                fontSize: 12.sp,
                color: kGrey,
              ),
            ),
            Icon(
              Icons.star,
              size: 8.sp,
              color: Colors.grey,
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          rateValue = ratedValue.toString();
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
                    fontSize: 10.sp,
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
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: kBlackL,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  // height: 20,
                  // width: MediaQuery.of(context).size.width * 0.11,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromRGBO(247, 193, 43, 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        rateValue,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.star,
                        size: 8.sp,
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
