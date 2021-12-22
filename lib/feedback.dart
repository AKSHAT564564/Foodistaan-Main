import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {

  String stars = '5' ;

  ratingUpdate(rating) {
    setState(() {
      stars = rating as String ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Feedback',style: TextStyle(
          color: Colors.black,
        ),),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 25,
              ),
              SvgPicture.asset('Images/feedback.svg',
                width: MediaQuery.of(context).size.width*0.5,
              ),
              SizedBox(
                height: 11,
              ),
              Text('Leave a Feedback',style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width*0.077,
              ),),
              SizedBox(
                height: 5,
              ),
              Text('It Will Help Us Improve!',style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width*0.044,
              ),),
              SizedBox(
                height: 11,
              ),
              Container(
                height: MediaQuery.of(context).size.height*0.05,
                width: double.infinity,
                color: Color.fromRGBO(63, 101, 152, 1),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset('Images/pointslogo.svg',
                        width: MediaQuery.of(context).size.width*0.07,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Get 100 Foodistaan Points after you give a Feedback',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width*0.033,
                      ),),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              RatingBar.builder(
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Color.fromRGBO(250, 192, 94, 1),
                ),
                onRatingUpdate: (rating) {
                  ratingUpdate(rating);
                },
                direction: Axis.horizontal,
                allowHalfRating: true,
                tapOnlyMode: false,
                initialRating: 5,
                itemCount: 5,
                itemSize: 33,
                glow: true,
                glowRadius: 1,
                glowColor: Color.fromRGBO(250, 192, 94, 1),
                unratedColor: Colors.grey,
                itemPadding: EdgeInsets.symmetric(
                  horizontal: 5,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text('$stars Out of 5 Stars',style: TextStyle(
                color: Colors.grey,
                fontSize: MediaQuery.of(context).size.width*0.044,
              ),),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    focusColor: Colors.grey,
                    hintText: 'Please give your Feedback.',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7),),
                      borderSide: BorderSide(
                          color: Colors.grey,
                          width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7),),
                      borderSide: BorderSide(
                        color: Colors.grey,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(250, 192, 94, 1),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Center(
                        child: Text('Post',style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width*0.05,
                        ),),
                      ),
                    ),
                  ),
              ),
              SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.07,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Text('Cancel',style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width*0.05,
                        ),),
                      ),
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
