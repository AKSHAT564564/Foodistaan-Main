import 'package:flutter/material.dart';

class MyOptionListView extends StatelessWidget {
  MyOptionListView({
    required this.myIcon,
    required this.myText,
    required this.iconColor,
  });

  String myText;
  IconData myIcon;
  Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      child: Material(
        elevation: 3,
        child: Container(
          height: MediaQuery.of(context).size.height * 0.04,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: MediaQuery.of(context).size.width * 0.4,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  myIcon,
                  color: iconColor,
                  size: MediaQuery.of(context).size.width * 0.033,
                ),
                Text(
                  myText,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: MediaQuery.of(context).size.width * 0.023),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
