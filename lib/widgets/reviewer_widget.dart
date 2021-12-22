import 'package:flutter/material.dart';

class ReviewerWidget extends StatefulWidget {
  ReviewerWidget({Key? key}) : super(key: key);

  @override
  _ReviewerWidgetState createState() => _ReviewerWidgetState();
}

class _ReviewerWidgetState extends State<ReviewerWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.amber.shade400,
              width: 1.5,
            ),),
        padding: EdgeInsets.all(11),
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.22,
        width: double.infinity,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/images/reviewer.png',
                  ),
                  SizedBox(
                    width: 11,
                  ),
                  Column(
                    children: const [
                      Text(
                        "Tanish Kumar",
                        style: TextStyle(
                          fontSize: 22,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 7,
              ),
              Text(
                "Great place must visit. I ordered few Masala Dosa and it came within a minute. They were crispy and delicious, i would definitely recommend it to you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width*0.035,
                ),
              ),
              SizedBox(
                height: 7,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade400,
                    size: MediaQuery.of(context).size.width*0.05,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade400,
                    size: MediaQuery.of(context).size.width*0.05,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade400,
                    size: MediaQuery.of(context).size.width*0.05,
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amber.shade400,
                    size: MediaQuery.of(context).size.width*0.05,
                  ),
                ],
              ),
            ],
          ),
        ),);
  }
}
