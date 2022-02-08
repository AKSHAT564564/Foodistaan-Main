import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class Offers extends StatefulWidget {
  const Offers({Key? key}) : super(key: key);

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'Offers & Deals of the Day',
          ),
          elevation: 0,
          titleSpacing: 0,
          leadingWidth: 40,
          titleTextStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600, fontSize: 20),
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CarouselSlider(
              items: [
                Image.asset(
                  'Images/offerbanner.png',
                  width: double.infinity,
                ),
                Image.asset(
                  'Images/offerbanner.png',
                  width: double.infinity,
                ),
                Image.asset(
                  'Images/offerbanner.png',
                  width: double.infinity,
                ),
              ],
              options: CarouselOptions(
                enableInfiniteScroll: true,
                autoPlay: false,
                initialPage: 1,
                reverse: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 11,
              ),
              child: SizedBox(
                height: 455,
                width: double.infinity,
                child: GridView.count(
                  physics: BouncingScrollPhysics(),
                  crossAxisCount: 2,
                  children: [
                    Image.asset(
                      'Images/offer1.png',
                      width: double.infinity,
                    ),
                    Image.asset(
                      'Images/offer1.png',
                      width: double.infinity,
                    ),
                    Image.asset(
                      'Images/offer1.png',
                      width: double.infinity,
                    ),
                    Image.asset(
                      'Images/offer1.png',
                      width: double.infinity,
                    ),
                    Image.asset(
                      'Images/offer1.png',
                      width: double.infinity,
                    ),
                    Image.asset(
                      'Images/offer1.png',
                      width: double.infinity,
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
