import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/functions/order_functions.dart';
import 'package:foodistan/profile/user_profile.dart';
import '../scanner.dart';
import 'HomeScreenFile.dart';

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

  PageController _pageController = PageController();
  TabController? tabController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.currentIndex);
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
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
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        notchMargin: 4,
        shape: CircularNotchedRectangle(),
        child: SizedBox(
          height: 60,
          child: TabBar(
            labelColor: selected,
            unselectedLabelColor: unselected,
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Theme.of(context).primaryColor,
            controller: tabController,
            indicator: UnderlineTabIndicator(
              insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 60.0),
              borderSide: BorderSide(color: selected, width: 1.5),
            ),
            onTap: (value) {
              widget.currentIndex = value;
              _pageController.jumpToPage(value);
            },
            tabs: [
              Tab(
                icon: Icon(CupertinoIcons.home),
                iconMargin: EdgeInsets.only(bottom: 5),
                text: 'Home',
              ),
              Tab(
                icon: Icon(CupertinoIcons.cart),
                iconMargin: EdgeInsets.only(bottom: 5),
                text: 'Cart',
              ),
              Tab(
                icon: Icon(CupertinoIcons.qrcode_viewfinder),
                iconMargin: EdgeInsets.only(bottom: 5),
                text: 'Scan',
              ),
              Tab(
                icon: Icon(CupertinoIcons.profile_circled),
                iconMargin: EdgeInsets.only(bottom: 5),
                text: 'Profile',
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //     currentIndex: widget.currentIndex,
      //     onTap: (index) => setState(() {
      //           widget.currentIndex = index;
      //           _pageController.jumpToPage(widget.currentIndex);
      //         }),
      //     type: BottomNavigationBarType.fixed,
      //     iconSize: 16,
      //     unselectedItemColor: unselected,
      //     selectedItemColor: selected,
      //     backgroundColor: Colors.white,
      //     showUnselectedLabels: true,
      //     showSelectedLabels: true,
      //     elevation: 2,
      //     items: <BottomNavigationBarItem>[
      //       BottomNavigationBarItem(
      //         label: 'Home',
      //         icon: Column(children: [
      //           Divider(
      //             color: Colors.red,
      //           ),
      //           SvgPicture.asset(
      //             'Images/bottomhome.svg',
      //             color: widget.currentIndex == 0 ? selected : unselected,
      //           ),
      //         ]),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Cart',
      //         icon: SvgPicture.asset(
      //           'Images/bottomcart.svg',
      //           color: widget.currentIndex == 1 ? selected : unselected,
      //         ),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Scan',
      //         icon: SvgPicture.asset(
      //           'Images/bottomscan.svg',
      //           color: widget.currentIndex == 2 ? selected : unselected,
      //         ),
      //       ),
      //       BottomNavigationBarItem(
      //         label: 'Profile',
      //         icon: SvgPicture.asset(
      //           'Images/bottomprofile.svg',
      //           color: widget.currentIndex == 3 ? selected : unselected,
      //         ),
      //       ),
      //     ]),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            children: screens,
          ),

          //Checks if any current orders exists for the current user
          //uses Stream Builder for live updates
          //returns a widget like a bottom NAVBAR
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: OrderFunction().fetchCurrentOrder(userNumber),
            ),
          )
        ],
      ),
    );
  }
}
