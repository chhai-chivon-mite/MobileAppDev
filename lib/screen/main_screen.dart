import 'package:ecom/screen/cart_screen.dart';
import 'package:ecom/screen/home_screen.dart';
import 'package:ecom/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'account_screen.dart';
import 'more_screen.dart';

// Widget class
class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _State();
  }
}

// State class
class _State extends State<MainScreen> {
  int currentNavBarItemIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget body;
    if (currentNavBarItemIndex == 0) {
      body = HomeScreen();
    } else if (currentNavBarItemIndex == 1) {
      body = SearchScreen();
    } else if (currentNavBarItemIndex == 2) {
      body = CartScreen();
    } else if (currentNavBarItemIndex == 3) {
      body = AccountScreen();
    } else {
      body = MoreScreen();
    }

    final bottomNavBar = BottomNavigationBar(
        currentIndex: currentNavBarItemIndex,
        onTap: (index) {
          setState(() {
            currentNavBarItemIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.blueGrey),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
          BottomNavigationBarItem(icon: Icon(Icons.more_horiz), label: 'More'),
        ]);

    return Scaffold(
      body: body,
      bottomNavigationBar: bottomNavBar,
    );
  }

  void test() {
    final sharedPreferenceTask = SharedPreferences.getInstance();
    sharedPreferenceTask.then((sharedPreference) {}).catchError((error) {});
  }
}
