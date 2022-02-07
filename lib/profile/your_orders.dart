import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  String? userNumber = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;
    });
  }

  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          titleSpacing: 0,
          leadingWidth: 40,
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
          title: const Text(
            'Your Orders',
          ),
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
        body: userNumber != ''
            ? Padding(
                padding: const EdgeInsets.only(top: 20),
                child: OrderFunction().fetchAllOrders(userNumber))
            : spinkit,
        // body: SingleChildScrollView(
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [

        //       const SizedBox(
        //         height: 5,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(5),
        //         child: Container(
        //           height: 165,
        //           width: double.infinity,
        //           decoration: const BoxDecoration(
        //             color: Colors.white,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.grey,
        //                 spreadRadius: 0.5,
        //               ),
        //             ],
        //             borderRadius: BorderRadius.all(Radius.circular(11),),
        //           ),
        //           child: Stack(
        //             children: [
        //               Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Stack(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Container(
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(15),
        //                               image: const DecorationImage(image: AssetImage('assets/food.png'),
        //                                 fit: BoxFit.cover,
        //                               ),
        //                             ),
        //                             width: 75,
        //                             height: 50,
        //                           ),
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: const [
        //                               Text('The Special Dosa',
        //                                 style: TextStyle(
        //                                   color: Colors.black,
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text('Rohini, New Delhi',
        //                                 style: TextStyle(
        //                                   color: Colors.grey,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: const [
        //                           Text('₹100',style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                           ),),
        //                           SizedBox(
        //                             width: 11,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const SizedBox(
        //                         width: 5,
        //                       ),
        //                       Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: const [
        //                           Text('Items',style: TextStyle(
        //                             color: Colors.grey,
        //                           ),),
        //                           SizedBox(
        //                             height: 2,
        //                           ),
        //                           Text('1x Masala Dosa',style: TextStyle(
        //                               color: Colors.black,
        //                           ),),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Stack(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: const [
        //                               Text('Ordered On',style: TextStyle(
        //                                 color: Colors.grey,
        //                               ),),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text('October 10, 2021 at 4:55pm',style: TextStyle(
        //                                 color: Colors.black,
        //                               ),),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: const [
        //                           Text('Status: ',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                           Icon(
        //                             Icons.check_circle,
        //                             color: Colors.green,
        //                             size: 15,
        //                           ),
        //                           Text(' Delivered',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 7,
        //                   ),
        //                   Container(
        //                     width: double.infinity,
        //                     height: 25,
        //                     decoration: BoxDecoration(
        //                       color: const Color.fromRGBO(255, 252, 222, 1),
        //                       borderRadius: BorderRadius.circular(11),
        //                       boxShadow: const [
        //                         BoxShadow(
        //                           color: Colors.yellowAccent,
        //                           spreadRadius: 1,
        //                         ),
        //                       ],
        //                     ),
        //                     child: Stack(
        //                       children: [
        //                         Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Row(
        //                               children: const [
        //                                 SizedBox(
        //                                   width: 11,
        //                                 ),
        //                                 Text('You Rated'),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text('4.5  '),
        //                                 Icon(
        //                                   Icons.star,
        //                                   size: 15,
        //                                   color: Colors.yellowAccent,
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                         Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Row(
        //                               mainAxisAlignment: MainAxisAlignment.end,
        //                               children: const [
        //                                 Icon(
        //                                   Icons.refresh,
        //                                   size: 15,
        //                                   color: Colors.yellowAccent,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text('Repeat Order'),
        //                                 SizedBox(
        //                                   width: 11,
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(5),
        //         child: Container(
        //           height: 165,
        //           width: double.infinity,
        //           decoration: const BoxDecoration(
        //             color: Colors.white,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.grey,
        //                 spreadRadius: 0.5,
        //               ),
        //             ],
        //             borderRadius: BorderRadius.all(Radius.circular(11),),
        //           ),
        //           child: Stack(
        //             children: [
        //               Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Stack(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Container(
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(15),
        //                               image: const DecorationImage(image: AssetImage('assets/food.png'),
        //                                 fit: BoxFit.cover,
        //                               ),
        //                             ),
        //                             width: 75,
        //                             height: 50,
        //                           ),
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: const [
        //                               Text('The Special Dosa',
        //                                 style: TextStyle(
        //                                   color: Colors.black,
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text('Rohini, New Delhi',
        //                                 style: TextStyle(
        //                                   color: Colors.grey,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: const [
        //                           Text('₹100',style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                           ),),
        //                           SizedBox(
        //                             width: 11,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const SizedBox(
        //                         width: 5,
        //                       ),
        //                       Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: const [
        //                           Text('Items',style: TextStyle(
        //                             color: Colors.grey,
        //                           ),),
        //                           SizedBox(
        //                             height: 2,
        //                           ),
        //                           Text('1x Masala Dosa',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Stack(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: const [
        //                               Text('Ordered On',style: TextStyle(
        //                                 color: Colors.grey,
        //                               ),),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text('October 10, 2021 at 4:55pm',style: TextStyle(
        //                                 color: Colors.black,
        //                               ),),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: const [
        //                           Text('Status: ',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                           Icon(
        //                             Icons.check_circle,
        //                             color: Colors.green,
        //                             size: 15,
        //                           ),
        //                           Text(' Delivered',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 7,
        //                   ),
        //                   Container(
        //                     width: double.infinity,
        //                     height: 25,
        //                     decoration: BoxDecoration(
        //                       color: const Color.fromRGBO(255, 252, 222, 1),
        //                       borderRadius: BorderRadius.circular(11),
        //                       boxShadow: const [
        //                         BoxShadow(
        //                           color: Colors.yellowAccent,
        //                           spreadRadius: 1,
        //                         ),
        //                       ],
        //                     ),
        //                     child: Stack(
        //                       children: [
        //                         Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Row(
        //                               children: const [
        //                                 SizedBox(
        //                                   width: 11,
        //                                 ),
        //                                 Text('You Rated'),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text('4.5  '),
        //                                 Icon(
        //                                   Icons.star,
        //                                   size: 15,
        //                                   color: Colors.yellowAccent,
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                         Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Row(
        //                               mainAxisAlignment: MainAxisAlignment.end,
        //                               children: const [
        //                                 Icon(
        //                                   Icons.refresh,
        //                                   size: 15,
        //                                   color: Colors.yellowAccent,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text('Repeat Order'),
        //                                 SizedBox(
        //                                   width: 11,
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //       const SizedBox(
        //         height: 5,
        //       ),
        //       Padding(
        //         padding: const EdgeInsets.all(5),
        //         child: Container(
        //           height: 165,
        //           width: double.infinity,
        //           decoration: const BoxDecoration(
        //             color: Colors.white,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.grey,
        //                 spreadRadius: 0.5,
        //               ),
        //             ],
        //             borderRadius: BorderRadius.all(Radius.circular(11),),
        //           ),
        //           child: Stack(
        //             children: [
        //               Column(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Stack(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Container(
        //                             decoration: BoxDecoration(
        //                               borderRadius: BorderRadius.circular(15),
        //                               image: const DecorationImage(image: AssetImage('assets/food.png'),
        //                                 fit: BoxFit.cover,
        //                               ),
        //                             ),
        //                             width: 75,
        //                             height: 50,
        //                           ),
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: const [
        //                               Text('The Special Dosa',
        //                                 style: TextStyle(
        //                                   color: Colors.black,
        //                                 ),
        //                               ),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text('Rohini, New Delhi',
        //                                 style: TextStyle(
        //                                   color: Colors.grey,
        //                                 ),
        //                               ),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: const [
        //                           Text('₹100',style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                           ),),
        //                           SizedBox(
        //                             width: 11,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Row(
        //                     mainAxisAlignment: MainAxisAlignment.start,
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       const SizedBox(
        //                         width: 5,
        //                       ),
        //                       Column(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: const [
        //                           Text('Items',style: TextStyle(
        //                             color: Colors.grey,
        //                           ),),
        //                           SizedBox(
        //                             height: 2,
        //                           ),
        //                           Text('1x Masala Dosa',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 5,
        //                   ),
        //                   Stack(
        //                     children: [
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.start,
        //                         crossAxisAlignment: CrossAxisAlignment.start,
        //                         children: [
        //                           const SizedBox(
        //                             width: 5,
        //                           ),
        //                           Column(
        //                             mainAxisAlignment: MainAxisAlignment.start,
        //                             crossAxisAlignment: CrossAxisAlignment.start,
        //                             children: const [
        //                               Text('Ordered On',style: TextStyle(
        //                                 color: Colors.grey,
        //                               ),),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text('October 10, 2021 at 4:55pm',style: TextStyle(
        //                                 color: Colors.black,
        //                               ),),
        //                             ],
        //                           ),
        //                         ],
        //                       ),
        //                       Row(
        //                         mainAxisAlignment: MainAxisAlignment.end,
        //                         children: const [
        //                           Text('Status: ',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                           Icon(
        //                             Icons.check_circle,
        //                             color: Colors.green,
        //                             size: 15,
        //                           ),
        //                           Text(' Delivered',style: TextStyle(
        //                             color: Colors.black,
        //                           ),),
        //                           SizedBox(
        //                             width: 5,
        //                           ),
        //                         ],
        //                       ),
        //                     ],
        //                   ),
        //                   const SizedBox(
        //                     height: 7,
        //                   ),
        //                   Container(
        //                     width: double.infinity,
        //                     height: 25,
        //                     decoration: BoxDecoration(
        //                       color: const Color.fromRGBO(255, 252, 222, 1),
        //                       borderRadius: BorderRadius.circular(11),
        //                       boxShadow: const [
        //                         BoxShadow(
        //                           color: Colors.yellowAccent,
        //                           spreadRadius: 1,
        //                         ),
        //                       ],
        //                     ),
        //                     child: Stack(
        //                       children: [
        //                         Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Row(
        //                               children: const [
        //                                 SizedBox(
        //                                   width: 11,
        //                                 ),
        //                                 Text('You Rated'),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text('4.5  '),
        //                                 Icon(
        //                                   Icons.star,
        //                                   size: 15,
        //                                   color: Colors.yellowAccent,
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                         Column(
        //                           mainAxisAlignment: MainAxisAlignment.center,
        //                           children: [
        //                             Row(
        //                               mainAxisAlignment: MainAxisAlignment.end,
        //                               children: const [
        //                                 Icon(
        //                                   Icons.refresh,
        //                                   size: 15,
        //                                   color: Colors.yellowAccent,
        //                                 ),
        //                                 SizedBox(
        //                                   width: 5,
        //                                 ),
        //                                 Text('Repeat Order'),
        //                                 SizedBox(
        //                                   width: 11,
        //                                 ),
        //                               ],
        //                             ),
        //                           ],
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ],
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}
