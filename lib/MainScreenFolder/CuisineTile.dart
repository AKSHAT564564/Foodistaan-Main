import 'package:flutter/material.dart';
import 'package:foodistan/constants.dart';
import 'package:sizer/sizer.dart';

class CuisineTileList extends StatelessWidget {
  List CuisineTiles = [
    Cuisines(
      Text1: "BURGER",
      Text2: "BOMB",
      FoodImage: 'Images/burger.png',
      BorderColor: const Color(0xFFF03636),
      BgColor: const Color(0xFFFFE7E7),
    ),
    Cuisines(
        Text1: "FUSION",
        Text2: "FRIES",
        FoodImage: 'Images/burger.png',
        BorderColor: const Color(0xFFFFE800),
        BgColor: const Color(0xFFFFFCDE)),
    Cuisines(
        Text1: "BURGER",
        Text2: "BOMB",
        FoodImage: 'Images/burger.png',
        BorderColor: const Color(0xFFA0FF00),
        BgColor: const Color(0xFFEFFFD4)),
    Cuisines(
        Text1: "BURGER",
        Text2: "BOMB",
        FoodImage: 'Images/burger.png',
        BorderColor: const Color(0xFF00CCFF),
        BgColor: const Color(0xFFE9F9FD)),
    Cuisines(
      Text1: "BURGER",
      Text2: "BOMB",
      FoodImage: 'Images/burger.png',
      BorderColor: const Color(0xFFF03636),
      BgColor: const Color(0xFFFFE7E7),
    ),
    Cuisines(
        Text1: "FUSION",
        Text2: "FRIES",
        FoodImage: 'Images/burger.png',
        BorderColor: const Color(0xFFFFE800),
        BgColor: const Color(0xFFFFFCDE)),
    Cuisines(
        Text1: "BURGER",
        Text2: "BOMB",
        FoodImage: 'Images/burger.png',
        BorderColor: const Color(0xFFA0FF00),
        BgColor: const Color(0xFFEFFFD4)),
    Cuisines(
        Text1: "BURGER",
        Text2: "BOMB",
        FoodImage: 'Images/burger.png',
        BorderColor: const Color(0xFF00CCFF),
        BgColor: const Color(0xFFE9F9FD)),
  ];

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    // var w1 = MediaQuery.of(context).size.width;
    return Container(
      height: h1 * 0.1635,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: CuisineTiles.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: 11,
              top: 11,
              bottom: 11,
            ),
            child: CuisineTiles[index],
          );
        },
      ),
    );
  }
}

class Cuisines extends StatelessWidget {
  String Text1 = "";
  String Text2 = "";
  String FoodImage = "";
  Color BgColor;
  Color BorderColor;

  Cuisines({
    required this.Text1,
    required this.Text2,
    required this.FoodImage,
    required this.BorderColor,
    required this.BgColor,
  });

  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        // color: BgColor,
        color: kGreyLight,

        borderRadius: BorderRadius.circular(10.sp),
      ),
      child: Column(
        children: [
          Container(
            width: w1 / 4.65,
            height: h1 / 9.5,
            decoration: BoxDecoration(
              // color: BgColor,
              borderRadius: BorderRadius.circular(10.sp),
              border: Border.all(
                // color: BorderColor, // red as border color
                // color: kYellow,
                // color: Colors.black,
                color: Colors.transparent,
                width: 1.5,
              ),
            ),
            child: GestureDetector(
              onTap: () {},
              child: FittedBox(
                fit: BoxFit.contain,
                child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text(Text2,
                      //         style: TextStyle(
                      //           color: BorderColor,
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: w1 / 25,
                      //         ),
                      //         textAlign: TextAlign.left),
                      //   ],
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Image.asset(
                            FoodImage,
                            width: w1 * 0.07,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            Text1,
            style: TextStyle(
              color: Colors.black,
              fontSize: h1 / 60,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
    // return Container(
    //   width: w1 / 4,
    //   decoration: BoxDecoration(
    //     color: BgColor,
    //     borderRadius: BorderRadius.circular(8),
    //     border: Border.all(
    //       color: BorderColor, // red as border color
    //       width: 1.5,
    //     ),
    //   ),
    // child: GestureDetector(
    //   onTap: () {},
    //   child: FittedBox(
    //     fit: BoxFit.contain,
    //     child: Padding(
    //       padding: const EdgeInsets.all(2),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.end,
    //         children: [
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 Text1,
    //                 style: TextStyle(
    //                   color: Colors.black,
    //                   fontSize: h1 / 88,
    //                 ),
    //                 textAlign: TextAlign.left,
    //               ),
    //               Text(Text2,
    //                   style: TextStyle(
    //                     color: BorderColor,
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: w1 / 25,
    //                   ),
    //                   textAlign: TextAlign.left),
    //             ],
    //           ),
    //           Row(
    //             mainAxisAlignment: MainAxisAlignment.end,
    //             mainAxisSize: MainAxisSize.max,
    //             children: [
    //               Image.asset(
    //                 FoodImage,
    //                 width: w1 * 0.07,
    //               ),
    //             ],
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ),
    // );
  }
}
