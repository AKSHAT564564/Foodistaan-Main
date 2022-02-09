import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FsPoints extends StatelessWidget {
  const FsPoints({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Streato Points',style: TextStyle(
          color: Colors.black,
        ),),
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(11),
              child: Container(
                height: h*0.3,
                width: w*0.15,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(247, 193, 43, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text('Help',style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: h*0.5,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          Container(
                            height: h*0.47,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(89, 159, 253, 1),
                                  Color.fromRGBO(15, 27, 43, 1),
                                ],
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: h*0.045,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(33),
                                            ),
                                            child: Center(
                                              child: Text('Points',style: TextStyle(
                                                color: Color.fromRGBO(44, 79, 126, 1),
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: SvgPicture.asset('Images/pointslogo.svg',
                                            height: h*0.05,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Container(
                                            height: h*0.045,
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(33),
                                            ),
                                            child: Center(
                                              child: Text('History',style: TextStyle(
                                                color: Color.fromRGBO(44, 79, 126, 1),
                                                fontWeight: FontWeight.bold,
                                              ),),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      height: h*0.2,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Container(
                                                  height: h*0.066,
                                                  width: w*0.11,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(44, 79, 126, 1),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: w*0.1,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 11,
                                                ),
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Your Streato Points Balance',style: TextStyle(
                                                      color: Colors.grey,
                                                    ),),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SvgPicture.asset('Images/pointslogo.svg',
                                                          height: h*0.03,
                                                        ),
                                                        SizedBox(
                                                          width: 11,
                                                        ),
                                                        Text('700',style: TextStyle(
                                                          color: Color.fromRGBO(44, 79, 126, 1),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: w*0.05,
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(
                                                vertical: 7,
                                              ),
                                              child: Divider(
                                                color: Colors.grey,
                                              ),
                                            ),
                                            Stack(
                                              children: [
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                    Icons.warning_amber,
                                                    color: Color.fromRGBO(247, 193, 43, 1),
                                                    size: w*0.055,
                                                  ),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('500 Streato Points',style: TextStyle(
                                                          color: Color.fromRGBO(44, 79, 126, 1),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: w*0.035,
                                                        ),),
                                                        Text('Expiry- 01 Jan 2022',style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: w*0.031,
                                                        ),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {},
                                                      child: Container(
                                                        height: h*0.035,
                                                        width: w*0.3,
                                                        decoration: BoxDecoration(
                                                          color: Color.fromRGBO(44, 79, 126, 1),
                                                          borderRadius: BorderRadius.circular(11),
                                                        ),
                                                        child: Center(
                                                            child: Text('Use Now',style: TextStyle(
                                                              color: Colors.white,
                                                            ),),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                    ),
                                    child: Text('◆ Streato Points will be credited in your account within 24 hours since you place an order.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w*0.035,
                                    ),),
                                  ),
                                  SizedBox(
                                    height: 11,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 22,
                                    ),
                                    child: Text('◆ You can\'t use Streato Points after they expire, they will be of no use.',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: w*0.035,
                                    ),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: h*0.43,
                              ),
                              GestureDetector(
                                onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 25,
                                    ),
                                    child: Container(
                                      height: h*0.07,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color.fromRGBO(247, 193, 43, 1),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 4,
                                        ),
                                      ),
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.event_note,
                                              size: h*0.03,
                                              color: Colors.black,
                                            ),
                                            SizedBox(
                                              width: 11,
                                            ),
                                            Text('Enter Order ID To Claim Streato Points',style: TextStyle(
                                              color: Colors.black,
                                              fontSize: w*0.032,
                                              fontWeight: FontWeight.w500,
                                            ),),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 25,
                  ),
                  child: Container(
                    height: h*0.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 7,
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Definate Earning For You !!',style: TextStyle(
                            color: Color.fromRGBO(44, 79, 126, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: w*0.033,
                          ),),
                          SizedBox(
                            height: 11,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('₹ 500 = 500',style: TextStyle(
                                color: Color.fromRGBO(44, 79, 126, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: w*0.05,
                              ),),
                              SizedBox(
                                width: 5,
                              ),
                              SvgPicture.asset('Images/pointslogo.svg',
                                height: h*0.03,
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.5,
                            ),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Text('This means if you spend ₹500 to place an order, you will earn 500 Streato Points.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: w*0.033,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 25,
                  ),
                  child: Container(
                    height: h*0.2,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade300,
                          spreadRadius: 7,
                          blurRadius: 5,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ultimate Savings with Streato Points',style: TextStyle(
                            color: Color.fromRGBO(44, 79, 126, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: w*0.033,
                          ),),
                          SizedBox(
                            height: 11,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SvgPicture.asset('Images/pointslogo.svg',
                                height: h*0.03,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text('500 = ₹ 500',style: TextStyle(
                                color: Color.fromRGBO(44, 79, 126, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: w*0.05,
                              ),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5.5,
                            ),
                            child: Divider(
                              color: Colors.grey,
                            ),
                          ),
                          Text('This means if you have earned 500 Streato Points, you will save ₹500 off on future Order.',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: w*0.033,
                          ),),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Frequently Asked Questions',style: TextStyle(
                          color: Color.fromRGBO(50, 91, 145, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: w*0.055,
                        ),),
                        SizedBox(
                          height: 15,
                        ),
                        Text('1. What are Streato Points ?',style: TextStyle(
                          color: Colors.grey.shade600,
                        ),),
                        SizedBox(
                          height: 5,
                        ),
                        Text('2. How to Claim Streato Points ?',style: TextStyle(
                          color: Colors.grey.shade600,
                        ),),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 25,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Terms & Conditions',style: TextStyle(
                          color: Color.fromRGBO(50, 91, 145, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: w*0.055,
                        ),),
                        SizedBox(
                          height: 15,
                        ),
                        Text('Streato Terms and Conditions.',style: TextStyle(
                          color: Colors.grey.shade500,
                        ),),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
              ],
            ),
        ),
      ),
    );
  }
}
