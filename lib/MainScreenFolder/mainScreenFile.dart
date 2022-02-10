import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:foodistan/profile/user_profile.dart';
import 'package:foodistan/providers/user_data_provider.dart';
import '../scanner.dart';
import 'HomeScreenFile.dart';
import 'package:provider/provider.dart';

//Main screen contains bottom nav bar
//which contains all the main screens

class MainScreen extends StatefulWidget {
  int currentIndex;
  MainScreen({this.currentIndex = 0});
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  String? userNumber = FirebaseAuth.instance.currentUser!.phoneNumber;

  // PageController _pageController = PageController();
  // TabController? tabController;

  @override
  void initState() {
    super.initState();

    Provider.of<UserDataProvider>(context, listen: false).getUserData();

    // _pageController = PageController(initialPage: widget.currentIndex);
    // tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    // _pageController.dispose();
    super.dispose();
  }

  var screens = [
    HomeScreen(), //HomeScreenFile
    CartScreenMainLogin(),
    ScannerScreen(),
    UserProfile(),
  ];

  Widget build(BuildContext context) {
    final Color selected = Color.fromRGBO(247, 193, 43, 1);
    final Color unselected = Colors.grey;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: BottomAppBar(
            child: TabBar(
              labelColor: selected,
              unselectedLabelColor: unselected,
              isScrollable: false,
              enableFeedback: true,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Theme.of(context).primaryColor,
              indicator: UnderlineTabIndicator(
                insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
                borderSide: BorderSide(color: selected, width: 1.5),
              ),
              tabs: [
                Tab(
                  icon: Icon(CupertinoIcons.home),
                  iconMargin: EdgeInsets.only(bottom: 4),
                  text: 'Home',
                ),
                Tab(
                  icon: Icon(CupertinoIcons.cart),
                  iconMargin: EdgeInsets.only(bottom: 4),
                  text: 'Cart',
                ),
                Tab(
                  icon: Icon(CupertinoIcons.qrcode_viewfinder),
                  iconMargin: EdgeInsets.only(bottom: 4),
                  text: 'Scan',
                ),
                Tab(
                  icon: Icon(CupertinoIcons.profile_circled),
                  iconMargin: EdgeInsets.only(bottom: 4),
                  text: 'Profile',
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: screens,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: OrderFunction().fetchCurrentOrder(userNumber),
              ),
            )
          ],
        ),
      ),
      //   child: BottomAppBar(
      //     child: TabBar(
      //       labelColor: selected,
      //       unselectedLabelColor: unselected,
      //       isScrollable: false,
      //       enableFeedback: true,
      //       indicatorSize: TabBarIndicatorSize.tab,
      //       indicatorColor: Theme.of(context).primaryColor,
      //       indicator: UnderlineTabIndicator(
      //         insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
      //         borderSide: BorderSide(color: selected, width: 1.5),
      //       ),
      //       tabs: [
      //         Tab(
      //           icon: Icon(CupertinoIcons.home),
      //           iconMargin: EdgeInsets.only(bottom: 4),
      //           text: 'Home',
      //         ),
      //         Tab(
      //           icon: Icon(CupertinoIcons.cart),
      //           iconMargin: EdgeInsets.only(bottom: 4),
      //           text: 'Cart',
      //         ),
      //         Tab(
      //           icon: Icon(CupertinoIcons.qrcode_viewfinder),
      //           iconMargin: EdgeInsets.only(bottom: 4),
      //           text: 'Scan',
      //         ),
      //         Tab(
      //           icon: Icon(CupertinoIcons.profile_circled),
      //           iconMargin: EdgeInsets.only(bottom: 4),
      //           text: 'Profile',
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
