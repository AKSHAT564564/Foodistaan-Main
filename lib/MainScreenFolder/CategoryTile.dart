import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FoodCategories extends StatelessWidget {
  String ImagePath = "";
  String Caption = "";
  bool isSelected;
  FoodCategories({
    required this.ImagePath,
    required this.Caption,
    this.isSelected = true,
  });
  @override
  Widget build(BuildContext context) {
    var h1 = MediaQuery.of(context).size.height;
    var w1 = MediaQuery.of(context).size.width;
    return Container(
      height: h1 / 8,
      width: 2 * w1 / 5,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.15),
            spreadRadius: 3,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected
              ? Color(0xffFAB84C)
              : Colors.black, // red as border color
          width: 2,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.5),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                ImagePath,
                height: MediaQuery.of(context).size.height * 0.018,
              ),
              SizedBox(
                height: 2.5,
              ),
              Text(
                Caption,
                style: TextStyle(
                  color: Colors.black, fontSize: 5,
                  // color: Color(0xFF1E2019),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
