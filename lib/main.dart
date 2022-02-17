import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodistan/cart_screens/login_pay_cart_screen_main.dart';
import 'package:foodistan/profile/profile_address.dart';
import 'package:foodistan/providers/cart_id_provider.dart';
import 'package:foodistan/providers/restaurant_data_provider.dart';
import 'package:foodistan/providers/restaurant_list_provider.dart';

import 'package:foodistan/providers/total_price_provider.dart';
import 'package:foodistan/providers/user_address_provider.dart';
import 'package:foodistan/providers/user_data_provider.dart';
import 'package:foodistan/providers/user_location_provider.dart';

import 'package:provider/provider.dart';
import 'scanner.dart';
import 'MainScreenFolder/mainScreenFile.dart';
import 'optionScreenFile.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:foodistan/UserLogin/LoginScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        // list of all the providers
        providers: [
          ChangeNotifierProvider<UserDataProvider>(
              create: (_) => UserDataProvider()), //provides user data

          ChangeNotifierProvider<CartIdProvider>(
              create: (_) => CartIdProvider()),
          //provides cart-id for all cart functions
          ChangeNotifierProvider<CartDataProvider>(
              create: (_) =>
                  CartDataProvider()), //provides data for the cart...rename it to cart data provider

          ChangeNotifierProvider<TotalPriceProvider>(
              create: (_) =>
                  TotalPriceProvider()), //provides total price for all items in the cart

          ChangeNotifierProvider<UserAddressProvider>(
              create: (_) => UserAddressProvider()), //provides delivery address

          ChangeNotifierProvider<RestaurantListProvider>(
              create: (_) =>
                  RestaurantListProvider()), //provides list of all the restaurants on the home page
          //also sort them according to the user locations

          ChangeNotifierProvider<UserLocationProvider>(
              create: (_) =>
                  UserLocationProvider()) // provides a GEOPOINT of user location from firebase
        ],
        builder: (context, child) {
          return MaterialApp(
            // check if the user has already logged in

            // if not redirects to login screen
            initialRoute: FirebaseAuth.instance.currentUser != null ? 'H' : 'L',
            routes: {
              'S': (context) => ScannerScreen(),
              'L': (context) => LoginScreen(), //login Screen
              'H': (context) => MainScreen(), // Welcome Screen
              'O': (context) => OptionScreen(),
              CartScreenMainLogin().routeName: (context) =>
                  CartScreenMainLogin(), // main Cart screen on home page
            },
            debugShowCheckedModeBanner: false,
            title: 'Streato',
            theme: ThemeData(
              // textTheme: GoogleFonts.quicksandTextTheme(
              //   Theme.of(context).textTheme,
              // ),
              textTheme: GoogleFonts.montserratTextTheme(
                Theme.of(context).textTheme,
              ),
              primaryColor: Colors.yellow.shade700,
            ),
          );
        });
  }
}
